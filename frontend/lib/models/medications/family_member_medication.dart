import 'package:dart_mappable/dart_mappable.dart';

part 'family_member_medication.mapper.dart';

/*
Caregiver:
"assignment": {
  "id": "3858d22a-52e5-444c-ad3a-c3b089bf1dce",
  "medicationId": "718aa7f1-6c63-48e8-b35d-c3a8e8875797",
  "familyMemberId": "f284575f-7faa-41f3-bbd7-e10545fca48c",
  "priority": "high",
  "quantity": 1,
  "active": true
}

Family Member:
{
  "id": "d9f04e7f-49ef-45f6-962b-ca9b1de1553a",
  "medicationId": "1a592997-9614-4586-b0c0-6c73431a8871",
  "familyMemberId": "a0607f7a-b342-47a9-80ce-808c178c6b15",
  "priority": "high",
  "quantity": 2,
  "active": true
},
*/

@MappableClass()
class FamilyMemberMedication with FamilyMemberMedicationMappable{
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

  bool get isEmpty => id.isEmpty && medicationId.isEmpty && familyMemberId.isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool get isActive => !active;
}