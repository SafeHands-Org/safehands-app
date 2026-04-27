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

String _$memberChangedHash() => r'7044ea6a293873c796196d359007f59c1977bf19';

@ProviderFor(memberById)
final memberByIdProvider = MemberByIdFamily._();

final class MemberByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<FamilyMember>,
          FamilyMember,
          FutureOr<FamilyMember>
        >
    with $FutureModifier<FamilyMember>, $FutureProvider<FamilyMember> {
  MemberByIdProvider._({
    required MemberByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'memberByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberByIdHash();

  @override
  String toString() {
    return r'memberByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FamilyMember> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FamilyMember> create(Ref ref) {
    final argument = this.argument as String;
    return memberById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MemberByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberByIdHash() => r'3831f3acc3c0aa4f0d7296787853d163e23d1262';

final class MemberByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FamilyMember>, String> {
  MemberByIdFamily._()
    : super(
        retry: null,
        name: r'memberByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberByIdProvider call(String userId) =>
      MemberByIdProvider._(argument: userId, from: this);

  @override
  String toString() => r'memberByIdProvider';
}

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
