
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/models/models.dart';

class FamilyMemberList extends ConsumerWidget {
  const FamilyMemberList({super.key, required this.members});

  final List<Member> members;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SectionHeader(title: 'Family Overview'),
         _buildList(members)
      ]
    );
  }
  Widget _buildList(List<Member> members) {
    return Column(
      children: members.map((member) => _FamilyMemberCard(member: member))
        .where((v) => v.member.activeMedCount != 0 && v.member.todaysDoseCount != 0)
        .toList(),
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
    final tt = Theme.of(context).textTheme;
    final palette = context.palette;

    final todaysStatus = member.todayMissedCount;
    final status = AdherenceStatus.fromMissedCount(todaysStatus);
    final statColor = _statusColor(status, palette);

    return Card(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvatar(name: member.name, radius: 26),
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
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                            decoration: BoxDecoration(
                              color: statColor.withValues(alpha: 0.1),
                              borderRadius: AppRadius.borderRadiusSm,
                              border: BoxBorder.all(color: statColor)
                            ),
                            child: Text(
                              '${member.activeMedCount} Active',
                              style: tt.labelSmall?.copyWith(color: statColor)
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                            decoration: BoxDecoration(
                              color: palette.categoryBlueContainer.withValues(alpha: 0.7),
                              borderRadius: AppRadius.borderRadiusSm,
                              border: BoxBorder.all(color: palette.categoryBlue)
                            ),
                            child: Text(
                              'Next in ${member.timeUntilNextDose}',
                              style: tt.labelSmall?.copyWith(color: palette.categoryBlue)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _MedicationDetails(
              dosesTaken: member.todayTakenCount,
              dosesTotal: member.todaysDoseCount,
            )
          ],
        ),
      ),
    );
  }
}

class _MedicationDetails extends StatelessWidget{
  const _MedicationDetails({
    required this.dosesTaken,
    required this.dosesTotal,
  });

  final int dosesTaken;
  final int dosesTotal;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          LinearProgressIndicator(
            value: dosesTaken/dosesTotal,
            minHeight: 25,
            borderRadius: AppRadius.borderRadiusPill,
            valueColor: AlwaysStoppedAnimation<Color>(cs.secondary),
            stopIndicatorColor: Colors.green.shade900,
            backgroundColor: Colors.grey.shade200,
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 10),
            child: Text(
              '$dosesTaken/$dosesTotal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: dosesTaken / dosesTotal > 0.2 ? cs.onInverseSurface : cs.onSurface
              ),
            ),
          )
        ],
      ),
    );

    //return Row(
    //  children: [
    //    Expanded(
    //      child: _StatBox(
    //        icon: Icons.medication_outlined,
    //        iconColor: palette.categoryGreen,
    //        bg: palette.categoryGreenContainer.withValues(alpha: 0.60),
    //        label: 'Active',
    //        value: '$activeMeds',
    //      ),
    //    ),
    //    const SizedBox(width: 10),
    //    Expanded(
    //      child: _StatBox(
    //        icon: Icons.calendar_today_outlined,
    //        iconColor: palette.categoryBlue,
    //        bg: palette.categoryBlueContainer.withValues(alpha: 0.60),
    //        label: 'Today',
    //        value: '$dosesTaken/$dosesTotal',
    //      ),
    //    ),
    //    const SizedBox(width: 10),
    //    Expanded(
    //      child: _StatBox(
    //        icon: Icons.error_outline,
    //        iconColor: palette.categoryIndigo,
    //        bg: palette.categoryIndigoContainer.withValues(alpha: 0.60),
    //        label: 'Next',
    //        value: nextDose,
    //      ),
    //    ),
    //  ],
    //);
  }
}

//class _StatBox extends StatelessWidget {
//  const _StatBox({
//    required this.icon,
//    required this.iconColor,
//    required this.bg,
//    required this.label,
//    required this.value,
//  });

//  final IconData icon;
//  final Color iconColor;
//  final Color bg;
//  final String label;
//  final String value;

//  @override
//  Widget build(BuildContext context) {
//    final cs = Theme.of(context).colorScheme;
//    return Container(
//      width: 70,
//      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
//      decoration: BoxDecoration(
//        color: bg,
//        borderRadius: BorderRadius.circular(8),
//        border: BoxBorder.all(color: iconColor)
//      ),
//      child: Column(
//        children: [
//          Icon(icon, color: iconColor, size: 16),
//          const SizedBox(height: 2),
//          Text(
//            label,
//            style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
//          ),
//          Text(
//            value,
//            style: TextStyle(
//              fontSize: 12, fontWeight: FontWeight.w600, color: cs.onSurface,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

