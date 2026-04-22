// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(familyRepository)
final familyRepositoryProvider = FamilyRepositoryProvider._();

final class FamilyRepositoryProvider
    extends
        $FunctionalProvider<
          FamilyRepositoryRemote,
          FamilyRepositoryRemote,
          FamilyRepositoryRemote
        >
    with $Provider<FamilyRepositoryRemote> {
  FamilyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyRepositoryHash();

  @$internal
  @override
  $ProviderElement<FamilyRepositoryRemote> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FamilyRepositoryRemote create(Ref ref) {
    return familyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FamilyRepositoryRemote value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FamilyRepositoryRemote>(value),
    );
  }
}

String _$familyRepositoryHash() => r'73e0ad8fc0e169b8fcfd7eaadd7a21102bcc5327';

@ProviderFor(familyChanges)
final familyChangesProvider = FamilyChangesProvider._();

final class FamilyChangesProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  FamilyChangesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyChangesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyChangesHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return familyChanges(ref);
  }
}

String _$familyChangesHash() => r'2351183d1c69ce9e00f225ec9051f283bfb1195e';

@ProviderFor(getFamilyById)
final getFamilyByIdProvider = GetFamilyByIdFamily._();

final class GetFamilyByIdProvider
    extends $FunctionalProvider<AsyncValue<Family?>, Family?, FutureOr<Family?>>
    with $FutureModifier<Family?>, $FutureProvider<Family?> {
  GetFamilyByIdProvider._({
    required GetFamilyByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getFamilyByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getFamilyByIdHash();

  @override
  String toString() {
    return r'getFamilyByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Family?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Family?> create(Ref ref) {
    final argument = this.argument as String;
    return getFamilyById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetFamilyByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getFamilyByIdHash() => r'fee503b053f92dd752001768bf4c4ea90ae67935';

final class GetFamilyByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Family?>, String> {
  GetFamilyByIdFamily._()
    : super(
        retry: null,
        name: r'getFamilyByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetFamilyByIdProvider call(String fid) =>
      GetFamilyByIdProvider._(argument: fid, from: this);

  @override
  String toString() => r'getFamilyByIdProvider';
}

@ProviderFor(CurrentFamily)
final currentFamilyProvider = CurrentFamilyProvider._();

final class CurrentFamilyProvider
    extends $AsyncNotifierProvider<CurrentFamily, String> {
  CurrentFamilyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentFamilyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentFamilyHash();

  @$internal
  @override
  CurrentFamily create() => CurrentFamily();
}

String _$currentFamilyHash() => r'5a45c38c014f55c133111b5eefd46b0f409a155a';

abstract class _$CurrentFamily extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Families)
final familiesProvider = FamiliesProvider._();

final class FamiliesProvider
    extends $AsyncNotifierProvider<Families, UserFamilies> {
  FamiliesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familiesHash();

  @$internal
  @override
  Families create() => Families();
}

String _$familiesHash() => r'3a758d51ba712492c11e483268cdfd7e4a3732b9';

abstract class _$Families extends $AsyncNotifier<UserFamilies> {
  FutureOr<UserFamilies> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserFamilies>, UserFamilies>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserFamilies>, UserFamilies>,
              AsyncValue<UserFamilies>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
