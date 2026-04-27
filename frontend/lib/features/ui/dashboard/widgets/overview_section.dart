// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:frontend/features/components/styles/styles.dart';
// import 'package:frontend/features/providers/utils/collection_providers.dart';
// import 'package:frontend/features/ui/dashboard/widgets/health_metric_card.dart';

// class OverviewSection extends ConsumerWidget {
//   const OverviewSection({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cs = Theme.of(context).colorScheme;
//     final palette = context.palette;
//     final familyAsync = ref.watch(aggregateFamilyProvider);

//     final activeMeds = familyAsync.maybeWhen(
//       data: (fc) => '${fc.activeMeds}',
//       orElse: () => '--',
//     );
//     final adherencePct = familyAsync.maybeWhen(
//       data: (fc) => '${fc.adherencePercentage}',
//       orElse: () => '--',
//     );

//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: HealthMetricCard(
//                 icon: Icons.medication_outlined,
//                 title: 'Active Medications',
//                 value: activeMeds, unit: 'total', change: 0,
//                 iconBg: palette.categoryBlueContainer, iconColor: palette.categoryBlue,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: HealthMetricCard(
//                 icon: Icons.check_circle_outline,
//                 title: 'Adherence Rate',
//                 value: adherencePct, unit: '%', change: 0,
//                 iconBg: palette.categoryGreenContainer, iconColor: palette.categoryGreen,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: HealthMetricCard(
//                 icon: Icons.access_time,
//                 title: 'Pending Doses',
//                 value: '--', unit: 'today', change: 0,
//                 iconBg: palette.categoryGreenContainer, iconColor: palette.categoryGreen,
//               ),
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: HealthMetricCard(
//                 icon: Icons.warning_amber_outlined,
//                 title: 'Medication Alerts',
//                 value: '--', unit: 'items', change: 0,
//                 iconBg: cs.errorContainer, iconColor: cs.error,
//               ),
//             ),
//           ],
//         ),
//       ]
//     );
//   }
// }