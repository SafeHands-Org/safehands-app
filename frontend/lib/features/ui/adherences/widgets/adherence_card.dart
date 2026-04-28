
//import 'package:flutter/material.dart';
//import 'package:frontend/features/components/shared/app_gradient_header.dart';
//import 'package:frontend/features/components/shared/section_header.dart';
//import 'package:frontend/features/components/shared/state_widget.dart';
//import 'package:frontend/features/components/styles/styles.dart';
//import 'package:frontend/models/models.dart';
//import 'package:frontend/utils/utils.dart';
//import 'package:go_router/go_router.dart';
//import 'package:intl/intl.dart';

//class AdherenceLogSection extends StatelessWidget {
//  const AdherenceLogSection({
//    super.key,
//    required this.membership,
//    required this.assigned
//  });

//  final Member membership;
//  final Assignment assigned;

//  @override
//  Widget build(BuildContext context) {
//    final tt = Theme.of(context).textTheme;
//    final palette = context.palette;

//    final member = membership.member;
//    final medication = assigned.reference;

//    final logs = assigned.logs;

//    final takenLogs   = assigned.allTakenLogs;
//    final missedLogs  = assigned.allMissedLogs;
//    final todayLogs   = assigned.todaysLogs;
//    final todayTaken  = assigned.todaysTaken;

//    final medicationName = medication.isNotEmpty ? medication.names.first : 'Medication';
//    final sorted = assigned.sortedLogs;

