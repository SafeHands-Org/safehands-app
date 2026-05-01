import 'package:dart_mappable/dart_mappable.dart';

part 'medication.mapper.dart';

@MappableClass()
class Medication with MedicationMappable {
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

  String get displayName => names.isNotEmpty ? names.first : 'Unknown Medication';
  String get alternateName => names.length > 1 ? names.last : '';
}