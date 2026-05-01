import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_providers.g.dart';

@Riverpod(keepAlive: true)
String baseUrl(Ref ref) {
  if (Platform.isAndroid) {
    // Use http://{YOUR_MACHINES_IP}:8000 when running physically
    return 'http://10.0.2.2:8000';
  }

  if (Platform.isIOS) {
    // Use http://{YOUR_MACHINES_IP}:8000 when running physically
    return 'http://127.0.0.1:8000';
  }

  return 'http://localhost:8000';
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