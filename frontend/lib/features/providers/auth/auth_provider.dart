import 'package:flutter/material.dart';
import 'package:frontend/features/providers/api/api_providers.dart';
import 'package:frontend/features/providers/app/app_providers.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/providers/family_members/family_member_providers.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/enums/enums.dart';
import 'package:frontend/models/user/auth_user.dart';
import 'package:frontend/repositories/auth/auth_repository.dart';
import 'package:frontend/repositories/auth/auth_repository_remote.dart';
import 'package:frontend/services/api/models/user/user_api_requests.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryRemote(
  ref.watch(apiServiceProvider),
  ref.watch(sharedPreferenceServiceProvider),
  ref.read(authUrlProvider),
);

@Riverpod(keepAlive: true)
UserRole userRole(Ref ref) => ref.watch(authProvider).value?.role ?? UserRole.familyMember;

@Riverpod(keepAlive: true)
Future<bool> isAdmin(Ref ref) async {
  final memberships = await ref.watch(familyMembersProvider.future);
  final family = await ref.watch(currentFamilyProvider.future);
  final user = ref.watch(authProvider);
  if (user.value == null) return false;

  final member = memberships.values.firstWhere((e) => e.fid == family);

  if (!member.isAdmin) return false;

  return true;
}

@Riverpod(keepAlive: true)
AuthUser? currentUser(Ref ref) => ref.watch(authProvider).value;

@Riverpod(keepAlive: true)
bool isLoggedIn(Ref ref) => ref.watch(authProvider).value?.isLoggedIn ?? false;

class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    ref.listen(isLoggedInProvider, (prev, next) => notifyListeners());
  }
}

@riverpod
class Auth extends _$Auth {
  @override
  AsyncValue<AuthUser> build() => const AsyncData(AuthUser());

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final AuthUser result = await ref.read(authRepositoryProvider).login(LoginRequest(email: email, password: password));
      return result;
    });
  }

  Future<void> register({required String name, required String email, required String password, required String role}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final AuthUser result = await ref.read(authRepositoryProvider).register(
        RegisterRequest(name: name, email: email, password: password, role: role),
      );
      return result;
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).logout();
    state = AsyncData(AuthUser());
  }
}