// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(familyMemberRepository)
final familyMemberRepositoryProvider = FamilyMemberRepositoryProvider._();

final class FamilyMemberRepositoryProvider
    extends
        $FunctionalProvider<
          FamilyMemberRepositoryRemote,
          FamilyMemberRepositoryRemote,
          FamilyMemberRepositoryRemote
        >
    with $Provider<FamilyMemberRepositoryRemote> {
  FamilyMemberRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyMemberRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyMemberRepositoryHash();

  @$internal
  @override
  $ProviderElement<FamilyMemberRepositoryRemote> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FamilyMemberRepositoryRemote create(Ref ref) {
    return familyMemberRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FamilyMemberRepositoryRemote value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FamilyMemberRepositoryRemote>(value),
    );
  }
}

String _$familyMemberRepositoryHash() =>
    r'37dfbf317179ddba2e6dc3b545cf387eb7b56d5f';

@ProviderFor(memberChanged)
final memberChangedProvider = MemberChangedProvider._();

final class MemberChangedProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  MemberChangedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memberChangedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memberChangedHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return memberChanged(ref);
  }
}

String _$memberChangedHash() => r'b9ded5b0d0fbe43fc36047e8ddd2876d9f7fcf05';

@ProviderFor(FamilyMembers)
final familyMembersProvider = FamilyMembersProvider._();

final class FamilyMembersProvider
    extends $AsyncNotifierProvider<FamilyMembers, FamilyMemberships> {
  FamilyMembersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyMembersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyMembersHash();

  @$internal
  @override
  FamilyMembers create() => FamilyMembers();
}

String _$familyMembersHash() => r'eea98476c91f62aedae06ea8b57443a95472681a';

abstract class _$FamilyMembers extends $AsyncNotifier<FamilyMemberships> {
  FutureOr<FamilyMemberships> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<FamilyMemberships>, FamilyMemberships>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FamilyMemberships>, FamilyMemberships>,
              AsyncValue<FamilyMemberships>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
