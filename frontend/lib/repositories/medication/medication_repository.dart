import 'package:frontend/models/models.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';

abstract class MedicationRepository {
  Future<Map<String, Medication>> getAllMedications();
  Future<void> createMedication(MedicationRequest data);
  Future<Medication> getMedication(String medId);
  Future<void> updateMedication(String medId, MedicationUpdate data);
  Future<void> deleteMedication(String medId);
}