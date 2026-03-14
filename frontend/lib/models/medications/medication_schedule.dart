import 'package:dart_mappable/dart_mappable.dart';

part 'medication_schedule.mapper.dart';

@MappableClass()
class MedicationSchedule with MedicationScheduleMappable {
  final String id;
  final String familyMemberMedicationId;
  final List<String> timesOfDay;
  final List<String>? daysOfWeek;
  final int frequency;
  final String frequencyUnit;

  const MedicationSchedule({
    required this.id,
    required this.familyMemberMedicationId,
    required this.timesOfDay,
    this.daysOfWeek,
    required this.frequency,
    required this.frequencyUnit,
  });
  String get displayTime {
    if (timesOfDay.isEmpty) return '';
    final timeOfDay = timesOfDay.first;
    final parts = timeOfDay.split(':');
    if (parts.length < 2) return timeOfDay;
    final h = int.tryParse(parts[0]) ?? 0;
    final m = parts[1];
    final period = h >= 12 ? 'PM' : 'AM';
    final h12 = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$h12:$m $period';
  }
}

