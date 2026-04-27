import 'package:frontend/features/providers/api/api_providers.dart';
import 'package:frontend/features/providers/app/app_providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/family/family_repository_remote.dart';
import 'package:frontend/repositories/invitation/invitation_repository_remote.dart';
import 'package:frontend/services/api/models/family/family_api_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_providers.g.dart';

@riverpod
FamilyRepositoryRemote familyRepository(Ref ref) => FamilyRepositoryRemote(
  ref.watch(apiServiceProvider),
  ref.watch(sharedPreferenceServiceProvider),
  ref.watch(familyUrlProvider),
);

@riverpod
InvitationRepositoryRemote invitationRepository(Ref ref) => InvitationRepositoryRemote(
  ref.watch(apiServiceProvider),
  ref.watch(sharedPreferenceServiceProvider),
  ref.watch(familyUrlProvider),
);

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
  Family? family;

  final families = provider.value;
  if (families != null && families.containsKey(fid)) {
    family = families[fid];
  }

  return family;
}

@riverpod
Future<Family?> currentFamilyObject(Ref ref) async {
  final provider = await ref.watch(familiesProvider.future);
  final reference = await ref.watch(currentFamilyProvider.future);

  Family? family = provider[reference];

  return family;
}


@riverpod
class CurrentFamily extends _$CurrentFamily {
  @override
  Future<String> build() => _getCurrentFamily();

  Future<String> _getCurrentFamily() async {
    state = const AsyncLoading();

    final fid = await AsyncValue.guard(() async {
      final id = await ref.read(familyRepositoryProvider).fetchCurrentFamily();

      if (id.isEmpty) {
        final families = await ref.read(familyRepositoryProvider).getFamilies();
        if (families.values.isNotEmpty) setFamily(families.values.first.id);
      }

      return id;
    });

    return fid.value ?? '';
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
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void>updateFamily({required String fid, required String data}) async {
    state = const AsyncLoading();
    try {
      await ref.read(familyRepositoryProvider).updateFamily(fid, data);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void>deleteFamily({required String fid}) async {
    state = const AsyncLoading();
    try {
      await ref.read(familyRepositoryProvider).deleteFamily(fid);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

@riverpod
class Invitations extends _$Invitations {
  @override
  Future<Invitation> build() async {
    final repo = ref.read(invitationRepositoryProvider);
    final currentFamily = await ref.watch(currentFamilyProvider.future);
    ref.watch(invitateChangesProvider);

    return repo.getInvitation(currentFamily);
  }

  Future<void> createInvitation({required String fid, required InvitationRequest data}) async {
    state = const AsyncLoading();
    try {
      await ref.read(invitationRepositoryProvider).createInvitation(fid, data);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}