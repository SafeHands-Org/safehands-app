import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/shared/settings_tile.dart';
import 'package:frontend/features/components/shared/stat_chip.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/app_color.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';


class MemberProfileBody extends StatelessWidget {
  const MemberProfileBody({super.key, required this.family, this.currentUserId});

  final FamilyCollection family;
  final String? currentUserId;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = context.palette;
    final fm = family.members.firstWhere(
      (m) => m.uid == currentUserId,
      orElse: () => family.members.isNotEmpty ? family.members.first : FamilyMember.empty(),
    );

    final assignments = family.assignments
        .where((a) => a.familyMemberId == fm.id && a.active)
        .toList();
    final meds = assignments
        .map((a) => family.medications.firstWhere((m) => m.id == a.medicationId, orElse: () => Medication.empty()))
        .where((m) => m.isNotEmpty)
        .toList();
    final schedules = family.schedules
        .where((s) => s.fmid == fm.id)
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppGradientHeader(
            leading: HeaderIconButton(
              icon: Icons.arrow_back,
              onPressed: () => context.go('/'),
            ),
            trailing: HeaderIconButton(
              icon: Icons.edit_outlined,
              onPressed: () {},
            ),
            profileRow: Row(
              children: [
                UserAvatar(name: fm.name, radius: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fm.name,
                        style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        fm.risklevel,
                        style: TextStyle(
                          fontSize: 13, color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            statsRow: Row(
              children: [
                Expanded(
                  child: StatChip(
                    value: '${meds.length} Active',
                    label: 'Medications',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatChip(
                    value: '${schedules.length}',
                    label: 'Schedules',
                  ),
                ),
              ],
            ),
          ),

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
                          value: fm.createdAt.toIso8601String().substring(0, 10),
                        ),
                        const SizedBox(height: 12),
                        _ContactRow(
                          icon: Icons.warning_amber_outlined,
                          iconBg: palette.categoryOrangeContainer,
                          iconColor: palette.categoryOrange,
                          label: 'Risk level',
                          value: fm.risklevel,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SectionHeader(
                  title: 'Active Medications',
                  actionLabel: '+',
                  onAction: () => context.push('/medication/new'),
                ),
                if (meds.isEmpty)
                  const EmptyCard(
                    message: 'No active medications.',
                    icon: Icons.medication_outlined,
                  )
                else
                  ...meds.map(
                    (med) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _MedicationDetailCard(
                        medication: med,
                        schedule: schedules.firstWhere(
                          (s) => assignments.any((a) => a.id == s.fmmid && a.medicationId == med.id),
                          orElse: () => MedicationSchedule.empty(),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),

                const SectionHeader(title: 'Admin Actions'),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notification Settings',
                    subtitle: 'Manage medication reminders',
                    iconBg: palette.categoryBlueContainer,
                    iconColor: palette.categoryBlue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: SettingsTile(
                    icon: Icons.calendar_today_outlined,
                    title: 'View Medication History',
                    subtitle: 'Track adherence and patterns',
                    iconBg: cs.primaryContainer,
                    iconColor: cs.primary,
                  ),
                ),
                SettingsTile(
                  icon: Icons.delete_outline,
                  title: 'Remove from Family',
                  subtitle: 'This action cannot be undone',
                  iconBg: cs.errorContainer,
                  iconColor: cs.error,
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
              Text(label, style: tt.bodySmall),
              Text(value, style: tt.bodyMedium)
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

    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

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
                        style: tt.titleMedium
                      ),
                      if (altNames.isNotEmpty)
                        Text('Generic: $altNames', style: tt.labelMedium),
                      Text(
                        '${medication.dosage} · ${medication.doseForm}',
                        style: tt.bodyMedium
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_outlined, color: cs.outline, size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: cs.surface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline, color: cs.error, size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: cs.errorContainer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              'Instructions',
              style: tt.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              medication.instructions,
              style: tt.bodyMedium
            ),

            if (schedule.timesOfDay.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'Daily Schedule',
                style: tt.bodySmall
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: schedule.timesOfDay.map(
                  (time) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: cs.primaryContainer, borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: cs.primary, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: tt.bodySmall
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ],

            const SizedBox(height: 10),
            Divider(color: cs.outline, height: 1),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _InfoCell(
                    label: 'Created',
                    value: medication.createdAt.toIso8601String().substring(0, 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: cs.surface,
                    foregroundColor: cs.outline,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: const Text(
                    'Set Reminder',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
          style: tt.bodySmall)
        ,
        Text(
          value,
          style: tt.bodyMedium
        ),
      ],
    );
  }
}