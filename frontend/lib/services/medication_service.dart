import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/medications/adherence_log.dart';
import 'package:frontend/models/medications/family_member_medication.dart';
import 'package:frontend/models/medications/medication.dart';
import 'package:frontend/models/medications/medication_schedule.dart';
import 'package:http/http.dart' as http;

const _base = 'http://127.0.0.1:8000/api';
const _storage = FlutterSecureStorage();

Future<Map<String, String>> _headers() async {
  final token = await _storage.read(key: 'auth_token') ?? '';
  return {
    'Content-Type': 'application/json',
    if (token.isNotEmpty) 'Authorization': 'Bearer $token',
  };
}

class ApiError implements Exception {
  final String message;
  final int status;
  ApiError(this.message, this.status);
}

dynamic _parse(http.Response r) {
  if (r.statusCode == 204) return null;
  if (r.statusCode >= 200 && r.statusCode < 300) return jsonDecode(r.body);
  String msg = 'Error ${r.statusCode}';
  try { msg = (jsonDecode(r.body) as Map)['message'] ?? msg; } catch (_) {}
  throw ApiError(msg, r.statusCode);
}

Future<List<Medication>> getMedications() async {
  final r = await http.get(Uri.parse('$_base/medications'), headers: await _headers());
  final data = _parse(r) as List;
  return data.map((e) => MedicationMapper.fromMap(e as Map<String, dynamic>)).toList();
}

Future<Medication> createMedication({
  required String nameEntered,
  required String doseForm,
  String? dosage,
  String? instructions,
  String? rxcui,
}) async {
  final r = await http.post(
    Uri.parse('$_base/medications'),
    headers: await _headers(),
    body: jsonEncode({
      'nameEntered': nameEntered,
      'doseForm': doseForm,
      'dosage': dosage,
      'instructions': instructions,
      'rxcui': rxcui,
    }),
  );
  final data = _parse(r) as Map<String, dynamic>;
  return MedicationMapper.fromMap(data);
}

Future<Medication> updateMedication(
  String id, {
  String? nameEntered,
  String? doseForm,
  String? dosage,
  String? instructions,
}) async {
  final r = await http.put(
    Uri.parse('$_base/medications/$id'),
    headers: await _headers(),
    body: jsonEncode({
      if (nameEntered != null) 'nameEntered': nameEntered,
      if (doseForm != null) 'doseForm': doseForm,
      if (dosage != null) 'dosage': dosage,
      if (instructions != null) 'instructions': instructions,
    }),
  );
  final data = _parse(r) as Map<String, dynamic>;
  return MedicationMapper.fromMap(data);
}

Future<void> deleteMedication(String id) async {
  final r = await http.delete(Uri.parse('$_base/medications/$id'), headers: await _headers());
  _parse(r);
}

Future<List<FamilyMemberMedication>> getMemberMedications(String memberId) async {
  final r = await http.get(
    Uri.parse('$_base/medications/members/$memberId/medications'),
    headers: await _headers(),
  );
  final data = _parse(r) as List;
  return data.map((e) => FamilyMemberMedicationMapper.fromMap(e as Map<String, dynamic>)).toList();
}

Future<FamilyMemberMedication> assignMedication({
  required String medicationId,
  required String familyMemberId,
  required String startDate,
  String? endDate,
}) async {
  final r = await http.post(
    Uri.parse('$_base/medications/member-medications'),
    headers: await _headers(),
    body: jsonEncode({
      'medicationId': medicationId,
      'familyMemberId': familyMemberId,
      'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
    }),
  );
  final data = _parse(r) as Map<String, dynamic>;
  return FamilyMemberMedicationMapper.fromMap(data);
}

Future<void> removeAssignment(String id) async {
  final r = await http.delete(
    Uri.parse('$_base/medications/member-medications/$id'),
    headers: await _headers(),
  );
  _parse(r);
}

Future<List<MedicationSchedule>> getSchedules(String assignmentId) async {
  final r = await http.get(
    Uri.parse('$_base/medications/member-medications/$assignmentId/schedules'),
    headers: await _headers(),
  );
  final data = _parse(r) as List;
  return data.map((e) => MedicationScheduleMapper.fromMap(e as Map<String, dynamic>)).toList();
}

Future<MedicationSchedule> createSchedule({
  required String familyMemberMedicationId,
  required String timeOfDay,
  required String frequency,
  String? daysOfWeek,
}) async {
  final r = await http.post(
    Uri.parse('$_base/medications/member-medications/$familyMemberMedicationId/schedules'),
    headers: await _headers(),
    body: jsonEncode({
      'familyMemberMedicationId': familyMemberMedicationId,
      'timeOfDay': timeOfDay,
      'frequency': frequency,
      if (daysOfWeek != null) 'daysOfWeek': daysOfWeek,
    }),
  );
  final data = _parse(r) as Map<String, dynamic>;
  return MedicationScheduleMapper.fromMap(data);
}

Future<void> deleteSchedule(String id) async {
  final r = await http.delete(
    Uri.parse('$_base/medications/member-medications/schedules/$id'),
    headers: await _headers(),
  );
  _parse(r);
}

Future<List<AdherenceLog>> getAdherenceLogs(String assignmentId) async {
  final r = await http.get(
    Uri.parse('$_base/medications/member-medications/$assignmentId/logs'),
    headers: await _headers(),
  );
  final data = _parse(r) as List;
  return data.map((e) => AdherenceLogMapper.fromMap(e as Map<String, dynamic>)).toList();
}

Future<AdherenceLog> createAdherenceLog({
  required String familyMemberMedicationId,
  required String scheduledTime,
  required String status,
  required String recordedBy,
  DateTime? takenAt,
}) async {
  final r = await http.post(
    Uri.parse('$_base/medications/member-medications/$familyMemberMedicationId/logs'),
    headers: await _headers(),
    body: jsonEncode({
      'familyMemberMedicationId': familyMemberMedicationId,
      'scheduledTime': scheduledTime,
      'status': status,
      'recordedBy': recordedBy,
      if (takenAt != null) 'takenAt': takenAt.toIso8601String(),
    }),
  );
  final data = _parse(r) as Map<String, dynamic>;
  return AdherenceLogMapper.fromMap(data);
}

Future<AdherenceLog> updateAdherenceLog(
  String id, {
  required String status,
  DateTime? takenAt,
}) async {
  final r = await http.put(
    Uri.parse('$_base/medications/member-medications/logs/$id'),
    headers: await _headers(),
    body: jsonEncode({
      'status': status,
      if (takenAt != null) 'takenAt': takenAt.toIso8601String(),
    }),
  );
  final data = _parse(r) as Map<String, dynamic>;
  return AdherenceLogMapper.fromMap(data);
}