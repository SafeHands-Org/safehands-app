import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/repositories/medication/medication_repository_remote.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medication_providers.g.dart';

@Riverpod(keepAlive: true)
MedicationRepositoryRemote medicationRepository(Ref ref) {
  final repo = MedicationRepositoryRemote(
    ref.watch(apiServiceProvider),
    ref.read(medicationUrlProvider),
  );
  ref.onDispose(() {
    repo.clearCache;
  });
  return repo;
}

@riverpod
Stream<void> medicationChanged(Ref ref) {
  final repo = ref.watch(medicationRepositoryProvider);
  return repo.changes;
}

@riverpod
class Medications extends _$Medications {
  @override
  Future<UserMedications> build() async {
    final repo = ref.read(medicationRepositoryProvider);
    ref.watch(medicationChangedProvider);
    return repo.getAllMedications();
  }

  Future<void> createMedication(MedicationRequest data) async {
    try {
      await ref.read(medicationRepositoryProvider).createMedication(data);
      ref.invalidateSelf();
      await future;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateMedication(String medId, MedicationUpdate data) async {
    try {
      await ref.read(medicationRepositoryProvider).updateMedication(medId, data);
      ref.invalidateSelf();
      await future;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteMedication(String medId) async {
    try {
      await ref.read(medicationRepositoryProvider).deleteMedication(medId);
      ref.invalidateSelf();
      await future;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}