import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/adherence/adherence_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
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
      if (_cachedLogs.isEmpty) {
        final Response result = await _api.get('$_baseUrl/logs');
        final data = jsonDecode(result.body) as List;

        final logsList = data.map((element) => MedicationAdherenceLogMapper.fromMap(element['logs'])).toList();

        _cachedLogs.addAll({ for (final log in logsList) log.fmid: logsList.where((m) => m.fmid == log.fmid).toList()});
      }
    } on Exception {
      rethrow;
    }
    return Map.unmodifiable(_cachedLogs);
  }

  @override
  Future<void> createLog(AdherenceLogRequest data, String fmid) async {
    final logs = _cachedLogs.values;
    for (final log in logs) {
      if (log.any((a) => a.fmmid == data.familyMemberMedicationId && a.takenAt == data.takenAt)) {
        throw DuplicateException();
      }
    }

    try {
      final Response result = await _api.post('$_baseUrl/logs', data.toMap());

      MedicationAdherenceLog newLog = MedicationAdherenceLogMapper.fromMap(jsonDecode(result.body));
      _cachedLogs.putIfAbsent(fmid, () => []);
      _cachedLogs[fmid]!.add(newLog);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> updateLog(String logRef, AdherenceLogUpdate data) async {
    if (!_cachedLogs.containsKey(logRef)) throw NotFoundException();

    try {
      final result = await _api.put('$_baseUrl/logs/$logRef', data.toMap());
      MedicationAdherenceLog updatedLog = MedicationAdherenceLogMapper.fromMap(result.value);
      final list = _cachedLogs.putIfAbsent(updatedLog.fmid, () => []);
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
}