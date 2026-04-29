import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/medication/medication_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:frontend/utils/types.dart';

class MedicationRepositoryRemote extends MedicationRepository{
  MedicationRepositoryRemote(this._api, this._baseUrl);

  final ApiService _api;
  final String _baseUrl;

  Stream<void> get changes => _changeController.stream;
  void _notifyChange() => _changeController.add(null);

  final _changeController = StreamController<void>.broadcast();
  final _cachedMedications = <String, Medication>{};

  @override
  Future<UserMedications> getAllMedications() async {
    try {
      if (_cachedMedications.isEmpty) {
        final url = '$_baseUrl/';
        final result = await _api.get(url);
        final data = jsonDecode(result.body) as List;

        if (data.isEmpty) return <String, Medication>{};

        final medicationList = data.map((element) => MedicationMapper.fromMap(element['medication'])).toList();

        _cachedMedications.addAll({ for (final medication in medicationList) medication.id: medication });
      }
    } on Exception {
      rethrow;
    }

    return Map.unmodifiable(_cachedMedications);
  }

  @override
  Future<void> createMedication(MedicationRequest data) async {
    final bool duplicate = _cachedMedications.values.any((m) => (m.names, m.dosage, m.doseForm) == (data.names, data.dosage, data.doseForm));
    if (duplicate) throw DuplicateException("Medication already exists.");

    try {
      final url = '$_baseUrl/';
      final result = await _api.post(url, data.toMap());
      final json = jsonDecode(result.body);
      print(json);
      Medication newMedication = MedicationMapper.fromMap(json);
      print(newMedication);
      _cachedMedications[newMedication.id] = newMedication;
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Medication> getMedication(String medId) async {
    try {
      if (!_cachedMedications.containsKey(medId)) {
        final url = '$_baseUrl/$medId';
        final result = await _api.get(url);
        Medication medication = MedicationMapper.fromMap(result.value);
        _cachedMedications[medication.id] = medication;
        _notifyChange();
      }

      return (_cachedMedications[medId]!);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> updateMedication(String medId, MedicationUpdate data) async {
    if (!_cachedMedications.containsKey(medId)) {
      throw NotFoundException();
    }

    try {
      final url = '$_baseUrl/$medId';
      final result = await _api.put(url, data.toMap());
      final json = jsonDecode(result.body);
      Medication updatedMedication = MedicationMapper.fromMap(json);
      _cachedMedications.update(medId, (value) => updatedMedication);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> deleteMedication(String medId) async {
    if (!_cachedMedications.containsKey(medId)) {
      throw NotFoundException();
    }

    try {
      final url = '$_baseUrl/$medId';
      await _api.delete(url);
      _cachedMedications.remove(medId);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }
}