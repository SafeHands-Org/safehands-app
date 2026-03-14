import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

class Medication {
  final String id;
  final String nameEntered;
  final String? rxcui;
  final String? dosage;
  final String doseForm;
  final String? instructions;
  final String createdBy;

  const Medication({
    required this.id,
    required this.nameEntered,
    this.rxcui,
    this.dosage,
    required this.doseForm,
    this.instructions,
    required this.createdBy,
  });

  factory Medication.fromJson(Map<String, dynamic> j) => Medication(
    id:           j['id'],
    nameEntered:  j['nameEntered'],
    rxcui:        j['rxcui'],
    dosage:       j['dosage'],
    doseForm:     j['doseForm'] ?? 'other',
    instructions: j['instructions'],
    createdBy:    j['createdBy'] ?? '',
  );

}

class MemberMedication {
  final String id;
  final String medicationId;
  final String familyMemberId;
  final String? nameEntered;
  final String? dosage;
  final String? doseForm;
  final String startDate;
  final String? endDate;
  final bool active;

  const MemberMedication({
    required this.id,
    required this.medicationId,
    required this.familyMemberId,
    this.nameEntered,
    this.dosage,
    this.doseForm,
    required this.startDate,
    this.endDate,
    required this.active,
  });

  factory MemberMedication.fromJson(Map<String, dynamic> j) => MemberMedication(
    id:             j['id'],
    medicationId:   j['medicationId'],
    familyMemberId: j['familyMemberId'],
    nameEntered:    j['nameEntered'],
    dosage:         j['dosage'],
    doseForm:       j['doseForm'],
    startDate:      j['startDate'] ?? '',
    endDate:        j['endDate'],
    active:         j['active'] ?? true,
  );

}

class MedSchedule {
  final String id;
  final String familyMemberMedicationId;
  final String timeOfDay;
  final String? daysOfWeek;
  final String frequency;

  const MedSchedule({
    required this.id,
    required this.familyMemberMedicationId,
    required this.timeOfDay,
    this.daysOfWeek,
    required this.frequency,
  });

  factory MedSchedule.fromJson(Map<String, dynamic> j) => MedSchedule(
    id:                       j['id'],
    familyMemberMedicationId: j['familyMemberMedicationId'],
    timeOfDay:                j['timeOfDay'],
    daysOfWeek:               j['daysOfWeek'],
    frequency:                j['frequency'],
  );

  String get displayTime {
    final parts = timeOfDay.split(':');
    if (parts.length < 2) return timeOfDay;
    final h = int.tryParse(parts[0]) ?? 0;
    final m = parts[1];
    final period = h >= 12 ? 'PM' : 'AM';
    final h12 = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$h12:$m $period';
  }
}

class AdherenceLog {
  final String id;
  final String familyMemberMedicationId;
  final String scheduledTime;
  final String? takenAt;
  final String status;
  final String recordedBy;

  const AdherenceLog({
    required this.id,
    required this.familyMemberMedicationId,
    required this.scheduledTime,
    this.takenAt,
    required this.status,
    required this.recordedBy,
  });

  factory AdherenceLog.fromJson(Map<String, dynamic> j) => AdherenceLog(
    id:                       j['id'],
    familyMemberMedicationId: j['familyMemberMedicationId'],
    scheduledTime:            j['scheduledTime'],
    takenAt:                  j['takenAt'],
    status:                   j['status'],
    recordedBy:               j['recordedBy'],
  );
}

Future<List<Medication>> getMedications() async {
  final r = await http.get(Uri.parse('$_base/medications'), headers: await _headers());
  return (_parse(r) as List).map((e) => Medication.fromJson(e)).toList();
}

