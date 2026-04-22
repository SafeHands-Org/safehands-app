import 'package:frontend/models/models.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';

abstract class FamilyMedicationRepository {
  Future<Map<String, List<FamilyMemberMedication>>> getFamilyMedications();
  Future<FamilyMemberMedication> getFamilyMemberMedication(String fmmId, String fmId);
  Future<void> createFamilyMedication(MemberMedicationRequest data);
  Future<void> updateFamilyMedication(String fmmId, MemberMedicationUpdate data);
  Future<void> deleteFamilyMedication(String fmId, String fmmId);
}