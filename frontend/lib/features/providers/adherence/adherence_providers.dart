import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/repositories/adherence/adherence_repository_remote.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'adherence_providers.g.dart';

@Riverpod(keepAlive: true)
MedicationAdherenceRepositoryRemote adherenceRepository(Ref ref) =>
    MedicationAdherenceRepositoryRemote(
      ref.watch(apiServiceProvider),
      ref.read(medicationUrlProvider),
    );

@riverpod
Stream<void> adherenceChanges(Ref ref) {
  final repo = ref.watch(adherenceRepositoryProvider);
  return repo.changes;
}

@Riverpod(keepAlive: true)
class Adherences extends _$Adherences {
  @override
  Future<MemberLogs> build() async {
    final repo = ref.read(adherenceRepositoryProvider);
    ref.watch(adherenceChangesProvider);
    return repo.getMedicationLogs();
  }

  Future<bool> createLog(AdherenceLogRequest data, String fmid) async {
    try {
      await ref.read(adherenceRepositoryProvider).createLog(data, fmid);
      ref.invalidateSelf();
      ref.invalidate(aggregateMembershipsProvider);
      ref.invalidate(aggregateMemberProvider);
      return true;
    } catch (e, st) {
      print('createLog ERROR: $e\n$st');
      return false;
    }
  }

  Future<bool> updateLog(String logId, AdherenceLogUpdate data) async {
    try {
      await ref.read(adherenceRepositoryProvider).updateLog(logId, data);
      ref.invalidateSelf();
      ref.invalidate(aggregateMembershipsProvider);
      ref.invalidate(aggregateMemberProvider);
      return true;
    } catch (e, st) {
      print('updateLog ERROR: $e\n$st');
      return false;
    }
  }
}