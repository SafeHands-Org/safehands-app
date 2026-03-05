import 'package:dart_mappable/dart_mappable.dart';

part 'medication.mapper.dart';

@MappableClass()
class Medication with MedicationMappable {
  final String id;
  final String nameEntered;
  final String rxcui;
  final String dosage;
  final String doseForm;
  final String instructions;
  final String createdBy;
  final String createdAt;

  const Medication({
    required this.id,
    required this.nameEntered,
    required this.rxcui,
    required this.dosage,
    required this.doseForm,
    required this.instructions,
    required this.createdBy,
    required this.createdAt
  });
}
