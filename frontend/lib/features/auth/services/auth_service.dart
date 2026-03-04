import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';

  static const String baseUrl = "http://localhost:8000";

  // LOGIN stays the same
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data["token"];
      await _storage.write(key: _tokenKey, value: token);
      return token;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  // REGISTER now accepts 4 arguments
  Future<String> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "role": role,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data["token"];
      await _storage.write(key: _tokenKey, value: token);
      return token;
    } else {
      throw Exception("Register failed: ${response.body}");
    }
  }

  // LOGOUT
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // GET token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }
}