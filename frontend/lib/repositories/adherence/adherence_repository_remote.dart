import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/adherence/adherence_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:http/http.dart';

class MedicationAdherenceRepositoryRemote extends MedicationAdherenceRepository {
  MedicationAdherenceRepositoryRemote(this._api, this._baseUrl);

  final ApiService _api;
  final String _baseUrl;

  Stream<void> get changes => _changeController.stream;
  void _notifyChange() => _changeController.add(null);

  final _changeController = StreamController<void>.broadcast();
  final _cachedLogs = <String, List<MedicationAdherenceLog>>{};

  @override
  Future<MemberLogs> getMedicationLogs() async {
    try {
      final Response result = await _api.get('$_baseUrl/logs');
      final data = jsonDecode(result.body) as List;

      _cachedLogs.clear();
      for (final element in data) {
        final log = MedicationAdherenceLogMapper.fromMap(
            element['logs'] as Map<String, dynamic>);
        _cachedLogs.putIfAbsent(log.fmid, () => []).add(log);
      }
    } on Exception {
      rethrow;
    }
    return Map.unmodifiable(_cachedLogs);
  }

  @override
  Future<void> createLog(AdherenceLogRequest data, String fmid) async {
    try {
      final Response result =
          await _api.post('$_baseUrl/logs', data.toMap());
      final json = jsonDecode(result.body);
      final raw = json is List ? json[0] : json;
      MedicationAdherenceLog newLog =
          MedicationAdherenceLogMapper.fromMap(raw as Map<String, dynamic>);
      _cachedLogs.putIfAbsent(fmid, () => []).add(newLog);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> updateLog(String logId, AdherenceLogUpdate data) async {
    try {
      final result =
          await _api.put('$_baseUrl/logs/$logId', data.toMap());
      final json = jsonDecode(result.body);
      final raw = json is List ? json[0] : json;
      MedicationAdherenceLog updatedLog =
          MedicationAdherenceLogMapper.fromMap(raw as Map<String, dynamic>);
      final list =
          _cachedLogs.putIfAbsent(updatedLog.fmid, () => []);
      final index = list.indexWhere((m) => m.id == updatedLog.id);
      if (index != -1) {
        list[index] = updatedLog;
      } else {
        list.add(updatedLog);
      }
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  void clearCache(){
    _cachedLogs.clear();
    _notifyChange();
  }
}