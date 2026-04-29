// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(medicationRepository)
final medicationRepositoryProvider = MedicationRepositoryProvider._();

final class MedicationRepositoryProvider
    extends
        $FunctionalProvider<
          MedicationRepositoryRemote,
          MedicationRepositoryRemote,
          MedicationRepositoryRemote
        >
    with $Provider<MedicationRepositoryRemote> {
  MedicationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicationRepositoryHash();

  @$internal
  @override
  $ProviderElement<MedicationRepositoryRemote> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MedicationRepositoryRemote create(Ref ref) {
    return medicationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MedicationRepositoryRemote value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MedicationRepositoryRemote>(value),
    );
  }
}

String _$medicationRepositoryHash() =>
    r'496f8631e6f1fafbf82ab73e6690b22ae5d25de4';

@ProviderFor(medicationChanged)
final medicationChangedProvider = MedicationChangedProvider._();

final class MedicationChangedProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  MedicationChangedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicationChangedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicationChangedHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return medicationChanged(ref);
  }
}

String _$medicationChangedHash() => r'eb8287b8a60f27527028c22dd96337822f305499';

@ProviderFor(Medications)
final medicationsProvider = MedicationsProvider._();

final class MedicationsProvider
    extends $AsyncNotifierProvider<Medications, UserMedications> {
  MedicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicationsHash();

  @$internal
  @override
  Medications create() => Medications();
}

String _$medicationsHash() => r'cc2cf0f1b2b78b90f393891fd1f845dbdb47cdb8';

abstract class _$Medications extends $AsyncNotifier<UserMedications> {
  FutureOr<UserMedications> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserMedications>, UserMedications>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserMedications>, UserMedications>,
              AsyncValue<UserMedications>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
