import 'package:frontend/models/user/auth_user.dart';
import 'package:frontend/services/api/models/user/user_api_requests.dart';

abstract class AuthRepository {
  Future<AuthUser> login(LoginRequest request);
  Future<AuthUser> register(RegisterRequest request);
  Future<void> logout();
  Future<bool> isLoggedIn();
}