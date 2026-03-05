import 'package:dart_mappable/dart_mappable.dart';

part 'login_request.mapper.dart';

@MappableClass()
class LoginRequest with LoginRequestMappable{
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });
}