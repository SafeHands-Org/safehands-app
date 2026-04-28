// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'9921e858e947c7dc540c2078dca879d69289b788';

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

@ProviderFor(colorScheme)
final colorSchemeProvider = ColorSchemeFamily._();

final class ColorSchemeProvider
    extends
        $FunctionalProvider<
          AsyncValue<ColorScheme>,
          ColorScheme,
          FutureOr<ColorScheme>
        >
    with $FutureModifier<ColorScheme>, $FutureProvider<ColorScheme> {
  ColorSchemeProvider._({
    required ColorSchemeFamily super.from,
    required BuildContext super.argument,
  }) : super(
         retry: null,
         name: r'colorSchemeProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$colorSchemeHash();

  @override
  String toString() {
    return r'colorSchemeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ColorScheme> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ColorScheme> create(Ref ref) {
    final argument = this.argument as BuildContext;
    return colorScheme(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ColorSchemeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$colorSchemeHash() => r'cdb2aa7e015764d376536599b7baa036fc27167a';

final class ColorSchemeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ColorScheme>, BuildContext> {
  ColorSchemeFamily._()
    : super(
        retry: null,
        name: r'colorSchemeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ColorSchemeProvider call(BuildContext context) =>
      ColorSchemeProvider._(argument: context, from: this);

  @override
  String toString() => r'colorSchemeProvider';
}

@ProviderFor(textTheme)
final textThemeProvider = TextThemeFamily._();

final class TextThemeProvider
    extends
        $FunctionalProvider<
          AsyncValue<TextTheme>,
          TextTheme,
          FutureOr<TextTheme>
        >
    with $FutureModifier<TextTheme>, $FutureProvider<TextTheme> {
  TextThemeProvider._({
    required TextThemeFamily super.from,
    required BuildContext super.argument,
  }) : super(
         retry: null,
         name: r'textThemeProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$textThemeHash();

  @override
  String toString() {
    return r'textThemeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TextTheme> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TextTheme> create(Ref ref) {
    final argument = this.argument as BuildContext;
    return textTheme(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TextThemeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$textThemeHash() => r'f392926b26e430d8a1c4abe58d8316e5d59f103f';

final class TextThemeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TextTheme>, BuildContext> {
  TextThemeFamily._()
    : super(
        retry: null,
        name: r'textThemeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  TextThemeProvider call(BuildContext context) =>
      TextThemeProvider._(argument: context, from: this);

  @override
  String toString() => r'textThemeProvider';
}

@ProviderFor(palette)
final paletteProvider = PaletteFamily._();

final class PaletteProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaletteExtension>,
          PaletteExtension,
          FutureOr<PaletteExtension>
        >
    with $FutureModifier<PaletteExtension>, $FutureProvider<PaletteExtension> {
  PaletteProvider._({
    required PaletteFamily super.from,
    required BuildContext? super.argument,
  }) : super(
         retry: null,
         name: r'paletteProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paletteHash();

  @override
  String toString() {
    return r'paletteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PaletteExtension> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaletteExtension> create(Ref ref) {
    final argument = this.argument as BuildContext?;
    return palette(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PaletteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paletteHash() => r'26875d5c3d56c38cb26484e46b7ce92a8fe7d6b4';

final class PaletteFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PaletteExtension>, BuildContext?> {
  PaletteFamily._()
    : super(
        retry: null,
        name: r'paletteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PaletteProvider call(BuildContext? context) =>
      PaletteProvider._(argument: context, from: this);

  @override
  String toString() => r'paletteProvider';
}

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

@ProviderFor(themeStartup)
final themeStartupProvider = ThemeStartupFamily._();

final class ThemeStartupProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  ThemeStartupProvider._({
    required ThemeStartupFamily super.from,
    required BuildContext super.argument,
  }) : super(
         retry: null,
         name: r'themeStartupProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$themeStartupHash();

  @override
  String toString() {
    return r'themeStartupProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as BuildContext;
    return themeStartup(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeStartupProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$themeStartupHash() => r'3236e25fe63e0bd662d0e3b14859b1e0ff5cc756';

final class ThemeStartupFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, BuildContext> {
  ThemeStartupFamily._()
    : super(
        retry: null,
        name: r'themeStartupProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ThemeStartupProvider call(BuildContext context) =>
      ThemeStartupProvider._(argument: context, from: this);

  @override
  String toString() => r'themeStartupProvider';
}
