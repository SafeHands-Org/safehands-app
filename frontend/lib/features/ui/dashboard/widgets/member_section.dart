import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/utils.dart';

enum DoseStatus { taken, missed, upcoming }

class MemberDashboardSection extends ConsumerWidget {
  const MemberDashboardSection({super.key, required this.member});

  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final cs = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final dateStr = '${_weekday(now.weekday)}, ${_month(now.month)} ${now.day}';

    final assignments = member.assignments;

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    'Welcome Back, ${member.name}!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateStr,
                    style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  _SummaryRow(medications: assignments),
                  const SizedBox(height: 28),
                  Text(
                    'Your Medications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...assignments.map(
                      (med) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _MedicationCard(med: med),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        )
      ]
    );
  }
  static String _weekday(int d) => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d - 1];
  static String _month(int m) => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m - 1];
}

class _SummaryRow extends StatelessWidget {
  final List<Assignment> medications;
  const _SummaryRow({required this.medications});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final doses = medications
        .where((a) {
          final next = a.schedule.nextDoseTime;
          return next.isAfter(now) && next.day == now.day;
        })
        .toList()
      ..sort((a, b) => a.schedule.nextDoseTime.compareTo(b.schedule.nextDoseTime));
    final takenToday = medications.map((a) => a.todaysTaken);
    final missedToday = medications.map((a) => a.todaysLogs.where((v) => !v.taken));


    int taken = takenToday.length, missed = missedToday.length, upcoming = doses.length;
    return Row(
      children: [
        _SummaryChip(label: 'Taken', count: taken, color: Colors.green),
        const SizedBox(width: 10),
        _SummaryChip(label: 'Missed', count: missed, color: Colors.red),
        const SizedBox(width: 10),
        _SummaryChip(label: 'Upcoming', count: upcoming, color: Colors.orange),
      ],
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _SummaryChip({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final Assignment med;
  const _MedicationCard({required this.med});

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
                      '${med.medicationName} ${med.reference.dosage} ${med.reference.doseForm}',
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
          _DoseRow(dose: med),
        ],
      ),
    );
  }
}

class _DoseRow extends StatelessWidget {
  final Assignment dose;
  const _DoseRow({required this.dose});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: dose.schedule.timesOfDay.map((time) {
        final log = dose.todaysLogs.firstWhereOrNull(
          (element) => element.scheduledTime == time,
        );
        final (icon, color, label) = switch (log?.status) {
          'taken' => (Icons.check_circle, Colors.green, 'Taken'),
          'missed' => (Icons.cancel, Colors.red, 'Missed'),
          _ => (Icons.schedule, Colors.orange, 'Upcoming'),
        };

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(icon, color: color, size: 18),
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