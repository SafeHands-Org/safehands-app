import 'package:dart_mappable/dart_mappable.dart';

part 'medication_schedule_request.mapper.dart';

@MappableClass()
class MedicationScheduleRequest with MedicationScheduleRequestMappable {
  final List<String> timesOfDay;
  final List<String>? daysOfWeek;
  final int frequency;
  final String frequencyUnit;

  const MedicationScheduleRequest({
    required this.timesOfDay,
    this.daysOfWeek,
    required this.frequency,
    required this.frequencyUnit,
  });
}