import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
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
    final assignments = members.expand((v) => v.assignments);
    final now = DateTime.now();

    final doses = assignments
        .where((a) {
          if (a.schedule.isEmpty) return false;
          final next = a.schedule.nextDoseTime;
          return next.isAfter(now) && next.day == now.day;
        })
        .toList()
      ..sort((a, b) =>
          a.schedule.nextDoseTime.compareTo(b.schedule.nextDoseTime));

    return Column(
      children: [
        const SectionHeader(title: 'Upcoming Doses'),
        if (doses.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text('No upcoming doses today',
                  style: TextStyle(color: Colors.grey)),
            ),
          )
        else
          ...doses.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _MedicationCard(assignment: item),
              )),
      ],
    );
  }
}

class _MedicationCard extends ConsumerStatefulWidget {
  final Assignment assignment;
  const _MedicationCard({required this.assignment});

  @override
  ConsumerState<_MedicationCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends ConsumerState<_MedicationCard> {
  bool _logging = false;

  Future<void> _markTaken() async {
    setState(() => _logging = true);
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      setState(() => _logging = false);
      return;
    }

    final a = widget.assignment;
    final now = DateTime.now();
    final timeStr = a.schedule.timesOfDay.isNotEmpty
        ? a.schedule.timesOfDay.first
        : '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final ok = await ref.read(adherencesProvider.notifier).createLog(
          AdherenceLogRequest(
            familyMemberMedicationId: a.assignment.id,
            scheduledTime: timeStr,
            takenAt: now,
            status: 'taken',
            recordedBy: currentUser.id!,
          ),
          a.member.id,
        );

    if (!mounted) return;
    setState(() => _logging = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok
          ? '✓ ${a.medicationName} marked as taken'
          : 'Failed to log — try again'),
      backgroundColor:
          ok ? const Color(0xFF17821E) : const Color(0xFFB62320),
      duration: const Duration(seconds: 2),
    ));
  }

  Future<void> _markSkipped() async {
    setState(() => _logging = true);
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      setState(() => _logging = false);
      return;
    }

    final a = widget.assignment;
    final now = DateTime.now();
    final timeStr = a.schedule.timesOfDay.isNotEmpty
        ? a.schedule.timesOfDay.first
        : '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    await ref.read(adherencesProvider.notifier).createLog(
          AdherenceLogRequest(
            familyMemberMedicationId: a.assignment.id,
            scheduledTime: timeStr,
            takenAt: null,
            status: 'skipped',
            recordedBy: currentUser.id!,
          ),
          a.member.id,
        );

    if (!mounted) return;
    setState(() => _logging = false);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = context.palette;
    final a = widget.assignment;
    final med = a.reference;
    final schedule = a.schedule;

    final timeDisplay = schedule.timesOfDay.isNotEmpty
        ? timeToDisplay(schedule.timesOfDay.first)
        : 'No time set';

    final medName = med.names.isNotEmpty ? med.names.first : '--';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.borderRadiusCard,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: palette.statusPending.withValues(alpha: 0.12),
                    borderRadius: AppRadius.borderRadiusMd),
                child: Icon(Icons.access_time,
                    color: palette.statusPending, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medName,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface),
                    ),
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
          Row(
            children: [
              Expanded(
                child: _logging
                    ? const Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(strokeWidth: 2)))
                    : ElevatedButton(
                        onPressed: _markTaken,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.tertiary,
                          foregroundColor: cs.surface,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding:
                              const EdgeInsets.symmetric(vertical: 10),
                          elevation: 0,
                        ),
                        child: const Text('Mark as Taken',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                      ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: _logging ? null : _markSkipped,
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