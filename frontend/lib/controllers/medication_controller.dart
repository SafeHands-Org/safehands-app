import 'package:flutter/foundation.dart';
import 'package:frontend/services/medication_service.dart';

class MedicationController extends ChangeNotifier {
  List<Medication> medications = [];
  bool loading = false;
  String? error;

  Future<void> loadMedications() async {
    loading = true; error = null; notifyListeners();
    try {
      medications = await getMedications();
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
    } finally {
      loading = false; notifyListeners();
    }
  }

  Future<bool> createMed({
    required String nameEntered, required String doseForm,
    String? dosage, String? instructions, String? rxcui,
  }) async {
    try {
      final m = await createMedication(
        nameEntered: nameEntered, doseForm: doseForm,
        dosage: dosage, instructions: instructions, rxcui: rxcui,
      );
      medications = [...medications, m];
      notifyListeners(); return true;
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners(); return false;
    }
  }

  Future<bool> updateMed(String id, {
    String? nameEntered, String? doseForm, String? dosage, String? instructions,
  }) async {
    try {
      final m = await updateMedication(id,
        nameEntered: nameEntered, doseForm: doseForm,
        dosage: dosage, instructions: instructions,
      );
      medications = medications.map((x) => x.id == id ? m : x).toList();
      notifyListeners(); return true;
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners(); return false;
    }
  }

  Future<bool> deleteMed(String id) async {
    try {
      await deleteMedication(id);
      medications = medications.where((x) => x.id != id).toList();
      notifyListeners(); return true;
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners(); return false;
    }
  }

  final Map<String, List<MemberMedication>> _memberMeds = {};

  List<MemberMedication> forMember(String memberId) => _memberMeds[memberId] ?? [];

  Future<void> loadMemberMeds(String memberId) async {
    try {
      _memberMeds[memberId] = await getMemberMedications(memberId);
      notifyListeners();
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners();
    }
  }

  Future<bool> assign({
    required String medicationId, required String familyMemberId, required String startDate,
  }) async {
    try {
      final a = await assignMedication(
        medicationId: medicationId, familyMemberId: familyMemberId, startDate: startDate,
      );
      _memberMeds[familyMemberId] = [...(_memberMeds[familyMemberId] ?? []), a];
      notifyListeners(); return true;
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners(); return false;
    }
  }

  Future<bool> removeAssign(String id, String memberId) async {
    try {
      await removeAssignment(id);
      _memberMeds[memberId] = (_memberMeds[memberId] ?? []).where((x) => x.id != id).toList();
      notifyListeners(); return true;
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners(); return false;
    }
  }

  final Map<String, List<MedSchedule>> _schedules = {};

  List<MedSchedule> schedulesFor(String assignmentId) => _schedules[assignmentId] ?? [];

  Future<void> loadSchedules(String assignmentId) async {
    try {
      _schedules[assignmentId] = await getSchedules(assignmentId);
      notifyListeners();
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners();
    }
  }

  Future<bool> addSchedule({
    required String familyMemberMedicationId, required String timeOfDay,
    required String frequency, String? daysOfWeek,
  }) async {
    try {
      final s = await createSchedule(
        familyMemberMedicationId: familyMemberMedicationId,
        timeOfDay: timeOfDay, frequency: frequency, daysOfWeek: daysOfWeek,
      );
      _schedules[familyMemberMedicationId] = [...(_schedules[familyMemberMedicationId] ?? []), s];
      notifyListeners(); return true;
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners(); return false;
    }
  }

  Future<bool> removeSchedule(String id, String assignmentId) async {
    try {
      await deleteSchedule(id);
      _schedules[assignmentId] = (_schedules[assignmentId] ?? []).where((x) => x.id != id).toList();
      notifyListeners(); return true;
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners(); return false;
    }
  }

  final Map<String, List<AdherenceLog>> _logs = {};

  List<AdherenceLog> logsFor(String assignmentId) => _logs[assignmentId] ?? [];

  Future<void> loadLogs(String assignmentId) async {
    try {
      _logs[assignmentId] = await getAdherenceLogs(assignmentId);
      notifyListeners();
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners();
    }
  }

  Future<bool> logAdherence({
    required String familyMemberMedicationId, required String scheduledTime,
    required String status, required String recordedBy, String? takenAt,
  }) async {
    try {
      final log = await createAdherenceLog(
        familyMemberMedicationId: familyMemberMedicationId,
        scheduledTime: scheduledTime, status: status,
        recordedBy: recordedBy, takenAt: takenAt,
      );
      _logs[familyMemberMedicationId] = [...(_logs[familyMemberMedicationId] ?? []), log];
      notifyListeners(); return true;
    } catch (e) {
      error = e is ApiError ? e.message : e.toString();
      notifyListeners(); return false;
    }
  }
}