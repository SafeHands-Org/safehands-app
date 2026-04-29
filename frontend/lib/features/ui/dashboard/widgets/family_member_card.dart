
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class FamilyMemberList extends ConsumerWidget {
  const FamilyMemberList({super.key, required this.members});

  final List<Member> members;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SectionHeader(
          title: 'Family Overview',
          actionLabel: Icons.chevron_right,
          onAction: () => context.go('/family'),
        ),
         _buildList(members)
      ]
    );
  }
  Widget _buildList(List<Member> members) {
    return Column(
      children: members.map((member) => _FamilyMemberCard(member: member)).toList(),
    );
  }
}

class _FamilyMemberCard extends ConsumerWidget {
  const _FamilyMemberCard({required this.member});

  final Member member;

  Color _statusColor(AdherenceStatus s, PaletteExtension palette) => switch (s) {
    AdherenceStatus.allCaughtUp    => palette.statusUpToDate,
    AdherenceStatus.inProgress     => palette.statusPending,
    AdherenceStatus.critical       => palette.statusAttention,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final palette = context.palette;

    final todaysStatus = member.todayMissedCount;
    final status = AdherenceStatus.fromMissedCount(todaysStatus);
    final statColor = _statusColor(status, palette);

    return InkWell(
      onTap: () {
        context.push('/family/members/${member.id}');
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        shadowColor: cs.shadow,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      UserAvatar(name: member.name, radius: 28),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 14, height: 14,
                          decoration: BoxDecoration(
                            color: statColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600,
                            color: cs.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(height: 1, thickness: 1),
              const SizedBox(height: 12),
              _MedicationDetails(
                dosesTaken: member.todayTakenCount,
                dosesTotal: member.todaysDoseCount,
                activeMeds: member.activeMedCount,
                nextDose: member.timeUntilNextDose,
              )
            ],
          ),
        ),
      )
    );
  }
}

class _MedicationDetails extends StatelessWidget{
  const _MedicationDetails({
    required this.dosesTaken,
    required this.dosesTotal,
    required this.activeMeds,
    required this.nextDose,
  });

  final int dosesTaken;
  final int dosesTotal;
  final int activeMeds;
  final String nextDose;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Row(
      children: [
        Expanded(
          child: _StatBox(
            icon: Icons.medication_outlined,
            iconColor: palette.categoryGreen,
            bg: palette.categoryGreenContainer.withValues(alpha: 0.60),
            label: 'Active',
            value: '$activeMeds',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatBox(
            icon: Icons.calendar_today_outlined,
            iconColor: palette.categoryBlue,
            bg: palette.categoryBlueContainer.withValues(alpha: 0.60),
            label: 'Today',
            value: '$dosesTaken/$dosesTotal',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatBox(
            icon: Icons.error_outline,
            iconColor: palette.categoryIndigo,
            bg: palette.categoryIndigoContainer.withValues(alpha: 0.60),
            label: 'Next',
            value: nextDose,
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.icon,
    required this.iconColor,
    required this.bg,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final Color bg;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

