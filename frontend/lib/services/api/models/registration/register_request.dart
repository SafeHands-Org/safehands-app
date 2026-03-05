import 'package:dart_mappable/dart_mappable.dart';

part 'register_request.mapper.dart';

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