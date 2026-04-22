import 'package:frontend/models/models.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';

abstract class ScheduleRepository {
  Future<Map<String, List<MedicationSchedule>>> getMedicationSchedules();
  Future<void> createSchedule(ScheduleRequest data, String fmId);
  Future<void> updateSchedule(String schedId, ScheduleUpdate data);
  Future<void> deleteSchedule(String schedId, String fmId);
}