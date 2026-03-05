import 'package:dart_mappable/dart_mappable.dart';

part 'client.mapper.dart';

@MappableClass()
class Client with ClientMappable{
  final String name;
  final String email;
  final String role;

  Client({
    required this.name,
    required this.email,
    required this.role,
  });
}