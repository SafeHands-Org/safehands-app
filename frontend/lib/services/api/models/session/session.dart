import 'package:dart_mappable/dart_mappable.dart';
import 'package:frontend/services/api/models/user/user.dart';

part 'session.mapper.dart';

@MappableClass()
class Session with SessionMappable {
  final User? user;
  final String? token;

  Session({required this.user, required this.token});
}
