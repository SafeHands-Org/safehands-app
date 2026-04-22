import 'package:dart_mappable/dart_mappable.dart';
import 'package:frontend/utils/utils.dart';

part 'adherence_log.mapper.dart';

/*
Caregiver:
"logs": {
  "id": "69007ea4-24a7-417e-98a5-0d2ef11dbaaa",
  "fmid": "f284575f-7faa-41f3-bbd7-e10545fca48c",
  "fmmId": "7744d33e-1d05-4326-b44f-e76df430b08b",
  "scheduledTime": "08:00:00",
  "takenAt": "2026-01-05 08:10:00",
  "status": "taken",
  "recordedBy": "8daf9445-940d-48dc-b946-9ad9efdd171f"
}

FamilyMember:
"logs": {
  "id": "69007ea4-24a7-417e-98a5-0d2ef11dbaaa",
  "fmmId": "7744d33e-1d05-4326-b44f-e76df430b08b",
  "scheduledTime": "08:00:00",
  "takenAt": "2026-01-05 08:10:00",
  "status": "taken",
  "recordedBy": "8daf9445-940d-48dc-b946-9ad9efdd171f"
}
*/
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

  bool get isPastDueMissed {
    if (!isToday) return false;
    final scheduledDt = parse(today, scheduledTime);
    if (scheduledDt == null) return false;
    return scheduledDt.isBefore(DateTime.now()) && (status == 'missed' || takenAt == null);
  }

  bool get taken => status == 'taken';
  bool get isToday => parse(today, scheduledTime) != null;
}