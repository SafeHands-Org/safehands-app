import 'package:dart_mappable/dart_mappable.dart';

part 'medication.mapper.dart';

enum MedicationPriority { high, medium, low }

@MappableClass()
class Medication with MedicationMappable {
  final String id;
  final String name;

  final String time;

  final MedicationPriority priority;

  const Medication({
    required this.id,
    required this.name,
    required this.time,
    this.priority = MedicationPriority.low,
  });
}