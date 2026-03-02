import 'dart:convert';
import 'package:frontend/models/user/user.dart';
import 'package:frontend/models/user/auth_session.dart';
import 'package:frontend/models/user/registration_request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<AuthSession?> register(
    String name, String email, String password, String roleStr) async {
    try {
      final request = RegistrationRequest(
        name: name,
        email: email,
        password: password,
        role: roleStr.toLowerCase(),
      );

      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        final token = data['token'];
        await _saveToken(token);

        return AuthSession(user: user, token: token);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AuthSession?> login(String email, String password) async {
    try {
      await clearToken();

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        final token = data['token'];

        await _saveToken(token);

        return AuthSession(user: user, token: token);
      } else {
        await clearToken();
        return null;
      }
    } catch (e) {
      await clearToken();
      return null;
    }
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }
}