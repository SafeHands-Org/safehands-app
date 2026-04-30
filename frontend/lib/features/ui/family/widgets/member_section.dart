import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/models/medications/family_member_medication.dart';
import 'package:frontend/services/notification_service.dart';
import 'package:frontend/utils/utils.dart';
import 'package:go_router/go_router.dart';

class MemberProfileSection extends ConsumerWidget {
  const MemberProfileSection({super.key, required this.member});
  final Member member;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeAssignments = member.assignments.where((a) => a.assignment.isActive);
    final inactiveAssignments = member.assignments.where((a) => !a.assignment.isActive);
    final currentUser = ref.watch(currentUserProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.go('/family')
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          "${member.name}'s Profile",
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center
        ),
        actions: [
          if (currentUser?.role == UserRole.caregiver)...[
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(Icons.tune, color: cs.onInverseSurface),
              onPressed: () => context.push('/family/members/${member.id}/${member.family.id}',)
            ),
          ],
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
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
                            iconBg: cs.errorContainer,
                            iconColor: cs.error,
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
                          fmId: member.id,
                          fmmId: med.assignment.id,
                          assignment: med.assignment,
                          medication: med.reference,
                          schedule: med.schedule,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (inactiveAssignments.isNotEmpty)...[
                    SectionHeader(title: 'Inactive Medications (${inactiveAssignments.length})'),
                    ...inactiveAssignments.map(
                      (med) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _MedicationDetailCard(
                          fmId: member.id,
                          fmmId: med.assignment.id,
                          assignment: med.assignment,
                          medication: med.reference,
                          schedule: med.schedule,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ],
        ),
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
    required this.fmId,
    required this.fmmId,
    required this.assignment,
  });
  final Medication medication;
  final MedicationSchedule schedule;
  final FamilyMemberMedication assignment;
  final String fmId;
  final String fmmId;
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
                  onPressed: () => context.push('/assignment/$fmId/logs/$fmmId'),
                  style: TextButton.styleFrom(
                    backgroundColor: palette.categoryBlueContainer.withValues(alpha: 0.3),
                    foregroundColor: palette.categoryBlue,
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd, side: BorderSide(color: palette.categoryBlue)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: Text(
                    'View Details',
                    style: tt.bodyMedium!.copyWith(fontWeight: FontWeight.w500, color: palette.categoryBlue),
                  ),
                ),
                TextButton(
                  onPressed: () => context.push(
                    '/assignment/$fmId/edit',
                    extra: assignment,
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: cs.errorContainer.withValues(alpha: 0.3),
                    foregroundColor: cs.error,
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd, side: BorderSide(color: cs.error)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: Text(
                    'Edit',
                    style: tt.bodyMedium!.copyWith(fontWeight: FontWeight.w500, color: cs.error),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final medName = medication.names.isNotEmpty
                      ? medication.names.first
                      : 'your medication';
                  await NotificationService.scheduleOnce(
                    id: fmmId.hashCode,
                    title: '💊 Medication Reminder',
                    body: 'Time to take $medName',
                    seconds: 10,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            '🔔 Test notification will arrive in ~10 seconds'),
                        backgroundColor: Color(0xFF1565C0),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.notifications_outlined, size: 16),
                label: const Text('Test Notification (10s)'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: cs.primary,
                  side: BorderSide(color: cs.outlineVariant),
                  shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.borderRadiusMd),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
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