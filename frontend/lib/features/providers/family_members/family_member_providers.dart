import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/family_member/family_member_repository_remote.dart';
import 'package:frontend/services/api/models/family/family_api_requests.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_member_providers.g.dart';

@Riverpod(keepAlive: true)
FamilyMemberRepositoryRemote familyMemberRepository(Ref ref) => FamilyMemberRepositoryRemote(
  ref.watch(apiServiceProvider),
  ref.watch(familyUrlProvider),
);

@riverpod
Stream<void> memberChanged(Ref ref) {
  var repo = ref.watch(familyMemberRepositoryProvider);
  return repo.changes;
}

@riverpod
Future<FamilyMember> memberById(Ref ref, String userId) async{
  var members = await ref.watch(familyMembersProvider.future);
  return members.values.firstWhere((e) => e.uid == userId);
}

@riverpod
class FamilyMembers extends _$FamilyMembers {
  @override
  Future<FamilyMemberships> build() {
    final repo = ref.read(familyMemberRepositoryProvider);
    ref.watch(memberChangedProvider);

    return repo.getFamilyMembers();
  }

  Future<void> addFamilyMember(String userId, FamilyMemberRequest data) async {
    state = const AsyncLoading();
    try {
      await ref.read(familyMemberRepositoryProvider).addFamilyMember(userId, data);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> updateFamilyMember(String id, FamilyMemberUpdate data) async {
    state = const AsyncLoading();
    try {
      await ref.read(familyMemberRepositoryProvider).updateFamilyMember(id, data);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> removeFamilyMember(String id) async {
    state = const AsyncLoading();
    try {
      await ref.read(familyMemberRepositoryProvider).removeFamilyMember(id);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}