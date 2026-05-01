import 'package:frontend/features/providers/api/api_providers.dart';
import 'package:frontend/features/providers/app/app_providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/family/family_repository_remote.dart';
import 'package:frontend/repositories/invitation/invitation_repository_remote.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_providers.g.dart';

@Riverpod(keepAlive: true)
FamilyRepositoryRemote familyRepository(Ref ref) {
  final repo = FamilyRepositoryRemote(
    ref.watch(apiServiceProvider),
    ref.watch(sharedPreferenceServiceProvider),
    ref.read(familyUrlProvider),
  );
  ref.onDispose(() {
    repo.clearCurrentFamily();
    repo.clearCache;
  });
  return repo;
}

@Riverpod(keepAlive: true)
InvitationRepositoryRemote invitationRepository(Ref ref) {
  final repo = InvitationRepositoryRemote(
    ref.watch(apiServiceProvider),
    ref.watch(sharedPreferenceServiceProvider),
    ref.read(familyUrlProvider),
  );
  ref.onDispose(() {
    repo.clearInviteToken();
    repo.clearCache;
  });
  return repo;
}

@riverpod
Stream<void> familyChanges(Ref ref) {
  final repo = ref.watch(familyRepositoryProvider);
  return repo.changes;
}

@riverpod
Stream<void> invitateChanges(Ref ref) {
  final repo = ref.watch(familyRepositoryProvider);
  return repo.changes;
}

@riverpod
Future<Family?> getFamilyById(Ref ref, String fid) async {
  final provider = ref.watch(familiesProvider);
  final families = provider.value;
  if (families != null && families.containsKey(fid)) return families[fid];
  return null;
}

@riverpod
Future<Family?> currentFamilyObject(Ref ref) async {
  final provider  = await ref.watch(familiesProvider.future);
  final reference = await ref.watch(currentFamilyProvider.future);

  if (provider.isEmpty || reference.isEmpty) return null;

  return provider[reference];
}

@riverpod
class CurrentFamily extends _$CurrentFamily {
  @override
  Future<String> build() => _getCurrentFamily();

  Future<String> _getCurrentFamily() async {
    state = const AsyncLoading();
    final savedId = ref.read(familyRepositoryProvider).fetchCurrentFamily();
    final families = await ref.read(familyRepositoryProvider).getFamilies();
    if (families.isEmpty) return '';

    if (savedId != null && families.containsKey(savedId)) {
      return savedId;
    }

    final firstId = families.values.first.id;
    await setFamily(firstId);
    return firstId;
  }

  Future<void> setFamily(String fid) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(familyRepositoryProvider).saveCurrentFamily(fid);
      return fid;
    });
  }

  Future<void> clear() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(familyRepositoryProvider).clearCurrentFamily();
      return '';
    });
  }
}

@riverpod
class Families extends _$Families {
  @override
  Future<UserFamilies> build() async {
    final repo = ref.read(familyRepositoryProvider);
    ref.watch(familyChangesProvider);
    return repo.getFamilies();
  }

  Future<void> createFamily({required String data}) async {
    state = const AsyncLoading();
    try {
      await ref.read(familyRepositoryProvider).createFamily(data);
      ref.invalidateSelf();
      final families = await future;
      if (families.isNotEmpty) {
        final newFamilyId = families.values.last.id;
        await ref.read(currentFamilyProvider.notifier).setFamily(newFamilyId);
      }
      ref.invalidate(aggregateMembershipsProvider);
      ref.invalidate(aggregateMemberProvider);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateFamily({required String fid, required String data}) async {
    state = const AsyncLoading();
    try {
      await ref.read(familyRepositoryProvider).updateFamily(fid, data);
      ref.invalidateSelf();
      await future;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteFamily({required String fid}) async {
    state = const AsyncLoading();
    try {
      await ref.read(familyRepositoryProvider).deleteFamily(fid);
      await ref.read(currentFamilyProvider.notifier).clear();
      ref.invalidateSelf();
      await future;
      ref.invalidate(aggregateMembershipsProvider);
      ref.invalidate(aggregateMemberProvider);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

@riverpod
class Invitations extends _$Invitations {
  @override
  Future<Invitation> build() async {
    final repo          = ref.read(invitationRepositoryProvider);
    final currentFamily = await ref.watch(currentFamilyProvider.future);
    ref.watch(invitateChangesProvider);

    if (currentFamily.isEmpty) return Invitation.empty();

    return repo.getInvitation(currentFamily);
  }
}