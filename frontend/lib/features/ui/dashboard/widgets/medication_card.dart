import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/utils.dart';

enum DoseStatus { upcoming, taken, missed }

class MemberMedicationCardList extends ConsumerWidget {
  const MemberMedicationCardList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => const Scaffold();
}

class CaregiverMedicationCardList extends ConsumerWidget {
  const CaregiverMedicationCardList({super.key, required this.members});
  final List<Member> members;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fid = ref.watch(currentFamilyProvider).value ?? '';
    final membersAsync = ref.watch(aggregateMembershipsProvider(fid));
    final liveMembers = membersAsync.value ?? members;

    final now = DateTime.now();

    final List<({Assignment assignment, String timeStr, DateTime scheduledDt})> allDoses = [];

    for (final m in liveMembers) {
      for (final a in m.assignments) {
        if (a.schedule.isEmpty) continue;

        final daysOfWeek = a.schedule.daysOfWeek;
        if (daysOfWeek.isNotEmpty) {
          final todayWeekday = now.weekday; // 1=Mon ... 7=Sun
          const dayMap = {
            'monday': 1, 'tuesday': 2, 'wednesday': 3, 'thursday': 4,
            'friday': 5, 'saturday': 6, 'sunday': 7,
          };
          final scheduledToday = daysOfWeek.any(
            (d) => dayMap[d.toLowerCase()] == todayWeekday,
          );
          if (!scheduledToday) continue;
        }

        for (final timeStr in a.schedule.timesOfDay) {
          final parts = timeStr.split(':');
          if (parts.length < 2) continue;
          final hour = int.tryParse(parts[0]) ?? 0;
          final minute = int.tryParse(parts[1]) ?? 0;
          final scheduledDt = DateTime(now.year, now.month, now.day, hour, minute);

          final shortTime = timeStr.length >= 5 ? timeStr.substring(0, 5) : timeStr;
          final alreadyLogged = a.todaysLogs.any((log) {
            final logTime = log.scheduledTime.length >= 5
                ? log.scheduledTime.substring(0, 5)
                : log.scheduledTime;
            return logTime == shortTime;
          });
          if (alreadyLogged) continue;

          allDoses.add((
            assignment: a,
            timeStr: shortTime,
            scheduledDt: scheduledDt,
          ));
        }
      }
    }

    final missed = allDoses
        .where((d) => d.scheduledDt.isBefore(now))
        .toList()
      ..sort((a, b) => a.scheduledDt.compareTo(b.scheduledDt));

    final upcoming = allDoses
        .where((d) => !d.scheduledDt.isBefore(now))
        .toList()
      ..sort((a, b) => a.scheduledDt.compareTo(b.scheduledDt));

