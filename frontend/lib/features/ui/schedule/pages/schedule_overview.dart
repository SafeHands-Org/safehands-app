// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:frontend/features/components/styles/app_theme.dart';
// import 'package:frontend/features/providers/providers.dart';
// import 'package:frontend/features/ui/schedule/widgets/add_schedule_sheet.dart';
// import 'package:frontend/models/collections/collections.dart';
// import 'package:frontend/models/families/family_member.dart';
// import 'package:frontend/models/medications/family_member_medication.dart';
// import 'package:frontend/models/models.dart';
// import 'package:frontend/utils/types.dart';
// import 'package:provider/provider.dart';



// class SchedulesView extends ConsumerWidget {
//   const SchedulesView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final provider = ref.watch(currentSchedulesInfoProvider.select((p) {
//       return (p.value!.$1, p.value!.$2, p.value!.$3.values.expand((e) => e.names).toList());
//     }));

//     switch(provider){
//       case ScheduleOverviewInfo(:final value):
//         final schedules = value.$1;

//         return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: list!.length,
//             itemBuilder: (context, index) => _ScheduleCard(schedules: list[index]),
//           );
//       case AsyncError<MemberSchedules>():
//         // TODO: Handle this case.
//         throw UnimplementedError();
//     }
//   }
// }

// class _ScheduleCard extends StatelessWidget {
//   const _ScheduleCard({required this.schedules});
//   final MedicationSchedule schedules;

//   @override
//   Widget build(BuildContext context) {
//       return Card(
//         margin: const EdgeInsets.only(bottom: 12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//           side: BorderSide(color: Colors.grey.shade200),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(14),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Row(children: [
//               const SizedBox(width: 8),
//               Expanded(child: Text(widget.assignment.medication.nameEntered ?? 'Medication', style: AppTheme.body.copyWith(fontWeight: FontWeight.bold))),
//               TextButton.icon(
//                 onPressed: () => _showAddSheet(context),
//                 icon: const Icon(Icons.add, size: 16),
//                 label: const Text('Add'),
//               ),
//             ]),
//             if (schedules.isEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Text('No schedules yet', style: AppTheme.body.copyWith(color: Colors.grey)),
//               )
//             else
//               ...schedules.map((s) => ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   leading: Icon(Icons.access_time, color: AppTheme.primary),
//                   title: Text(s.displayTime, style: AppTheme.body),
//                   subtitle: Text(
//                     '${s.frequency.toString()} ${s.frequencyUnit}${s.daysOfWeek != null ? ' · ${s.daysOfWeek?.join(', ')}' : ''}',
//                     style: AppTheme.body.copyWith(color: Colors.grey, fontSize: 12),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
//                     onPressed: () => p.removeSchedule(s.id, widget.assignment.id),
//                   ),
//                 )
//               ),
//             ]
//           ),
//         ),
//       );
//     }
//   }

//   void _showAddSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//       builder: (context) => ScheduleFormView()
//     );
//   }
