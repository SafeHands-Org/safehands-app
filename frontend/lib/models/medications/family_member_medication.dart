import 'package:dart_mappable/dart_mappable.dart';

part 'family_member_medication.mapper.dart';

@MappableClass()
class FamilyMemberMedication with FamilyMemberMedicationMappable {
  final String id;
  final String medicationId;
  final String familyMemberId;
  final String priority;
  final int quantity;
  final bool active;

  const FamilyMemberMedication({
    required this.id,
    required this.medicationId,
    required this.familyMemberId,
    required this.priority,
    required this.quantity,
    this.active = true,
  });

  factory FamilyMemberMedication.empty() => FamilyMemberMedication(
    id: '',
    medicationId: '',
    familyMemberId: '',
    priority: '',
    quantity: 0,
  );

  bool get isEmpty =>
      id.isEmpty && medicationId.isEmpty && familyMemberId.isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool get isActive => active;
}