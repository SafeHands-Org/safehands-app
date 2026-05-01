import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/ui/dashboard/widgets/medication_card.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/utils.dart';

enum DoseStatus { taken, missed, upcoming }

class MemberDashboardView extends ConsumerWidget {
  const MemberDashboardView({super.key, required this.member});

  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: context.palette.page),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SummaryRow(member: member),
                      const SizedBox(height: 28),
                      const SectionHeader(title: "Today's Medications"),
                      MemberDashboardSection(member: member),
                    ],
                  ),
                ],
              )
            )
          ]
        )
      )
    );
  }
}

class MemberDashboardSection extends ConsumerWidget {
  const MemberDashboardSection({super.key, required this.member});

  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final now = DateTime.now();
    final alreadyLogged = member.todaysLogs;
    final assignments = member.todaysAssignments;

    final List<({Assignment assignment, String timeStr, DateTime scheduledDt})>
    allDoses = [];
    for (final a in assignments) {
      final logsForThisAssignment = alreadyLogged.where((log) => log.fmmid == a.schedule.fmmid);
      for (final timeStr in a.schedule.timesOfDay) {
        final parts = timeStr.split(':');
        if (parts.length < 2) continue;
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;
        final scheduledDt = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );
        final shortTime = timeStr.length >= 5
            ? timeStr.substring(0, 5)
            : timeStr;
        final loggedTimesForThis = logsForThisAssignment.map((v) =>
            v.scheduledTime.length >= 5 ? v.scheduledTime.substring(0, 5) : v.scheduledTime);

        if (loggedTimesForThis.any((v) => v == shortTime)) continue;

        allDoses.add((
          assignment: a,
          timeStr: shortTime,
          scheduledDt: scheduledDt,
        ));
      }
    }

    final missed = allDoses.where((d) => d.scheduledDt.isBefore(now)).toList()
      ..sort((a, b) => a.scheduledDt.compareTo(b.scheduledDt));

    final upcoming = allDoses.where((d) => !d.scheduledDt.isBefore(now)).toList()
      ..sort((a, b) => a.scheduledDt.compareTo(b.scheduledDt));


    if (missed.isEmpty && upcoming.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SummaryRow(member: member),
          const SizedBox(height: 28),
          const SectionHeader(title: 'Upcoming Doses'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                'All doses logged for today 🎉',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      );
    }

    return ListView(
      children: [
      const SizedBox(height: 12),
      _SummaryRow(member: member),
        const SizedBox(height: 12),
        if (missed.isNotEmpty) ...[
          const SectionHeader(title: "Missed Doses"),
          ...missed.map(
            (d) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MedicationCardView(
                key: ValueKey(
                  '${d.assignment.assignment.id}_${d.timeStr}_missed',
                ),
                assignment: d.assignment,
                scheduledTimeStr: d.timeStr,
                isMissed: true,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],

        if (upcoming.isNotEmpty) ...[
          const SectionHeader(title: 'Upcoming Doses'),
          ...upcoming
              .take(6)
              .map(
                (d) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MedicationCardView(
                    key: ValueKey(
                      '${d.assignment.assignment.id}_${d.timeStr}_upcoming',
                    ),
                    assignment: d.assignment,
                    scheduledTimeStr: d.timeStr,
                    isMissed: false,
                  ),
          ),
        ),
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

class _SummaryRow extends StatelessWidget {
  final Member member;
  const _SummaryRow({required this.member});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final alreadyLogged = member.todaysLogs;
    final List<({Assignment assignment, String timeStr, DateTime scheduledDt})>
    allDoses = [];
    for (final a in member.todaysAssignments) {
      final logsForThisAssignment = alreadyLogged.where((log) => log.fmmid == a.schedule.fmmid);
      for (final timeStr in a.schedule.timesOfDay) {
        final parts = timeStr.split(':');
        if (parts.length < 2) continue;
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;
        final scheduledDt = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );
        final shortTime = timeStr.length >= 5
            ? timeStr.substring(0, 5)
            : timeStr;
        final loggedTimesForThis = logsForThisAssignment.map((v) =>
            v.scheduledTime.length >= 5 ? v.scheduledTime.substring(0, 5) : v.scheduledTime);

        if (loggedTimesForThis.any((v) => v == shortTime)) continue;

        allDoses.add((
          assignment: a,
          timeStr: shortTime,
          scheduledDt: scheduledDt,
        ));
      }
    }

    final missedToday = allDoses.where((d) => d.scheduledDt.isBefore(now)).toList()
      ..sort((a, b) => a.scheduledDt.compareTo(b.scheduledDt));

    final takenToday = member.todaysTaken;

    final todayUpcoming = allDoses.where((d) => !d.scheduledDt.isBefore(now)).toList()
      ..sort((a, b) => a.scheduledDt.compareTo(b.scheduledDt));


    int taken = takenToday.length, missed = missedToday.length, upcoming = todayUpcoming.length;
    return Row(
        children: [
        _SummaryChip(label: 'Taken',
          count: taken, textColor: context.palette.categoryGreen,
          boxColor: context.palette.categoryGreenContainer.withAlpha(30)),
          const SizedBox(width: 10),
        _SummaryChip(label: 'Missed',
          count: missed, textColor: cs.error,
          boxColor: cs.errorContainer.withAlpha(30)),
          const SizedBox(width: 10),
        _SummaryChip(label: 'Upcoming',
          count: upcoming, textColor: context.palette.categoryBlue,
          boxColor: context.palette.categoryBlueContainer.withAlpha(30)),
        ],
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.count, required this.boxColor, required this.textColor});

  final String label;
  final int count;
  final Color boxColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: textColor.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: tt.bodySmall?.copyWith(color: textColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _MedicationCard extends StatelessWidget {
  final Assignment med;
  final List<MedicationAdherenceLog> todaysLogs;
  const _MedicationCard({required this.med, required this.todaysLogs});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: cs.secondaryContainer,
                radius: 20,
                child: Icon(Icons.medication, color: cs.secondary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${med.medicationName} ${med.reference.dosage.toUpperCase()} ${med.reference.doseForm}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      med.reference.instructions,
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Text(
            'Schedule',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          _DoseRow(dose: med, todaysLogs: todaysLogs),
        ],
      ),
    );
  }
}

class _DoseRow extends StatelessWidget {
  final Assignment dose;
  final List<MedicationAdherenceLog> todaysLogs;
  const _DoseRow({required this.dose, required this.todaysLogs});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final logsForThis = todaysLogs.where((log) => log.fmmid == dose.schedule.fmmid);
    return Column(
      children: dose.schedule.timesOfDay.map((time) {
        final shortTime = time.length >= 5 ? time.substring(0, 5) : time;
        final loggedTimes = logsForThis.map((v) =>
            v.scheduledTime.length >= 5 ? v.scheduledTime.substring(0, 5) : v.scheduledTime);

        if (loggedTimes.any((v) => v == shortTime)) return const SizedBox.shrink();

        final parts = time.split(':');
        final now = DateTime.now();

        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;
        final scheduledDt = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );

        final (icon, color, label) = switch (scheduledDt.isBefore(now)) {
          false => (Icons.check_circle, context.palette.categoryBlue, 'Upcoming'),
          true => (Icons.cancel, cs.error, 'Missed'),
        };

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(icon, color: cs.outline, size: 18),
              const SizedBox(width: 8),
              Text(
                timeToDisplay(time),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}