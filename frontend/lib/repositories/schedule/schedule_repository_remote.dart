import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/schedule/schedule_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
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
      if (_cachedSchedules.isEmpty) {
        final result = await _api.get('$_baseUrl/schedules');
        final data = jsonDecode(result.body) as List;

        final schedules = data.map((element) => MedicationScheduleMapper.fromMap(element['schedules'])).toList();

        _cachedSchedules.addAll({for (final schedule in schedules) schedule.fmid: schedules.where((s) => s.fmid == schedule.fmid).toList()});
      }
    } on Exception {
      rethrow;
    }

    return Map.unmodifiable(_cachedSchedules);
  }

  @override
  Future<void> createSchedule(ScheduleRequest data, String fmId) async {
    final list = _cachedSchedules[fmId];
    if (list != null && list.isNotEmpty) {
      final index = list.indexWhere((m) => m.fmmid == data.familyMemberMedicationId);
      if (index != -1 ){
        throw DuplicateException("Medication already assigned to this member.");
      }
    }

    try {
      final result = await _api.post('$_baseUrl/schedules', data.toMap());
      MedicationSchedule newSchedule = MedicationScheduleMapper.fromMap(result.value);
      _cachedSchedules.putIfAbsent(newSchedule.fmid, () => []);
      _cachedSchedules[newSchedule.fmid]!.add(newSchedule);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> updateSchedule(String schedId, ScheduleUpdate data) async {
    if (!_cachedSchedules.containsKey(schedId)) throw NotFoundException();

    try {
      final result = await _api.put('$_baseUrl/schedules/$schedId', data.toMap());
      MedicationSchedule updatedSchedule = MedicationScheduleMapper.fromMap(result.value);
      final list = _cachedSchedules.putIfAbsent(updatedSchedule.fmid, () => []);
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
    if (!_cachedSchedules.containsKey(schedId)) throw NotFoundException();

    try {
      await _api.delete('$_baseUrl/schedules/$schedId');
      final list = _cachedSchedules[fmId];
      list!.removeWhere((m) => m.id == schedId && m.fmid == fmId);
       _notifyChange();
    } on Exception {
      rethrow;
    }
  }
}