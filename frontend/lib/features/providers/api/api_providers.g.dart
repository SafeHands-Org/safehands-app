// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(baseUrl)
final baseUrlProvider = BaseUrlProvider._();

final class BaseUrlProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  BaseUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'baseUrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$baseUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return baseUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$baseUrlHash() => r'6303754623b968320ceb55763e909a758b74be02';

@ProviderFor(familyUrl)
final familyUrlProvider = FamilyUrlProvider._();

final class FamilyUrlProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  FamilyUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return familyUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$familyUrlHash() => r'e6538d5ce8d89ec41ec9f2784f7d1a42e0241d5b';

@ProviderFor(medicationUrl)
final medicationUrlProvider = MedicationUrlProvider._();

final class MedicationUrlProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  MedicationUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicationUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicationUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return medicationUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$medicationUrlHash() => r'9af545d525b7bf4a12983c3746cc1ba5e191ed30';

@ProviderFor(authUrl)
final authUrlProvider = AuthUrlProvider._();

final class AuthUrlProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  AuthUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return authUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$authUrlHash() => r'97a0e4765544db3bb7d9d24c51e5f1fffd2f3047';

@ProviderFor(dashboardUrl)
final dashboardUrlProvider = DashboardUrlProvider._();

final class DashboardUrlProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  DashboardUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return dashboardUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$dashboardUrlHash() => r'd80b1d2362389b4f9bb2df9022c9d91fb6f6ce5c';

@ProviderFor(usersUrl)
final usersUrlProvider = UsersUrlProvider._();

final class UsersUrlProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  UsersUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return usersUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$usersUrlHash() => r'000fc33efbcbd6410413aff85dad2810c19d627f';
