import 'package:frontend/features/providers/api/api_providers.dart';
import 'package:frontend/features/providers/app/app_providers.dart';
import 'package:frontend/repositories/family_medication/family_medication_repository_remote.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_providers.g.dart';

typedef DailyMedProgress = ({int? taken, int? total});

@Riverpod(keepAlive: true)
FamilyMedicationRepositoryRemote assignmentRepository(Ref ref) => FamilyMedicationRepositoryRemote(
  ref.watch(apiServiceProvider),
  ref.read(medicationUrlProvider),
);

@riverpod
Stream<void> assignmentChanged(Ref ref) {
  final repo = ref.watch(assignmentRepositoryProvider);
  return repo.changes;
}

@riverpod
class Assignments extends _$Assignments {
  @override
  Future<MemberAssignments> build() async {
    final repo = ref.read(assignmentRepositoryProvider);

    ref.watch(assignmentChangedProvider);

    return repo.getFamilyMedications();
  }

  Future<void> createFamilyMedication(MemberMedicationRequest data) async {
    state = const AsyncLoading();
    try {
      await ref.read(assignmentRepositoryProvider).createFamilyMedication(data);
      ref.invalidateSelf();
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateFamilyMedication(String fmmId, MemberMedicationUpdate data) async {
    state = const AsyncLoading();
    try {
      await ref.read(assignmentRepositoryProvider).updateFamilyMedication(fmmId, data);
      ref.invalidateSelf();
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteFamilyMedication(String fmId, String fmmId) async {
    state = const AsyncLoading();
    try {
      await ref.read(assignmentRepositoryProvider).deleteFamilyMedication(fmId, fmmId);
      ref.invalidateSelf();
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}