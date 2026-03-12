import 'package:dart_mappable/dart_mappable.dart';

part 'family_member_medication.mapper.dart';

@MappableClass()
class FamilyMemberMedication with FamilyMemberMedicationMappable {
  final String id;
  final String medicationId;
  final String familyMemberId;
  final String priority;
  final DateTime startDate;
  final DateTime? endDate;
  final bool active;

  const FamilyMemberMedication({
    required this.id,
    required this.medicationId,
    required this.familyMemberId,
    required this.priority,
    required this.startDate,
    this.endDate,
    required this.active,
  });
}