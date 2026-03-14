import 'package:dart_mappable/dart_mappable.dart';

part 'adherence_log_request.mapper.dart';

@MappableClass()
class AdherenceLogRequest with AdherenceLogRequestMappable {
  final String scheduledTime;
  final DateTime? takenAt;
  final String status;

  const AdherenceLogRequest({
    required this.scheduledTime,
    required this.status,
    this.takenAt,
  });
}