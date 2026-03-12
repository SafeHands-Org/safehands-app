import 'package:dart_mappable/dart_mappable.dart';

part 'adherence_log.mapper.dart';

@MappableClass()
class AdherenceLog with AdherenceLogMappable {
  final String id;
  final String familyMemberMedicationId;
  final String scheduledTime;
  final DateTime? takenAt;
  final String status;
  final String recordedBy;

  const AdherenceLog({
    required this.id,
    required this.familyMemberMedicationId,
    required this.scheduledTime,
    required this.status,
    this.takenAt,
    required this.recordedBy,
  });
}
