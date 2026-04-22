import 'package:dart_mappable/dart_mappable.dart';

part 'user_api_requests.mapper.dart';

@MappableClass()
class UserUpdate with UserUpdateMappable {
  final String name;
  final String email;

  const UserUpdate({
    required this.name,
    required this.email,
  });
}

@MappableClass()
class LoginRequest with LoginRequestMappable{
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });
}

@MappableClass()
class RegisterRequest with RegisterRequestMappable{
  final String name;
  final String email;
  final String password;
  final String role;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}