// class AssignmentDetailView extends StatefulWidget {
//   const AssignmentDetailView({super.key, required this.fmmId, required this.fmId});

//   final String fmmId;
//   final String fmId;

//   @override
//   State<AssignmentDetailView> createState() => AssignmenticationsViewState();
// }

// class AssignmenticationsViewState extends State<AssignmentDetailView> with SingleTickerProviderStateMixin {

//   @override
//   Widget build(BuildContext context) {
//     // final currentUserId = context.read
//     final cs = Theme.of(context).colorScheme;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.memberName,
//           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: cs.primary,
//         iconTheme: const IconThemeData(color: Colors.white),
//         bottom: TabBar(
//           indicatorColor: Colors.white,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white60,
//           tabs: const [
//             Tab(text: 'Medications'),
//             Tab(text: 'Schedules'),
//             Tab(text: 'Adherence'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         children: [
//           MedicationsTab(
//             memberId: widget.memberId,
//             memberName: widget.memberName,
//             currentUserId: widget.memberId,
//           ),
//           // SchedulesTab(memberId: widget.memberId),
//           // AdherenceTab(
//           //   memberId: widget.memberId,
//           //   currentUserId: widget.memberId,
//           // ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:frontend/features/components/shared/state_widget.dart';
// import 'package:frontend/features/providers/providers.dart';
// import 'package:frontend/features/ui/assignments/widgets/assignments_list.dart';
// import 'package:frontend/features/ui/medications/pages/medication_form.dart';
// import 'package:go_router/go_router.dart';

// class MedicationOverview extends ConsumerWidget {
//   const MedicationOverview({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cs = Theme.of(context).colorScheme;
//     final assignmentsAsync = ref.watch(currentAssignmentsProvider);

//     return switch (assignmentsAsync) {
//       AsyncLoading() => const LoadingCard(),
//       AsyncError(:final error) => ErrorCard(message: error.toString()),
//       AsyncData(:final value) when value.isEmpty => const EmptyCard(message: 'No family members found.'),
//       AsyncData(:final value) => Column(
//         children: value.values.expand((e) => e).map(
//           (assignment) => Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: GestureDetector(
//               onTap: () => context.go('/profile'),
//               child: AssignmentCard(assignment: assignment),
//             ),
//           ),
//         ).toList(),
//       ),
//     };
//   }
//   void _showAddSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//       builder: (_) => SizedBox(
//         height: MediaQuery.of(context).size.height * 0.85,
//         child: MedicationFormView(),
//       ),
//     );
//   }
// }

