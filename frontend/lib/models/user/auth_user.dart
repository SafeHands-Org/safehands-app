import 'package:dart_mappable/dart_mappable.dart';
import 'package:frontend/models/enums/enums.dart';

part 'auth_user.mapper.dart';

@MappableClass()
class AuthUser with AuthUserMappable {
  final String? id;
  final String? name;
  final String? email;
  final UserRole? role;
  final String? token;

  const AuthUser({
    this.id,
    this.name,
    this.email,
    this.role,
    this.token,
  });

  bool get isLoggedIn => token != null;
}