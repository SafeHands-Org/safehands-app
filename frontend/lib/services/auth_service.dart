import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/services/api/models/login/login_request.dart';
import 'package:frontend/services/api/models/login/login_response.dart';
import 'package:frontend/services/api/models/registration/register_request.dart';
import 'package:frontend/services/api/models/user/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<LoginResponse> register(RegisterRequest request) async {
    print(jsonEncode(request.toMap()));

    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toMap()),
    );

    if (response.statusCode != 201) {
      throw Exception("Registration failed: ${response.body}");
    }

    final decoded = jsonDecode(response.body);
    final user = UserMapper.fromMap(decoded['user']);
    final token = decoded['token'];
    final loginResponse = LoginResponse(user: user, token: token);

    await _secureStorage.write(key: 'auth_token', value: loginResponse.token);

    return loginResponse;
  }

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toMap())
    );

    if (response.statusCode != 200) {
      throw Exception("Login failed: ${response.body}");
    }

    final decoded = jsonDecode(response.body);
    final user = UserMapper.fromMap(decoded['user']);
    final token = decoded['token'];
    final loginResponse = LoginResponse(user: user, token: token);

    await _secureStorage.write(key: 'auth_token', value: loginResponse.token);

    return loginResponse;
  }

  Future<User?> fetchMe() async {
    final token = await getToken();

    if (token == null) return null;
    
    final response = await http.get(
      Uri.parse("$baseUrl/auth/me"),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      await clearToken();
      return null;
    }

    return UserMapper.fromJson(response.body);
  }

  Future<String?> getToken() async => await _secureStorage.read(key: 'auth_token');

  Future<void> clearToken() async => await _secureStorage.delete(key: 'auth_token');
}