//    return Scaffold(
//      body: SingleChildScrollView(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//            AppGradientHeader(
//              leading: HeaderIconButton(icon: Icons.arrow_back, onPressed: () => context.pop()),
//              title: medicationName,
//              subtitle: member.isNotEmpty ? member.name : 'Member',
//              statsRow: Row(
//                children: [
//                  Expanded(
//                    child: StatChipSmall(value: medication.dosage, label: 'Dosage'),
//                  ),
//                  const SizedBox(width: 8),
//                  Expanded(
//                    child: StatChipSmall(value: medication.doseForm, label: 'Form'),
//                  ),
//                  const SizedBox(width: 8),
//                  Expanded(
//                    child: StatChipSmall(value: '${logs.length}', label: 'Total Logs'),
//                  ),
//                ],
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  const SectionHeader(title: 'Summary'),
//                  Row(
//                    children: [
//                      Expanded(
//                        child: CircularProgressCard(
//                          value: todayTaken.length,
//                          total: todayLogs.isEmpty ? 1 : todayLogs.length,
//                          type: ProgressType.dosesCompleted,
//                        ),
//                      ),
//                      const SizedBox(width: 12),
//                      Expanded(
//                        child: CircularProgressCard(
//                          value: takenLogs.length,
//                          total: logs.isEmpty ? 1 : logs.length,
//                          type: ProgressType.totalAdherence,
//                        ),
//                      ),
//                      const SizedBox(width: 12),
//                      Expanded(
//                        child: CircularProgressCard(
//                          value: missedLogs.length,
//                          total: logs.isEmpty ? 1 : logs.length,
//                          type: ProgressType.missedDoses,
//                        ),
//                      ),
//                    ],
//                  ),
//                  const SizedBox(height: 24),
//                  const SectionHeader(title: 'Instructions'),
//                  Card(
//                    child: Padding(
//                      padding: const EdgeInsets.all(14),
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Container(
//                            padding: const EdgeInsets.all(8),
//                            decoration: BoxDecoration(color: palette.categoryBlueContainer ,borderRadius: AppRadius.borderRadiusMd),
//                            child: Icon(Icons.info_outline,color: palette.categoryBlue,size: 16),
//                          ),
//                          const SizedBox(width: 12),
//                          Expanded(child: Text(medication.instructions, style: tt.bodySmall)),
//                        ]
//                      )
//                    )
//                  )
//                ],
//              ),
//            ),
//            const SizedBox(height: 24),
//            const SectionHeader(title: 'Adherence Logs'),
//            if (logs.isEmpty)
//              const Padding(
//                padding: EdgeInsets.symmetric(horizontal: 20),
//                child: EmptyCard(
//                  message: 'No adherence logs found for this medication.',
//                  icon: Icons.history_outlined,
//                ),
//              )
//            else
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//              ...sorted.map((log) =>
//                  Padding(
//                    padding: const EdgeInsets.only(bottom: 10),
//                    child: _AdherenceLogCard(log: log),
//                  )
//                ),
//              ],
//            )
//          ]
//        )
//      )
//    );
//  }
//}

//class _AdherenceLogCard extends StatelessWidget {
//  const _AdherenceLogCard({required this.log});
//  final MedicationAdherenceLog log;

//  @override
//  Widget build(BuildContext context) {
//    final palette = context.palette;
//    final cs = Theme.of(context).colorScheme;
//    final tt = Theme.of(context).textTheme;

//    final (bg, border, iconBg, iconColor, iconData, statusLabel) =
//      switch (log.status) {
//        'taken' => (
//          palette.categoryGreen,
//          palette.categoryGreen.withAlpha(220),
//          palette.categoryGreen.withAlpha(240),
//          palette.categoryGreen.withAlpha(250),
//          Icons.check_circle_outline,
//          'Taken',
//        ),

//        'missed' => (
//          cs.error,
//          cs.error.withAlpha(220),
//          cs.error.withAlpha(240),
//          cs.error.withAlpha(250),
//          Icons.cancel_outlined,
//          'Missed',
//        ),

//        _ => (
//          cs.primary,
//          cs.primary.withAlpha(220),
//          cs.primary.withAlpha(240),
//          cs.primary.withAlpha(250),
//          Icons.access_time_outlined,
//          'Scheduled',
//        )
//    };

//    final scheduledDisplay = timeToDisplay(log.scheduledTime);
//    final takenDisplay = log.takenAt != null ? DateFormat('h:mm a').format(log.takenAt!) : null;

//    return Container(
//      padding: const EdgeInsets.all(14),
//      decoration: BoxDecoration(
//        color: bg,
//        borderRadius: BorderRadius.circular(12),
//        border: Border.all(color: border),
//      ),
//      child: Row(
//        children: [
//          Container(
//            padding: const EdgeInsets.all(8),
//            decoration: BoxDecoration(color: iconBg, borderRadius: AppRadius.borderRadiusMd),
//            child: Icon(iconData, color: iconColor, size: 18),
//          ),
//          const SizedBox(width: 12),
//          Expanded(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                Row(
//                  children: [Text('Scheduled $scheduledDisplay', style: tt.bodyMedium)],
//                ),
//                if (takenDisplay != null) ...[
//                  const SizedBox(height: 2),
//                  Text('Taken at $takenDisplay', style: tt.bodySmall),
//                ],
//              ],
//            ),
//          ),
//          Container(
//            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(20)),
//            child: Text(
//              statusLabel,
//              style: tt.labelSmall!.copyWith(fontWeight: FontWeight.w600,color: iconColor),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}


//class StatChipSmall extends StatelessWidget {
//  const StatChipSmall({super.key, required this.value, required this.label});

//  final String value;
//  final String label;

//  @override
//  Widget build(BuildContext context) {
//    final cs = Theme.of(context).colorScheme;
//    final tt = Theme.of(context).textTheme;
//    return Container(
//      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//      decoration: BoxDecoration(
//        color: cs.surface.withValues(alpha: 0.12),
//        borderRadius: AppRadius.borderRadiusLg,
//        border: Border.all(color: cs.surface.withValues(alpha: 0.2)),
//      ),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
//        children: [
//          Text(
//            value,
//            style: tt.titleSmall!.copyWith(
//              fontWeight: FontWeight.w700,
//              color: cs.surface
//            ),
//          ),
//          const SizedBox(height: 2),
//          Text(
//            label,
//            style: tt.bodySmall!.copyWith(color: cs.surface.withValues(alpha: 0.8)),
//          ),
//        ],
//      ),
//    );
//  }
//}