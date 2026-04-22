import 'dart:io';

import 'package:frontend/config/api_client.dart';
import 'package:frontend/services/shared_preferences.dart';
import 'package:http/io_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_providers.g.dart';

@Riverpod(keepAlive: true)
AuthenticatedClient authenticatedClient(Ref ref) {
  final token = SharedPreferenceService().fetchToken() as String;
  final client = AuthenticatedClient(IOClient(HttpClient()), token);
  ref.onDispose(client.close);
  return client;
}

@Riverpod(keepAlive: true)
String baseUrl(Ref ref) {
  return 'http://127.0.0.1:8000';
}

@riverpod
String familyUrl(Ref ref) {
  String baseUrl = ref.watch(baseUrlProvider);
  return '$baseUrl/api/families';
}

@riverpod
String medicationUrl(Ref ref) {
  String baseUrl = ref.watch(baseUrlProvider);
  return '$baseUrl/api/medications';
}

@riverpod
String authUrl(Ref ref) {
  String baseUrl = ref.watch(baseUrlProvider);
  return '$baseUrl/api/auth';
}

@riverpod
String dashboardUrl(Ref ref) {
  String baseUrl = ref.watch(baseUrlProvider);
  return '$baseUrl/api/dashboard';
}

@riverpod
String usersUrl(Ref ref) {
  String baseUrl = ref.watch(baseUrlProvider);
  return '$baseUrl/api/users';
}