    if (missed.isEmpty && upcoming.isEmpty) {
      return Column(
        children: [
          const SectionHeader(title: 'Upcoming Doses'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text('All doses logged for today 🎉',
                  style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (missed.isNotEmpty) ...[
          const SectionHeader(title: '⚠️ Missed Doses'),
          ...missed.map((d) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _MedicationCard(
              key: ValueKey('${d.assignment.assignment.id}_${d.timeStr}_missed'),
              assignment: d.assignment,
              scheduledTimeStr: d.timeStr,
              isMissed: true,
            ),
          )),
          const SizedBox(height: 8),
        ],

        if (upcoming.isNotEmpty) ...[
          const SectionHeader(title: 'Upcoming Doses'),
          ...upcoming.take(6).map((d) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _MedicationCard(
              key: ValueKey('${d.assignment.assignment.id}_${d.timeStr}_upcoming'),
              assignment: d.assignment,
              scheduledTimeStr: d.timeStr,
              isMissed: false,
            ),
          )),
          if (upcoming.length > 6)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Center(
                child: Text(
                  '+${upcoming.length - 6} more doses later today',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _MedicationCard extends ConsumerStatefulWidget {
  final Assignment assignment;
  final String scheduledTimeStr;
  final bool isMissed;
  const _MedicationCard({
    super.key,
    required this.assignment,
    required this.scheduledTimeStr,
    required this.isMissed,
  });

  @override
  ConsumerState<_MedicationCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends ConsumerState<_MedicationCard> {
  bool _loggingTaken = false;
  bool _loggingSkipped = false;
  String? _loggedStatus;

  String? _getUserId() {
    final authUser = ref.read(authProvider).value;
    if (authUser != null && (authUser.id?.isNotEmpty ?? false)) return authUser.id!;
    final current = ref.read(currentUserProvider);
    if (current != null && (current.id?.isNotEmpty ?? false)) return current.id!;
    return null;
  }

  String _getTimeStr(Assignment a) => widget.scheduledTimeStr;

  Future<void> _markTaken() async {
    setState(() => _loggingTaken = true);
    final userId = _getUserId();
    if (userId == null) {
      setState(() => _loggingTaken = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Not logged in'),
        backgroundColor: Color(0xFFB62320),
      ));
      return;
    }

    final a = widget.assignment;
    final now = DateTime.now();
    final timeStr = _getTimeStr(a);

    final ok = await ref.read(adherencesProvider.notifier).createLog(
          AdherenceLogRequest(
            familyMemberMedicationId: a.assignment.id,
            scheduledTime: timeStr,
            takenAt: now.toUtc(),
            status: 'taken',
            recordedBy: userId,
          ),
          a.member.id,
        );

    if (!mounted) return;
    setState(() {
      _loggingTaken = false;
      if (ok) _loggedStatus = 'taken';
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok
          ? '✓ ${a.medicationName} marked as taken'
          : 'Failed to log — try again'),
      backgroundColor: ok ? const Color(0xFF17821E) : const Color(0xFFB62320),
      duration: const Duration(seconds: 2),
    ));
  }

  Future<void> _markSkipped() async {
    setState(() => _loggingSkipped = true);
    final userId = _getUserId();
    if (userId == null) {
      setState(() => _loggingSkipped = false);
      return;
    }

    final a = widget.assignment;
    final timeStr = _getTimeStr(a);

    final ok = await ref.read(adherencesProvider.notifier).createLog(
          AdherenceLogRequest(
            familyMemberMedicationId: a.assignment.id,
            scheduledTime: timeStr,
            takenAt: null,
            status: 'skipped',
            recordedBy: userId,
          ),
          a.member.id,
        );

    if (!mounted) return;
    setState(() {
      _loggingSkipped = false;
      if (ok) _loggedStatus = 'skipped';
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok ? 'Dose skipped' : 'Failed to skip — try again'),
      backgroundColor: ok ? const Color(0xFF555555) : const Color(0xFFB62320),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = context.palette;
    final a = widget.assignment;
    final med = a.reference;
    final schedule = a.schedule;

    final timeDisplay = timeToDisplay(widget.scheduledTimeStr);
    final medName = med.names.isNotEmpty ? med.names.first : '--';
    final cardColor = widget.isMissed
        ? Colors.red.withValues(alpha: 0.05)
        : cs.surface;
    final borderColor = widget.isMissed
        ? Colors.red.withValues(alpha: 0.3)
        : cs.outlineVariant;
    final iconColor = widget.isMissed
        ? Colors.red
        : palette.statusPending;
    final iconBg = widget.isMissed
        ? Colors.red.withValues(alpha: 0.12)
        : palette.statusPending.withValues(alpha: 0.12);
    final iconData = widget.isMissed
        ? Icons.warning_amber_rounded
        : Icons.access_time;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: AppRadius.borderRadiusCard,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: AppRadius.borderRadiusMd),
                child: Icon(iconData, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(medName,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface)),
                    Text(med.dosage,
                        style: TextStyle(
                            fontSize: 13, color: cs.onSurfaceVariant)),
                    const SizedBox(height: 2),
                    Text(timeDisplay,
                        style: TextStyle(
                            fontSize: 12, color: cs.onSurfaceVariant)),
                    Text('For: ${a.member.name}',
                        style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurfaceVariant,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              UserAvatar(name: a.member.name, radius: 20),
            ],
          ),
          const SizedBox(height: 12),
          if (_loggedStatus != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _loggedStatus == 'taken'
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _loggedStatus == 'taken'
                      ? Colors.green.withValues(alpha: 0.3)
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _loggedStatus == 'taken'
                        ? Icons.check_circle
                        : Icons.do_not_disturb,
                    color: _loggedStatus == 'taken' ? Colors.green : Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _loggedStatus == 'taken' ? 'Taken' : 'Skipped',
                    style: TextStyle(
                      color: _loggedStatus == 'taken' ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
            children: [
              Expanded(
                child: _loggingTaken
                    ? const Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2)))
                    : ElevatedButton(
                        onPressed: (_loggingTaken || _loggingSkipped || _loggedStatus != null)
                            ? null
                            : _markTaken,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.tertiary,
                          foregroundColor: cs.surface,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 0,
                        ),
                        child: const Text('Mark as Taken',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                      ),
              ),
              const SizedBox(width: 8),
              _loggingSkipped
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : TextButton(
                      onPressed: (_loggingTaken || _loggingSkipped || _loggedStatus != null)
                          ? null
                          : _markSkipped,
                      style: TextButton.styleFrom(
                        backgroundColor: cs.outlineVariant,
                        foregroundColor: cs.onSurfaceVariant,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      child: const Text('Skip',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}