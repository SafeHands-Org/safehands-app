import 'package:dart_mappable/dart_mappable.dart';

part 'medication_request.mapper.dart';

@MappableClass()
class MedicationRequest with MedicationRequestMappable {
  final String nameEntered;
  final String? rxcui;
  final String? dosage;
  final String doseForm;
  final String? instructions;

  const MedicationRequest({
    required this.nameEntered,
    this.rxcui,
    this.dosage,
    required this.doseForm,
    this.instructions,
  });
}