import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/schedule/schedule_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';

class ScheduleRepositoryRemote extends ScheduleRepository {
  ScheduleRepositoryRemote(this._api, this._baseUrl);

  final ApiService _api;
  final String _baseUrl;

  Stream<void> get changes => _changeController.stream;
  void _notifyChange() => _changeController.add(null);

  final _changeController = StreamController<void>.broadcast();
  final _cachedSchedules = <String, List<MedicationSchedule>>{};

  @override
  Future<MemberSchedules> getMedicationSchedules() async {
    try {
      final result = await _api.get('$_baseUrl/schedules');
      final data = jsonDecode(result.body) as List;

      _cachedSchedules.clear();
      for (final element in data) {
        final raw = element['schedules'] as Map<String, dynamic>?;
        if (raw == null) continue;
        final schedule = MedicationScheduleMapper.fromMap(raw);
        _cachedSchedules
            .putIfAbsent(schedule.fmid, () => [])
            .add(schedule);
      }
    } on Exception {
      rethrow;
    }
    return Map.unmodifiable(_cachedSchedules);
  }

  Future<MedicationSchedule?> getScheduleForAssignment(String fmmId) async {
    try {
      final result = await _api.get('$_baseUrl/schedules?fmmId=$fmmId');
      final data = jsonDecode(result.body);
      final list = data is List ? data : [data];
      if (list.isEmpty) return null;
      final element = list[0];
      final raw = (element['schedules'] ?? element) as Map<String, dynamic>;
      return MedicationScheduleMapper.fromMap(raw);
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> createSchedule(ScheduleRequest data, String fmId) async {
    try {
      final result = await _api.post('$_baseUrl/schedules', data.toMap());
      final json = jsonDecode(result.body);
      final raw = json is List ? json[0] : json;
      final MedicationSchedule newSchedule =
          MedicationScheduleMapper.fromMap(raw as Map<String, dynamic>);
      _cachedSchedules
          .putIfAbsent(newSchedule.fmid, () => [])
          .add(newSchedule);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> updateSchedule(String schedId, ScheduleUpdate data) async {
    try {
      final result =
          await _api.put('$_baseUrl/schedules/$schedId', data.toMap());
      final json = jsonDecode(result.body);
      final raw = json is List ? json[0] : json;
      final MedicationSchedule updatedSchedule =
          MedicationScheduleMapper.fromMap(raw as Map<String, dynamic>);
      final list =
          _cachedSchedules.putIfAbsent(updatedSchedule.fmid, () => []);
      final index = list.indexWhere((m) => m.id == updatedSchedule.id);
      if (index != -1) {
        list[index] = updatedSchedule;
      } else {
        list.add(updatedSchedule);
      }
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> deleteSchedule(String schedId, String fmId) async {
    try {
      await _api.delete('$_baseUrl/schedules/$schedId');
      _cachedSchedules[fmId]?.removeWhere((m) => m.id == schedId);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  void clearCache(){
    _cachedSchedules.clear();
    _notifyChange();
  }
}