import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/family_medication/family_medication_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
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
      if (_cachedFamilyMedications.isEmpty) {
        final Response result = await _api.get('$_baseUrl/members');
        final data = jsonDecode(result.body) as List;

        final fmMedicationList = data.map((element) => FamilyMemberMedicationMapper.fromMap(element['assignment'])).toList();
        _cachedFamilyMedications.addAll({ for (final fmMedication in fmMedicationList) fmMedication.familyMemberId: fmMedicationList});
      }
    } on Exception {
      rethrow;
    }

    return Map.unmodifiable(_cachedFamilyMedications);
  }

  @override
  Future<void> createFamilyMedication(MemberMedicationRequest data) async {
    final list = _cachedFamilyMedications[data.familyMemberId];
    if (list != null && list.isNotEmpty) {
      final index = list.indexWhere((m) => m.medicationId == data.medicationId);
      if (index != -1){
        throw DuplicateException("Medication already assigned to this member.");
      }
    }

    try {
      final Response result = await _api.post('$_baseUrl/members', data.toMap());
      FamilyMemberMedication newMed = FamilyMemberMedicationMapper.fromMap(jsonDecode(result.body));
      _cachedFamilyMedications.putIfAbsent(newMed.familyMemberId, () => []);
      _cachedFamilyMedications[newMed.familyMemberId]!.add(newMed);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<FamilyMemberMedication> getFamilyMemberMedication(String fmmId, String fmId) async {
    try {
      if (!_cachedFamilyMedications.containsKey(fmId)) {
        final result = await _api.get('$_baseUrl/members/$fmmId');
        FamilyMemberMedication medication = FamilyMemberMedicationMapper.fromMap(result.value);
        final list = _cachedFamilyMedications.putIfAbsent(medication.familyMemberId, () => []);
        final index = list.indexWhere((m) => m.id == medication.id);
        list.add(medication);
        _notifyChange();
        return list[index];
      }

      final list = _cachedFamilyMedications[fmId];
      final index = list!.indexWhere((m) => m.id == fmId);
      return list[index];
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> updateFamilyMedication(String fmmId, MemberMedicationUpdate data) async {
    if (!_cachedFamilyMedications.containsKey(fmmId)) throw NotFoundException();

    try {
      final Response result = await _api.put('$_baseUrl/members/$fmmId', data.toMap());
      FamilyMemberMedication updatedMed = FamilyMemberMedicationMapper.fromMap(jsonDecode(result.body));

      final list = _cachedFamilyMedications.putIfAbsent(updatedMed.familyMemberId, () => []);
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
    if (!_cachedFamilyMedications.containsKey(fmId)) throw NotFoundException();

    try {
      await _api.delete('$_baseUrl/members/$fmmId');
      final list = _cachedFamilyMedications[fmId];
      list!.removeWhere((m) => m.id == fmmId && m.familyMemberId == fmId);
       _notifyChange();
    } on Exception {
      rethrow;
    }
  }
}