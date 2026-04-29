import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/repositories/adherence/adherence_repository_remote.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'adherence_providers.g.dart';


@Riverpod(keepAlive: true)
MedicationAdherenceRepositoryRemote adherenceRepository(Ref ref) => MedicationAdherenceRepositoryRemote(
  ref.watch(apiServiceProvider),
  ref.read(medicationUrlProvider)
);

@riverpod
Stream<void> adherenceChanges(Ref ref) {
  final repo = ref.watch(adherenceRepositoryProvider);
  return repo.changes;
}

@riverpod
class Adherences extends _$Adherences {
  @override
  Future<MemberLogs> build() async {
    final repo = ref.read(adherenceRepositoryProvider);
    ref.watch(adherenceChangesProvider);

    return repo.getMedicationLogs();
  }

  Future<void> createLog(AdherenceLogRequest data, String fmid) async {
    state = const AsyncLoading();
    try {
      await ref.read(adherenceRepositoryProvider).createLog(data, fmid);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateLog(String logId, AdherenceLogUpdate data) async {
    state = const AsyncLoading();
    try {
      await ref.read(adherenceRepositoryProvider).updateLog(logId, data);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}