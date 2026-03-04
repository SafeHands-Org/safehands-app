import 'package:dart_mappable/dart_mappable.dart';

part 'adherence_log.mapper.dart';

enum AdherenceStatus { taken, missed, skipped }

@MappableClass()
class AdherenceLog with AdherenceLogMappable {
  final String id;
  final String familyMemberMedicationId;

  final DateTime scheduledTime;
  final DateTime? takenAt;

  final AdherenceStatus status;
  final String? notes;

  const AdherenceLog({
    required this.id,
    required this.familyMemberMedicationId,
    required this.scheduledTime,
    required this.status,
    this.takenAt,
    this.notes,
  });
}