import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';

enum DoseStatus { taken, missed, upcoming }

class MedicationSchedule {
  final String name;
  final String dosage;
  final String doseForm;
  final String instructions;
  final List<DoseTime> doses;

  const MedicationSchedule({
    required this.name,
    required this.dosage,
    required this.doseForm,
    required this.instructions,
    required this.doses,
  });
}

class DoseTime {
  final String time;
  final DoseStatus status;

  const DoseTime({required this.time, required this.status});
}

const _medications = [
  MedicationSchedule(
    name: 'Advil',
    dosage: '200 mg',
    doseForm: 'tablet',
    instructions: 'Take with food as needed for pain or fever.',
    doses: [
      DoseTime(time: '8:00 AM', status: DoseStatus.taken),
      DoseTime(time: '2:00 PM', status: DoseStatus.missed),
      DoseTime(time: '8:00 PM', status: DoseStatus.upcoming),
    ],
  ),
  MedicationSchedule(
    name: 'Zoloft',
    dosage: '50 mg',
    doseForm: 'tablet',
    instructions: 'Take once daily at the same time each day.',
    doses: [
      DoseTime(time: '9:00 AM', status: DoseStatus.taken),
    ],
  ),
  MedicationSchedule(
    name: 'Amoxil',
    dosage: '500 mg',
    doseForm: 'capsule',
    instructions: 'Take every 8-12 hours. Finish the entire course.',
    doses: [
      DoseTime(time: '7:00 AM', status: DoseStatus.taken),
      DoseTime(time: '3:00 PM', status: DoseStatus.upcoming),
      DoseTime(time: '11:00 PM', status: DoseStatus.upcoming),
    ],
  ),
];

class MemberDashboardView extends StatelessWidget {
  const MemberDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final dateStr =
        '${_weekday(now.weekday)}, ${_month(now.month)} ${now.day}';

    return Scaffold(
      backgroundColor: cs.surfaceContainerLow,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, Malcom!',
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
              _SummaryRow(medications: _medications),
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
              ..._medications.map(
                (med) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _MedicationCard(med: med),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _weekday(int d) => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d - 1];
  static String _month(int m) => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m - 1];
}

class _SummaryRow extends StatelessWidget {
  final List<MedicationSchedule> medications;
  const _SummaryRow({required this.medications});

  @override
  Widget build(BuildContext context) {
    int taken = 0, missed = 0, upcoming = 0;
    for (final med in medications) {
      for (final dose in med.doses) {
        if (dose.status == DoseStatus.taken) taken++;
        if (dose.status == DoseStatus.missed) missed++;
        if (dose.status == DoseStatus.upcoming) upcoming++;
      }
    }

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
  final MedicationSchedule med;
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
                      '${med.name} ${med.dosage} ${med.doseForm}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      med.instructions,
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
          ...med.doses.map((dose) => _DoseRow(dose: dose)),
        ],
      ),
    );
  }
}

class _DoseRow extends StatelessWidget {
  final DoseTime dose;
  const _DoseRow({required this.dose});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final (icon, color, label) = switch (dose.status) {
      DoseStatus.taken    => (Icons.check_circle, Colors.green, 'Taken'),
      DoseStatus.missed   => (Icons.cancel, Colors.red, 'Missed'),
      DoseStatus.upcoming => (Icons.schedule, Colors.orange, 'Upcoming'),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            dose.time,
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
  }
}