import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/shared/settings_tile.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/ui/family/pages/edit_member.dart';
import 'package:frontend/features/ui/family/widgets/family_headers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/utils.dart';

class MemberProfileSection extends StatelessWidget {
  const MemberProfileSection({super.key, required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    final activeAssignments = member.assignments.where((a) => a.assignment.isActive);
    final inactiveAssignments = member.assignments.where((a) => !a.assignment.isActive);

    final cs = Theme.of(context).colorScheme;
    final palette = context.palette;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MemberOverviewHeader(name: member.name),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Member Information'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _ContactRow(
                          icon: Icons.calendar_today_outlined,
                          iconBg: cs.primaryContainer,
                          iconColor: cs.primary,
                          label: 'Member since',
                          value: member.joinDate,
                        ),
                        const SizedBox(height: 12),
                        _ContactRow(
                          icon: Icons.warning_amber_outlined,
                          iconBg: palette.categoryOrangeContainer,
                          iconColor: palette.categoryOrange,
                          label: 'Risk level',
                          value: member.riskLevel,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                if (activeAssignments.isNotEmpty)...[
                  SectionHeader(title: 'Active Medications (${activeAssignments.length})'),
                  ...activeAssignments.map(
                    (med) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _MedicationDetailCard(
                        medication: med.reference,
                        schedule: med.schedule
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                if (inactiveAssignments.isNotEmpty)...[
                  SectionHeader(title: 'Inactive Medications (${activeAssignments.length})'),
                  ...inactiveAssignments.map(
                    (med) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _MedicationDetailCard(
                        medication: med.reference,
                        schedule: med.schedule
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                if (member.isAdmin)...[
                  const SectionHeader(title: 'Admin Actions'),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: SettingsTile(
                      icon: Icons.calendar_today_outlined,
                      title: "Configure Member's Information",
                      subtitle: "Change ${member.name}'s risk level or remove them",
                      iconBg: cs.primaryContainer,
                      iconColor: cs.primary,
                      onTap: () => _showEditSheet(context, member)
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showEditSheet(BuildContext context, Member member) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.45,
      maxChildSize: 0.55,
      expand: false,
      builder: (_, scrollController) => EditMemberView(member: member)
    ),
  );
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon, required this.iconBg, required this.iconColor,
    required this.label, required this.value,
  });

  final IconData icon;
  final Color iconBg, iconColor;
  final String label, value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                style: tt.bodySmall!.copyWith(fontSize: 11, color: cs.outline)
              ),
              Text('${value[0].toUpperCase()}${value.substring(1)}',
                style: tt.bodyMedium!.copyWith(fontWeight: FontWeight.w500)
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MedicationDetailCard extends StatelessWidget {
  const _MedicationDetailCard({
    required this.medication,
    required this.schedule,
  });

  final Medication medication;
  final MedicationSchedule schedule;

  @override
  Widget build(BuildContext context) {
    final primaryName = medication.names.firstOrNull ?? 'Unknown';
    final altNames = medication.names.skip(1).join(', ');

    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final palette = context.palette;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        primaryName,
                        style: tt.titleSmall!.copyWith(fontWeight: FontWeight.w700)
                      ),
                      if (altNames.isNotEmpty)
                        Text(
                          'Generic: $altNames',
                          style: tt.bodySmall!.copyWith(fontSize: 11),
                        ),
                      Text(
                        '${medication.dosage} · ${medication.doseForm}',
                        style: tt.bodyMedium!.copyWith(color: cs.outline),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_outlined, color: cs.outline , size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: cs.surface,
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              'Instructions',
              style: tt.bodySmall!.copyWith(fontWeight: FontWeight.w600, color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            Text(
              medication.instructions,
              style: tt.bodyMedium!.copyWith(color: cs.outline),
            ),
            if (schedule.timesOfDay.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'Daily Schedule',
                style: tt.bodySmall!.copyWith(fontWeight: FontWeight.w600, color: cs.onSurfaceVariant)
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: schedule.timesOfDay.map(
                  (time) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: cs.primary),
                      color: cs.primaryContainer,
                      borderRadius: AppRadius.borderRadiusMd

                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: cs.primary, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          timeToDisplay(time),
                          style: tt.bodySmall!.copyWith(fontWeight: FontWeight.w500, color: cs.primary),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ],

            const SizedBox(height: 10),
            Divider(color: cs.outlineVariant, height: 1),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _InfoCell(
                    label: 'Added',
                    value: medication.createdAt.toIso8601String().substring(0, 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: palette.categoryBlueContainer,
                    foregroundColor: palette.categoryBlue,
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd, side: BorderSide(color: palette.categoryBlue)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: Text(
                    'View Details',
                    style: tt.bodyMedium!.copyWith(fontWeight: FontWeight.w500, color: palette.categoryBlue),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline, color: cs.outline, size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: cs.errorContainer,
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd, side: BorderSide(color: cs.error)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tt.bodySmall!.copyWith(color: cs.outline)),
        Text(
          value,
          style: tt.bodySmall!.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}