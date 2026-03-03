import 'package:dart_mappable/dart_mappable.dart';

part 'family_member_medication.mapper.dart';

@MappableClass()
class FamilyMemberMedication with FamilyMemberMedicationMappable {
  final String id;
  final String familyMemberId;
  final String medicationId;
  final String scheduleId;

  final DateTime assignedAt;
  final bool active;

  const FamilyMemberMedication({
    required this.id,
    required this.familyMemberId,
    required this.medicationId,
    required this.scheduleId,
    required this.assignedAt,
    this.active = true,
  });
}