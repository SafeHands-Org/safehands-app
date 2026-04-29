// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(medicationAlertAll)
final medicationAlertAllProvider = MedicationAlertAllProvider._();

final class MedicationAlertAllProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  MedicationAlertAllProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicationAlertAllProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicationAlertAllHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return medicationAlertAll(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$medicationAlertAllHash() =>
    r'13532b658ea138c2497b4bd0f526966e57c26959';

@ProviderFor(medicationAlertByFm)
final medicationAlertByFmProvider = MedicationAlertByFmFamily._();

final class MedicationAlertByFmProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  MedicationAlertByFmProvider._({
    required MedicationAlertByFmFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'medicationAlertByFmProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$medicationAlertByFmHash();

  @override
  String toString() {
    return r'medicationAlertByFmProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    final argument = this.argument as String;
    return medicationAlertByFm(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MedicationAlertByFmProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$medicationAlertByFmHash() =>
    r'beb72ec066a6ca028d6bc573d1dee7f168289cbf';

final class MedicationAlertByFmFamily extends $Family
    with $FunctionalFamilyOverride<void, String> {
  MedicationAlertByFmFamily._()
    : super(
        retry: null,
        name: r'medicationAlertByFmProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MedicationAlertByFmProvider call(String fmId) =>
      MedicationAlertByFmProvider._(argument: fmId, from: this);

  @override
  String toString() => r'medicationAlertByFmProvider';
}
