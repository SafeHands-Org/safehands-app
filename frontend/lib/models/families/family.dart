import 'package:dart_mappable/dart_mappable.dart';
import 'package:frontend/models/families/family_member.dart';

part 'family.mapper.dart';

@MappableClass()
class Family with FamilyMappable {
  final String id;
  final String name;
  final DateTime createdAt;

  final List<FamilyMember> members;

  const Family({
    required this.id,
    required this.name,
    required this.createdAt,
    this.members = const [],
  });
}