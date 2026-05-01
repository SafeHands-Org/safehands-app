// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adherence_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adherenceRepository)
final adherenceRepositoryProvider = AdherenceRepositoryProvider._();

final class AdherenceRepositoryProvider
    extends
        $FunctionalProvider<
          MedicationAdherenceRepositoryRemote,
          MedicationAdherenceRepositoryRemote,
          MedicationAdherenceRepositoryRemote
        >
    with $Provider<MedicationAdherenceRepositoryRemote> {
  AdherenceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adherenceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adherenceRepositoryHash();

  @$internal
  @override
  $ProviderElement<MedicationAdherenceRepositoryRemote> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MedicationAdherenceRepositoryRemote create(Ref ref) {
    return adherenceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MedicationAdherenceRepositoryRemote value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MedicationAdherenceRepositoryRemote>(
        value,
      ),
    );
  }
}

String _$adherenceRepositoryHash() =>
    r'b41a4607d75b3bfeddbb53640f80cf5af3aa2179';

@ProviderFor(adherenceChanges)
final adherenceChangesProvider = AdherenceChangesProvider._();

final class AdherenceChangesProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  AdherenceChangesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adherenceChangesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adherenceChangesHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return adherenceChanges(ref);
  }
}

String _$adherenceChangesHash() => r'0a27ce0b62fd408659e30b413f462299694dfab8';

@ProviderFor(Adherences)
final adherencesProvider = AdherencesProvider._();

final class AdherencesProvider
    extends $AsyncNotifierProvider<Adherences, MemberLogs> {
  AdherencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adherencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adherencesHash();

  @$internal
  @override
  Adherences create() => Adherences();
}

String _$adherencesHash() => r'4057e69a367a826dbc3de9b6b3c7f2f779cc91ab';

abstract class _$Adherences extends $AsyncNotifier<MemberLogs> {
  FutureOr<MemberLogs> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MemberLogs>, MemberLogs>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MemberLogs>, MemberLogs>,
              AsyncValue<MemberLogs>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
