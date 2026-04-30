import 'package:flutter/material.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_providers.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
Future<SharedPreferencesWithCache> sharedPreferences(Ref ref) {
  return SharedPreferencesWithCache.create(cacheOptions: const SharedPreferencesWithCacheOptions(allowList:null));
}

@Riverpod(keepAlive: true)
SharedPreferenceService sharedPreferenceService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferenceService(prefs.value!);
}

@Riverpod(keepAlive: true)
Client appClient(Ref ref) {
  final client = Client();
  ref.onDispose(client.close);
  return client;
}

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) => ApiService(
  ref.watch(appClientProvider),
  ref.watch(sharedPreferenceServiceProvider)
);

@riverpod
Future<void> remoteStartup(Ref ref) async {
  ref.watch(appClientProvider);
  ref.watch(sharedPreferenceServiceProvider);
  ref.watch(apiServiceProvider);
}
