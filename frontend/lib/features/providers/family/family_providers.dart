import 'package:frontend/features/providers/api/api_providers.dart';
import 'package:frontend/features/providers/app/app_providers.dart';
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

  print('familiesProvider: $provider');
  print("currentFamiliesProvider $reference");

  if (provider.isEmpty || reference.isEmpty) {print('THE DASHBOARD IS EMPTY'); return Family.empty();}

  Family family = provider[reference]!;

  return family;
}


@riverpod
class CurrentFamily extends _$CurrentFamily {
  @override
  Future<String> build() => _getCurrentFamily();

  Future<String> _getCurrentFamily() async {
    state = const AsyncLoading();
    final id = ref.read(familyRepositoryProvider).fetchCurrentFamily();
    print('THE SAVED KEY IS: $id');
    if (id == null) {
      final families = await ref.read(familyRepositoryProvider).getFamilies();
      if (families.values.isNotEmpty) {
        final firstId = families.values.first.id;
        print(firstId);
        await setFamily(firstId);
        return firstId;
      }
      return '';
    }
    print('RETURNING THIS KEY INSTEAD $id');
    return id;
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
}