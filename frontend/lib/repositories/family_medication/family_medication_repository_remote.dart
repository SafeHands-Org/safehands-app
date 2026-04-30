import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/family_medication/family_medication_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:http/http.dart';

class FamilyMedicationRepositoryRemote extends FamilyMedicationRepository {
  FamilyMedicationRepositoryRemote(this._api, this._baseUrl);

  final ApiService _api;
  final String _baseUrl;

  Stream<void> get changes => _changeController.stream;
  void _notifyChange() => _changeController.add(null);

  final _changeController = StreamController<void>.broadcast();
  final _cachedFamilyMedications = <String, List<FamilyMemberMedication>>{};

  @override
  Future<MemberAssignments> getFamilyMedications() async {
    try {
      final Response result = await _api.get('$_baseUrl/members');
      final data = jsonDecode(result.body) as List;

      _cachedFamilyMedications.clear();

      for (final element in data) {
        final fmMedication = FamilyMemberMedicationMapper.fromMap(
          element['assignment'],
        );
        _cachedFamilyMedications
            .putIfAbsent(fmMedication.familyMemberId, () => [])
            .add(fmMedication);
      }
    } on Exception {
      rethrow;
    }

    return Map.unmodifiable(_cachedFamilyMedications);
  }

  @override
  Future<void> createFamilyMedication(MemberMedicationRequest data) async {
    await createFamilyMedicationAndReturn(data);
  }

  Future<FamilyMemberMedication> createFamilyMedicationAndReturn(
      MemberMedicationRequest data) async {
    try {
      final Response result =
          await _api.post('$_baseUrl/members', data.toMap());
      final json = jsonDecode(result.body);
      final raw = json is List ? json[0] : json;
      FamilyMemberMedication newMed =
          FamilyMemberMedicationMapper.fromMap(raw);
      _cachedFamilyMedications
          .putIfAbsent(newMed.familyMemberId, () => [])
          .add(newMed);
      _notifyChange();
      return newMed;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<FamilyMemberMedication> getFamilyMemberMedication(
    String fmmId,
    String fmId,
  ) async {
    try {
      final list = _cachedFamilyMedications[fmId];
      if (list != null) {
        final index = list.indexWhere((m) => m.id == fmmId);
        if (index != -1) return list[index];
      }

      final result = await _api.get('$_baseUrl/members/$fmmId');
      final json = jsonDecode(result.body);
      FamilyMemberMedication medication = FamilyMemberMedicationMapper.fromMap(json);
      _cachedFamilyMedications
          .putIfAbsent(medication.familyMemberId, () => [])
          .add(medication);
      _notifyChange();
      return medication;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> updateFamilyMedication(
    String fmmId,
    MemberMedicationUpdate data,
  ) async {
    try {
      final Response result = await _api.put(
        '$_baseUrl/members/$fmmId',
        data.toMap(),
      );
      final json = jsonDecode(result.body);
      final raw = json is List ? json[0] : json;
      FamilyMemberMedication updatedMed = FamilyMemberMedicationMapper.fromMap(raw);

      final list = _cachedFamilyMedications.putIfAbsent(
        updatedMed.familyMemberId,
        () => [],
      );
      final index = list.indexWhere((m) => m.id == updatedMed.id);
      if (index != -1) {
        list[index] = updatedMed;
      } else {
        list.add(updatedMed);
      }

      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> deleteFamilyMedication(String fmId, String fmmId) async {
    try {
      print('DELETE URL: $_baseUrl/members/$fmmId  fmId=$fmId');
      await _api.delete('$_baseUrl/members/$fmmId');
      print('DELETE API done');
      _cachedFamilyMedications[fmId]?.removeWhere((m) => m.id == fmmId);
      _notifyChange();
    } on Exception catch (e) {
      print('DELETE EXCEPTION: $e');
      rethrow;
    }
  }

  void clearCache(){
    _cachedFamilyMedications.clear();
    _notifyChange();
  }
}