Future<Medication> createMedication({
  required String nameEntered,
  required String doseForm,
  String? dosage,
  String? instructions,
  String? rxcui,
}) async {
  final r = await http.post(Uri.parse('$_base/medications'),
    headers: await _headers(),
    body: jsonEncode({
      'nameEntered': nameEntered,
      'doseForm': doseForm,
      if (dosage?.isNotEmpty == true) 'dosage': dosage,
      if (instructions?.isNotEmpty == true) 'instructions': instructions,
      if (rxcui?.isNotEmpty == true) 'rxcui': rxcui,
    }),
  );
  final data = _parse(r);
  return Medication.fromJson(data is List ? data[0] : data);
}

Future<Medication> updateMedication(String id, {
  String? nameEntered,
  String? doseForm,
  String? dosage,
  String? instructions,
}) async {
  final r = await http.put(Uri.parse('$_base/medications/$id'),
    headers: await _headers(),
    body: jsonEncode({
      'nameEntered': ?nameEntered,
      'doseForm': ?doseForm,
      'dosage': ?dosage,
      'instructions': ?instructions,
    }),
  );
  final data = _parse(r);
  return Medication.fromJson(data is List ? data[0] : data);
}

Future<void> deleteMedication(String id) async {
  final r = await http.delete(Uri.parse('$_base/medications/$id'), headers: await _headers());
  _parse(r);
}

Future<List<MemberMedication>> getMemberMedications(String memberId) async {
  final r = await http.get(
    Uri.parse('$_base/medications/members/$memberId/medications'),
    headers: await _headers(),
  );
  return (_parse(r) as List).map((e) => MemberMedication.fromJson(e)).toList();
}

Future<MemberMedication> assignMedication({
  required String medicationId,
  required String familyMemberId,
  required String startDate,
  String? endDate,
}) async {
  final r = await http.post(Uri.parse('$_base/medications/member-medications'),
    headers: await _headers(),
    body: jsonEncode({
      'medicationId':   medicationId,
      'familyMemberId': familyMemberId,
      'startDate':      startDate,
      'endDate': ?endDate,
    }),
  );
  final data = _parse(r);
  return MemberMedication.fromJson(data is List ? data[0] : data);
}

Future<void> removeAssignment(String id) async {
  final r = await http.delete(
    Uri.parse('$_base/medications/member-medications/$id'),
    headers: await _headers(),
  );
  _parse(r);
}

Future<List<MedSchedule>> getSchedules(String assignmentId) async {
  final r = await http.get(
    Uri.parse('$_base/medications/member-medications/$assignmentId/schedules'),
    headers: await _headers(),
  );
  return (_parse(r) as List).map((e) => MedSchedule.fromJson(e)).toList();
}

Future<MedSchedule> createSchedule({
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
      'timeOfDay':  timeOfDay,
      'frequency':  frequency,
      'daysOfWeek': ?daysOfWeek,
    }),
  );
  final data = _parse(r);
  return MedSchedule.fromJson(data is List ? data[0] : data);
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
  return (_parse(r) as List).map((e) => AdherenceLog.fromJson(e)).toList();
}

Future<AdherenceLog> createAdherenceLog({
  required String familyMemberMedicationId,
  required String scheduledTime,
  required String status,
  required String recordedBy,
  String? takenAt,
}) async {
  final r = await http.post(
    Uri.parse('$_base/medications/member-medications/$familyMemberMedicationId/logs'),
    headers: await _headers(),
    body: jsonEncode({
      'familyMemberMedicationId': familyMemberMedicationId,
      'scheduledTime': scheduledTime,
      'status':        status,
      'recordedBy':    recordedBy,
      'takenAt': ?takenAt,
    }),
  );
  final data = _parse(r);
  return AdherenceLog.fromJson(data is List ? data[0] : data);
}

Future<AdherenceLog> updateAdherenceLog(String id, {
  required String status,
  String? takenAt,
}) async {
  final r = await http.put(
    Uri.parse('$_base/medications/member-medications/logs/$id'),
    headers: await _headers(),
    body: jsonEncode({
      'status': status,
      'takenAt': ?takenAt,
    }),
  );
  final data = _parse(r);
  return AdherenceLog.fromJson(data is List ? data[0] : data);
}