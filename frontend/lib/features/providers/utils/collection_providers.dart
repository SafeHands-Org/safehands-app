import 'package:collection/collection.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collection_providers.g.dart';

@riverpod
Future<Map<String, FamilyMember>> currentMembers(Ref ref) async {
  final origin = await ref.watch(currentFamilyProvider.future);
  if (origin.isEmpty) return {};

  final provider = await ref.watch(familyMembersProvider.future);
  final members = provider.entries.where((v) => v.value.fid == origin);
  return Map.fromEntries(members);
}

@riverpod
Future<Map<String, List<FamilyMemberMedication>>> currentAssignments(Ref ref) async {
  final reference = await ref.watch(currentMembersProvider.future);
  if (reference.isEmpty) return {};

  final provider = await ref.watch(assignmentsProvider.future);
  final assignments = provider.entries.where((v) => reference.containsKey(v.key));
  return Map.fromEntries(assignments);
}

@riverpod
Future<Map<String, Medication>> currentMedications(Ref ref) async {
  return await ref.watch(medicationsProvider.future);
}

@riverpod
Future<MemberSchedules> currentSchedules(Ref ref) async {
  final origin = await ref.watch(currentMembersProvider.future);
  if (origin.isEmpty) return {};

  final provider = await ref.watch(schedulesProvider.future);
  final schedules = provider.entries.where((v) => origin.keys.contains(v.key));
  return Map.fromEntries(schedules);
}

@riverpod
Future<Member> aggregateMember(Ref ref, String fmid) async {
  final familyId = await ref.watch(currentFamilyProvider.future);
  if (familyId.isEmpty) throw StateError('No family selected');

  final collection = await ref.watch(aggregateMembershipsProvider(familyId).future);
  return collection.firstWhere(
    (c) => c.id == fmid,
    orElse: () => throw StateError('Member $fmid not found'),
  );
}

@riverpod
Future<List<Member>> aggregateMemberships(Ref ref, String fid) async {
  if (fid.isEmpty) return [];

  final members     = await ref.watch(familyMembersProvider.future);
  final assignments = await ref.watch(assignmentsProvider.future);
  final meds        = await ref.watch(medicationsProvider.future);
  final logs        = await ref.watch(adherencesProvider.future);
  final schedules   = await ref.watch(schedulesProvider.future);
  final families    = await ref.watch(familiesProvider.future);

  final family = families[fid];
  if (family == null) return [];

  final memberships = Map<String, FamilyMember>.from(members);
  memberships.removeWhere((k, v) => v.fid != fid);


  if (memberships.isEmpty) return [];

  final List<Assignment> assignmentList = [];

  for (final member in memberships.values) {
    final memberAssignments = assignments[member.id] ?? [];
    final memberSchedules   = schedules[member.id] ?? [];
    final memberLogs        = logs[member.id] ?? [];

    for (final assignment in memberAssignments) {
      final med = meds[assignment.medicationId];
      if (med == null) continue;

      final schedule = memberSchedules.firstWhereOrNull(
        (s) => s.fmmid == assignment.id,
      ) ?? MedicationSchedule.empty();

      final assignmentLogs = memberLogs
          .where((log) => log.fmmid == assignment.id)
          .toList();

      assignmentList.add(Assignment(member, assignment, med, schedule, assignmentLogs));
    }
  }

  return [
    for (final member in memberships.values)
      Member(
        member,
        family,
        assignmentList.where((a) => a.member.id == member.id).toList(),
      ),
  ];
}

@riverpod
Future<FamilyCollection> aggregateFamily(Ref ref) async {
  final familyId = await ref.watch(currentFamilyProvider.future);
  if (familyId.isEmpty) return FamilyCollection.empty();

  final familyCache = await ref.watch(familiesProvider.future);
  final family = familyCache.values.firstWhereOrNull((f) => f.id == familyId);
  if (family == null) return FamilyCollection.empty();

  final collection = await ref.watch(aggregateMembershipsProvider(familyId).future);
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