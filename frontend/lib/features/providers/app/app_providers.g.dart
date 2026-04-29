// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferencesWithCache>,
          SharedPreferencesWithCache,
          FutureOr<SharedPreferencesWithCache>
        >
    with
        $FutureModifier<SharedPreferencesWithCache>,
        $FutureProvider<SharedPreferencesWithCache> {
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferencesWithCache> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferencesWithCache> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'13c4394c3a5e76ad7e4d2c5e719056688c38dd09';

@ProviderFor(sharedPreferenceService)
final sharedPreferenceServiceProvider = SharedPreferenceServiceProvider._();

final class SharedPreferenceServiceProvider
    extends
        $FunctionalProvider<
          SharedPreferenceService,
          SharedPreferenceService,
          SharedPreferenceService
        >
    with $Provider<SharedPreferenceService> {
  SharedPreferenceServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferenceServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferenceServiceHash();

  @$internal
  @override
  $ProviderElement<SharedPreferenceService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferenceService create(Ref ref) {
    return sharedPreferenceService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferenceService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferenceService>(value),
    );
  }
}

String _$sharedPreferenceServiceHash() =>
    r'3970517da4fad136c3cf8fca43d9b1d226c45ce2';

@ProviderFor(appClient)
final appClientProvider = AppClientProvider._();

final class AppClientProvider
    extends $FunctionalProvider<Client, Client, Client>
    with $Provider<Client> {
  AppClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appClientHash();

  @$internal
  @override
  $ProviderElement<Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Client create(Ref ref) {
    return appClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Client>(value),
    );
  }
}

String _$appClientHash() => r'9b80b15fe30c41f0f4da80eceb1f9dde71d48ec7';

@ProviderFor(apiService)
final apiServiceProvider = ApiServiceProvider._();

final class ApiServiceProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  ApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiServiceHash();

  @$internal
  @override
  $ProviderElement<ApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiService create(Ref ref) {
    return apiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiService>(value),
    );
  }
}

String _$apiServiceHash() => r'c7d1bfb508aa4171a4da91220708e844d6a48ebd';

@ProviderFor(remoteStartup)
final remoteStartupProvider = RemoteStartupProvider._();

final class RemoteStartupProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  RemoteStartupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteStartupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteStartupHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return remoteStartup(ref);
  }
}

String _$remoteStartupHash() => r'4326cf6c10d6a533d63bac9b8da00fa514a3dd00';
