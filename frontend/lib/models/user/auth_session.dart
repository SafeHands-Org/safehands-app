import 'package:frontend/models/user/user.dart';

class AuthSession {
  final User user;
  final String token;

  AuthSession({required this.user, required this.token});
}