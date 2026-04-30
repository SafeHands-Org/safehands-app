import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:frontend/models/user/auth_user.dart';
import 'package:frontend/repositories/auth/auth_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/user/user_api_requests.dart';
import 'package:frontend/services/shared_preferences.dart';

class AuthRepositoryRemote extends AuthRepository {
  final ApiService _api;
  final SharedPreferenceService _storage;
  final String _baseUrl;

  AuthRepositoryRemote(this._api, this._storage, this._baseUrl);

  String? get token => _storage.getToken();

  @override
  Future<AuthUser> login(LoginRequest request) async {
    try {
      final response = await _api.post('$_baseUrl/login', request.toMap());

      final data = jsonDecode(response.body);
      debugPrint('Got data');
      final user = AuthUserMapper.fromMap(data['user']);
      debugPrint('Stored data');
      if (user.token != null) await _storage.setToken(user.token!);
      debugPrint('Stored token');
      return user;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<AuthUser> register(RegisterRequest request) async {
    try {
      final result = await _api.post('$_baseUrl/register', request.toMap());
      print('Success');
      final data = jsonDecode(result.body);
      print(data);
      final user = AuthUserMapper.fromMap(data['user']);
      print(user.token);
      if (user.token != null) await _storage.setToken(user.token!);

      return user;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _storage.clearFid();
    await _storage.clearInvite();
    await _storage.clearToken();
  }
  bool isLoggedIn() => _storage.getToken() == null ? false : true;
}