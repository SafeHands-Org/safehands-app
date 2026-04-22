import 'package:collection/collection.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/types.dart';
import 'package:frontend/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'util_providers.g.dart';

@riverpod
Future<List<Medication>> activeMedications(Ref ref) async {
  final provider = await ref.watch(medicationsProvider.future);
  final reference = await ref.watch(activeAssignmentsProvider.future);

  final assignments = reference.map((e) => e.medicationId);

  return provider.values
    .where((m) => assignments
    .contains(m.id))
    .toList();
}

@riverpod
Future<List<FamilyMemberMedication>> activeAssignments(Ref ref) async {
  final provider = await ref.watch(assignmentsProvider.future);
  final reference = await ref.watch(currentMembersProvider.future);

  return provider.values
    .expand((e) => e)
    .where((value) => value.active && reference
    .containsKey(value.familyMemberId))
    .toList();
}

@riverpod
Future<List<MedicationAdherenceLog>> todaysLogs(Ref ref) async {
  final reference = await ref.watch(currentMembersProvider.future);
  final provider = await ref.watch(adherencesProvider.selectAsync(
    (p) => p.entries.where((obj) => obj.value.any((item) => reference.containsKey(item.fmid)))
  ));

  final MemberLogs logs = {};
  provider.mapIndexed((k, v) => logs);

  return logs.values
    .expand((e) => e)
    .where((log) => log.isToday)
    .toList();
}


@riverpod
Future<List<MedicationSchedule>> upcomingFamilyDoses(Ref ref, [String? fmid]) async {
  final provider = await ref.watch(currentSchedulesProvider.future);
  final reference = await ref.watch(todaysLogsProvider.future);

  final loggedToday = reference.map((e) => e.fmid).toList();

  return provider.values
    .expand((e) => e)
    .where((schedule) => schedule.isScheduledToday && !loggedToday
    .contains(schedule.fmmid))
    .toList();
}

@riverpod
Future<List<MedicationSchedule>> upcomingMemberDoses(Ref ref, String fmid) async {
  final provider = await ref.watch(currentSchedulesProvider.selectAsync((p) => p.entries.where((v) => v.key == fmid)));
  final reference = await ref.watch(todaysLogsProvider.future);

  final MemberSchedules schedules = {};
  provider.mapIndexed((k, v) => schedules);

  final list = reference.where((e) => e.fmid == fmid).toList();
  final loggedToday = list.map((e) => e.fmmid);

  return schedules.values
    .expand((e) => e)
    .where((schedule) => schedule.isScheduledToday && schedule.fmid == fmid && !loggedToday
    .contains(schedule.fmmid))
    .toList();
}

@riverpod
Future<List<Member>> todaysFamilyDoses(Ref ref) async {
  final reference = await ref.watch(currentFamilyProvider.future);
  final provider = await ref.watch(aggregateMembershipsProvider(reference).future);

  final list = provider.where((e) => e.schedules.any((v) => v.isScheduledToday)).toList();
  return list;
}

@riverpod
Future<List<MedicationSchedule>> todaysMemberDoses(Ref ref, String fmid) async {
  final provider = await ref.watch(schedulesProvider.future);
  final member = provider[fmid] ?? [];

  return member
    .where((schedule) => schedule.isScheduledToday && schedule.fmid == fmid)
    .toList();
}

@riverpod
Future<List<FamilyMember>> sortByPriority(Ref ref, List<FamilyMember> memberList) async {
  final members = memberList;
  members.sortByCompare((member) => member.risklevel,(a, b) => priorityRank[a]!.compareTo(priorityRank[b]!));
  return members;
}

@riverpod
Future<List<FamilyMember>> familyStats(Ref ref, List<FamilyMember> memberList) async {
  final members = memberList;
  members.sortByCompare((member) => member.risklevel,(a, b) => priorityRank[a]!.compareTo(priorityRank[b]!));
  return members;
}