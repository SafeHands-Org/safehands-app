import 'package:dart_mappable/dart_mappable.dart';
import 'package:frontend/services/api/models/user/user.dart';

part 'login_response.mapper.dart';

@MappableClass()
class LoginResponse with LoginResponseMappable {
  final User user;
  final String token;

  LoginResponse({required this.user, required this.token});
}
