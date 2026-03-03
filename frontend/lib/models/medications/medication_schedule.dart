import 'package:dart_mappable/dart_mappable.dart';

part 'medication_schedule.mapper.dart';

enum ScheduleType { daily, weekly, custom }

@MappableClass()
class MedicationSchedule with MedicationScheduleMappable {
  final String id;
  final String medicationId;
  final ScheduleType type;

  final List<String> times; 
  final List<int>? daysOfWeek; 

  final DateTime startDate;
  final DateTime? endDate;

  const MedicationSchedule({
    required this.id,
    required this.medicationId,
    required this.type,
    required this.times,
    this.daysOfWeek,
    required this.startDate,
    this.endDate,
  });
}