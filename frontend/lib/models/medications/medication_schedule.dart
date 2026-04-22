import 'package:dart_mappable/dart_mappable.dart';
import 'package:frontend/utils/utils.dart';

part 'medication_schedule.mapper.dart';


@MappableClass()
class MedicationSchedule with MedicationScheduleMappable{
  final String id;
  final String fmmid;
  final String fmid;
  final List<String> timesOfDay;
  final List<String> daysOfWeek;
  final int frequency;

  const MedicationSchedule({
    required this.id,
    required this.fmmid,
    required this.fmid,
    required this.timesOfDay,
    required this.daysOfWeek,
    required this.frequency,
  });

  factory MedicationSchedule.empty() => MedicationSchedule(
    id: '',
    fmmid: '',
    fmid: '',
    timesOfDay: const [],
    daysOfWeek: const[],
    frequency: -1,
  );

  bool get isEmpty => id.isEmpty && fmmid.isEmpty && fmid.isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool get isScheduledToday {
    return daysOfWeek.any((day) => dayMap[day] == weekdayToday);
  }

  bool _isScheduledOn(int weekday) {
    if (daysOfWeek.isEmpty) return true;
    return daysOfWeek.any((d) => dayMap[d] == weekday);
  }

  DateTime get nextDoseTime {
    final now = DateTime.now();
    for (int daysAhead = 0; daysAhead < 8; daysAhead++) {
      final candidate = now.add(Duration(days: daysAhead));
      if (!_isScheduledOn(candidate.weekday)) continue;
      final doses = timesOfDay
        .map((t) => futureTimeToDateTime(t, daysAhead: daysAhead))
        .where((t) => t.isAfter(now))
        .toList()
      ..sort();

      if (doses.isNotEmpty) return doses.first;
    }

    return futureTimeToDateTime(timesOfDay.first, daysAhead: 1);
  }

  Duration get timeUntilNextDose => difference(nextDoseTime);
}