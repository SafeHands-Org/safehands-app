import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
SharedPreferenceService sharedPreferenceService(Ref ref) {
  return SharedPreferenceService();
}

@Riverpod(keepAlive: true)
Client appClient(Ref ref) {
  final client = Client();
  ref.onDispose(client.close);
  return client;
}

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) => ApiService(
  ref.watch(appClientProvider)
);

@Riverpod(keepAlive: true)
Future<ColorScheme> colorScheme(Ref ref, BuildContext context) async {
  return ColorScheme.of(context);
}

@Riverpod(keepAlive: true)
Future<TextTheme >textTheme(Ref ref, BuildContext context) async {
  TextTheme.of(context);
  return Theme.of(context).textTheme;
}

@Riverpod(keepAlive: true)
Future<PaletteExtension> palette(Ref ref, BuildContext? context) async {
  return context!.palette;
}

@riverpod
Future<void> remoteStartup(Ref ref) async {
  ref.watch(appClientProvider);
  ref.watch(sharedPreferenceServiceProvider);
  ref.watch(apiServiceProvider);
}

@riverpod
Future<void> themeStartup(Ref ref, BuildContext context) async {

}
