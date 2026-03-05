import 'package:dart_mappable/dart_mappable.dart';

part 'medication_schedule.mapper.dart';

@MappableClass()
class MedicationSchedule with MedicationScheduleMappable {
  final String id;
  final String familyMemberMedicationId;
  final String timeOfDay;
  final String daysOfWeek;
  final String frequency;

  const MedicationSchedule({
    required this.id,
    required this.familyMemberMedicationId,
    required this.timeOfDay,
    required this.daysOfWeek,
    required this.frequency,
  });
}
