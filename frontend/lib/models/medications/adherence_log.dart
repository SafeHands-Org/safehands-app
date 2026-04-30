import 'package:dart_mappable/dart_mappable.dart';

part 'adherence_log.mapper.dart';

@MappableClass()
class MedicationAdherenceLog with MedicationAdherenceLogMappable {
  final String id;
  final String fmid;
  final String fmmid;
  final String scheduledTime;
  final DateTime? takenAt;
  final String status;
  final String recordedBy;

  const MedicationAdherenceLog({
    required this.id,
    required this.fmid,
    required this.fmmid,
    required this.scheduledTime,
    this.takenAt,
    required this.status,
    required this.recordedBy
  });

  factory MedicationAdherenceLog.empty() => MedicationAdherenceLog(
    id: '',
    fmid: '',
    fmmid: '',
    scheduledTime: '',
    status: '',
    recordedBy: '',
  );

  bool get isEmpty => id.isEmpty && fmid.isEmpty && fmmid.isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool get isToday {
    if (takenAt != null) {
      final todayStr = DateTime.now().toLocal().toIso8601String().substring(0, 10);
      return takenAt!.toLocal().toIso8601String().substring(0, 10) == todayStr;
    }
    return false;
  }

  bool get isPastDueMissed {
    if (!isToday) return false;
    final parts = scheduledTime.split(':');
    if (parts.length < 2) return false;
    final now = DateTime.now();
    final scheduledDt = DateTime(now.year, now.month, now.day,
      int.tryParse(parts[0]) ?? 0, int.tryParse(parts[1]) ?? 0);
    return scheduledDt.isBefore(now) && (status == 'missed' || takenAt == null);
  }

  bool get taken => status == 'taken';
}