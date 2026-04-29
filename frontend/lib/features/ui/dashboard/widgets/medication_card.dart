import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/utils.dart';

enum DoseStatus { upcoming, taken, missed }

class MemberMedicationCardList extends ConsumerWidget {
  const MemberMedicationCardList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold();
  }
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
          final next = a.schedule.nextDoseTime;
          return next.isAfter(now) && next.day == now.day;
        })
        .toList()
      ..sort((a, b) => a.schedule.nextDoseTime.compareTo(b.schedule.nextDoseTime));


      return Column(
        children: [
          const SectionHeader(title: 'Upcoming Doses'),
          _buildList(doses)
        ]
      );
    }
  Widget _buildList(List<Assignment> items){
    return Column(
      children: items.map((item) {
        final med = item.reference;
        final member = item.member;
        final schedule = item.schedule;
        print(schedule.nextDoseTime);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _MedicationCard(
            name: med.names.firstOrNull ?? '--',
            dosage: med.dosage,
            time: '${schedule.nextDoseTime}',
            member: member.name,
            status: DoseStatus.upcoming,
          ),
        );
      }).toList(),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  const _MedicationCard({
    required this.name,
    required this.dosage,
    required this.time,
    required this.member,
    required this.status,
  });

  final String name;
  final String dosage;
  final String time;
  final String member;
  final DoseStatus status;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = context.palette;
    final (bg, border, iconBg, iconColor, iconData) = switch (status) {
      DoseStatus.upcoming => (
        cs.surface,
        cs.outlineVariant,
        palette.statusPending.withValues(alpha: 0.12),
        palette.statusPending,
        Icons.access_time,
      ),
      DoseStatus.taken => (
        palette.statusUpToDate.withValues(alpha: 0.12),
        palette.statusUpToDate.withValues(alpha: 0.3),
        palette.statusUpToDate.withValues(alpha: 0.2),
        palette.statusUpToDate,
        Icons.check,
      ),
      DoseStatus.missed => (
        cs.errorContainer,
        cs.error.withValues(alpha: 0.3),
        cs.errorContainer,
        cs.error,
        Icons.close,
      ),
    };
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.borderRadiusCard,
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: iconBg, borderRadius: AppRadius.borderRadiusMd),
                child: Icon(iconData, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      dosage,
                      style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      timeToDisplay(time),
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              UserAvatar(
                name: name,
                radius: 32,
              ),
            ],
          ),
          if (status == DoseStatus.upcoming) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.tertiary,
                      foregroundColor: cs.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Mark as Taken',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: cs.outlineVariant,
                    foregroundColor: cs.onSurfaceVariant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
