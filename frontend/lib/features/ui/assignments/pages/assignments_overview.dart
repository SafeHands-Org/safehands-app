// import 'package:flutter/material.dart';
// import 'package:frontend/features/components/shared/app_gradient_header.dart';
// import 'package:frontend/features/components/styles/app_color.dart';
// import 'package:frontend/features/ui/adherences/pages/adherence_overview.dart';
// import 'package:frontend/features/ui/medications/pages/medication_overview.dart';
// import 'package:frontend/features/ui/schedule/pages/schedule_overview.dart';
// import 'package:go_router/go_router.dart';

// class MemberMedicationView extends StatelessWidget {
//   const MemberMedicationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final tt = Theme.of(context).textTheme;

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(gradient: context.palette.header),
//               child: SafeArea(
//                 bottom: false,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         HeaderIconButton(
//                           icon: Icons.arrow_back,
//                           onPressed: () => context.pop(),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Medical Overview',
//                                   style: tt.headlineLarge!.copyWith(color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             TabBar(
//                               indicatorColor: cs.surface.withValues(alpha: 1.0),
//                               indicatorWeight: 0.1,
//                               dividerColor: cs.primary,
//                               labelColor: cs.surface,
//                               unselectedLabelColor: Colors.white60,
//                               tabs: const [
//                                 Tab(text: 'Medications'),
//                                 Tab(text: 'Schedules'),
//                                 Tab(text: 'Adherence'),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ]
//                 )
//               )
//             ),
//             const Expanded(
//               child: TabBarView(
//                 children: [
//                   MedicationsView(),
//                   SchedulesView(),
//                   AdherenceView(),
//                 ],
//               ),
//             ),
//           ]
//         )
//       )
//     );
//   }
// }