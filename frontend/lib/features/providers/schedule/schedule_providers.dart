import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/repositories/schedule/schedule_repository_remote.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_providers.g.dart';

@Riverpod(keepAlive: true)
ScheduleRepositoryRemote scheduleRepository(Ref ref) {
  final repo = ScheduleRepositoryRemote(
    ref.watch(apiServiceProvider),
    ref.read(medicationUrlProvider)
  );

  ref.onDispose(() {
    repo.clearCache;
  });

  return repo;
}

@riverpod
Stream<void> scheduleChanged(Ref ref) {
  final repo = ref.watch(scheduleRepositoryProvider);
  return repo.changes;
}

@riverpod
class Schedules extends _$Schedules {
  @override
  Future<MemberSchedules> build() {
    final repo = ref.read(scheduleRepositoryProvider);
    ref.watch(scheduleChangedProvider);

    return repo.getMedicationSchedules();
  }

  Future<void> createSchedule(ScheduleRequest data, String fmid) async {
    state = const AsyncLoading();
    try {
      await ref.read(scheduleRepositoryProvider).createSchedule(data, fmid);
      ref.invalidateSelf();
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateSchedule(String schedId, ScheduleUpdate data) async {
    state = const AsyncLoading();
    try {
      await ref.read(scheduleRepositoryProvider).updateSchedule(schedId, data);
      ref.invalidateSelf();
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteSchedule(String schedId, String fmId) async {
    state = const AsyncLoading();
    try {
      await ref.read(scheduleRepositoryProvider).deleteSchedule(schedId, fmId);
      ref.invalidateSelf();
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}