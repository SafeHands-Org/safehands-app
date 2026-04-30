import 'package:collection/collection.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collection_providers.g.dart';

@riverpod
Future<Map<String, FamilyMember>> currentMembers(Ref ref) async {
  final origin = await ref.watch(currentFamilyProvider.future);
  final provider = await ref.watch(familyMembersProvider.future);

  final members = provider.entries.where((v) => v.value.fid == origin);
  final memberMap = Map.fromEntries(members);

  return memberMap;
}

@riverpod
Future<Map<String, List<FamilyMemberMedication>>> currentAssignments(Ref ref) async {
  final reference = await ref.watch(currentMembersProvider.future);
  final provider = await ref.watch(assignmentsProvider.future);

  final assignments = provider.entries.where((v) => reference.containsKey(v.key));
  final assignmentMap = Map.fromEntries(assignments);
  return assignmentMap;
}

@riverpod
Future<Map<String, Medication>> currentMedications(Ref ref) async {
  return await ref.watch(medicationsProvider.future);
}

@riverpod
Future<MemberSchedules> currentSchedules(Ref ref) async {
  final origin = await ref.watch(currentMembersProvider.future);
  final provider = await ref.watch(schedulesProvider.future);

  final schedules = provider.entries.where((v) => origin.keys.contains(v.key));
  final scheduleMap = Map.fromEntries(schedules);

  return scheduleMap;
}

@riverpod
Future<Member> aggregateMember(Ref ref, String fmid) async {
  final familyId = await ref.watch(currentFamilyProvider.future);
  final collection = await ref.watch(aggregateMembershipsProvider(familyId).future);
  final aggregate = collection.firstWhere((c) => c.id == fmid);
  return aggregate;
}

@riverpod
Future<List<Member>> aggregateMemberships(Ref ref, String fid) async {
  final members   = await ref.watch(familyMembersProvider.future);
  final assignments = await ref.watch(assignmentsProvider.future);
  final meds      = await ref.watch(medicationsProvider.future);
  final logs      = await ref.watch(adherencesProvider.future);
  final schedules = await ref.watch(schedulesProvider.future);
  final families  = await ref.watch(familiesProvider.future);
  
  print(families.keys);

  final family = families[fid]!;


  final memberships = Map<String, FamilyMember>.from(members);
  memberships.removeWhere((k, v) => v.fid != fid);

  List<Assignment> assignmentList = [];

  for (final member in memberships.values) {
    final memberAssignments = assignments[member.id] ?? [];
    final memberSchedules   = schedules[member.id] ?? [];
    final memberLogs        = logs[member.id] ?? [];

    for (final assignment in memberAssignments) {
      final med = meds[assignment.medicationId];

      if (med == null) continue;

      final schedule = memberSchedules.firstWhereOrNull(
            (s) => s.fmmid == assignment.id,
          ) ??
          MedicationSchedule.empty();

      final assignmentLogs = memberLogs
          .where((log) => log.fmmid == assignment.id)
          .toList();

      assignmentList.add(
        Assignment(
          member,
          assignment,
          med,
          schedule,
          assignmentLogs,
        ),
      );
    }
  }

  List<Member> list = [];

  for (final member in memberships.values) {
    list.add(
      Member(
        member,
        family,
        assignmentList.where((a) => a.member.id == member.id).toList(),
      ),
    );
  }

  return list;
}

@riverpod
Future<FamilyCollection> aggregateFamily(Ref ref) async {
  final familyId   = await ref.watch(currentFamilyProvider.future);
  final familyCache = await ref.watch(familiesProvider.future);
  final collection = await ref.watch(aggregateMembershipsProvider(familyId).future);
  final family     = familyCache.values.firstWhere((f) => f.id == familyId);
  final members    = collection.where((m) => m.member.fid == familyId).toList();

  return FamilyCollection(
    family,
    members.map((e) => e.member).toList(),
    members.expand((v) => v.fmms).toList(),
    members.expand((v) => v.medications).toList(),
    members.expand((v) => v.logs).toList(),
    members.expand((v) => v.schedules).toList(),
  );
}