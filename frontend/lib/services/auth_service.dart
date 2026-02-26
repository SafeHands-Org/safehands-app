import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';

class AuthService {
  static const storage = FlutterSecureStorage();

  static Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data["token"];

        await storage.write(key: "jwt", value: token);

        return null; // success
      } else {
        return "Invalid email or password";
      }
    } catch (e) {
      return "Connection error. Is backend running?";
    }
  }
}