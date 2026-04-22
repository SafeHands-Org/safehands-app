import 'dart:convert';

import 'package:frontend/models/user/auth_user.dart';
import 'package:frontend/repositories/auth/auth_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/user/user_api_requests.dart';
import 'package:frontend/services/shared_preferences.dart';
import 'package:http/http.dart';

class AuthRepositoryRemote extends AuthRepository {
  final ApiService _api;
  final SharedPreferenceService _storage;
  final String _baseUrl;

  AuthRepositoryRemote(this._api, this._storage, this._baseUrl);

  @override
  Future<AuthUser> login(LoginRequest request) async {
    try {
      final Response response = await _api.post('$_baseUrl/login', request.toMap());

      final data = jsonDecode(response.body);

      final user = AuthUserMapper.fromMap(data['user']);

      if (user.token != null) await _storage.saveToken(user.token!);

      return user;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<AuthUser> register(RegisterRequest request) async {
    try {
      final result = await _api.post('$_baseUrl/login', request.toMap());
      final user = AuthUserMapper.fromMap(result);

      await _storage.saveToken(user.token!);

      return user;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> logout() async => {
    await _storage.clearToken()
  };

  @override
  Future<bool> isLoggedIn() async => await _storage.fetchToken() == null ? false : true;

}