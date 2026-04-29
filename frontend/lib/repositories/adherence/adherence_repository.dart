import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';

abstract class MedicationAdherenceRepository {
  Future<MemberLogs> getMedicationLogs();
  Future<void> createLog(AdherenceLogRequest data, String fmid);
  Future<void> updateLog(String logId, AdherenceLogUpdate data);
}