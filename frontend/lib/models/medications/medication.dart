import 'package:dart_mappable/dart_mappable.dart';

part 'medication.mapper.dart';

/*
"medication": {
  "id": "b1c75884-aa8e-4e99-a269-e0e3c49afefb",
  "names": [
    "Advil",
    "Ibuprofen"
  ],
  "rxcui": "530646",
  "dosage": "200 mg",
  "doseForm": "tablet",
  "instructions": "Take 1 tablet every 6-8 hours with food as needed for pain or fever.",
  "createdBy": "8daf9445-940d-48dc-b946-9ad9efdd171f",
  "createdAt": "2026-04-01 20:52:50.867098"
}

*/
@MappableClass()
class Medication with MedicationMappable{
  final String id;
  final List<String> names;
  final String? rxcui;
  final String dosage;
  final String doseForm;
  final String instructions;
  final String createdBy;
  final DateTime createdAt;

  const Medication({
    required this.id,
    required this.names,
    required this.rxcui,
    required this.dosage,
    required this.doseForm,
    required this.instructions,
    required this.createdBy,
    required this.createdAt,
  });

  factory Medication.empty() => Medication(
    id: '',
    names: const [],
    rxcui: '',
    dosage: '',
    doseForm: '',
    instructions: '',
    createdBy: '',
    createdAt: DateTime.now(),
  );

  bool get isEmpty => id.isEmpty && names.isEmpty && dosage.isEmpty;
  bool get isNotEmpty => !isEmpty;
}
