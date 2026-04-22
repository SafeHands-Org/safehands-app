import 'package:dart_mappable/dart_mappable.dart';
import 'package:frontend/utils/utils.dart';

part 'family.mapper.dart';

@MappableClass()
class Family with FamilyMappable{
  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;

  const Family({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
  });

  factory Family.empty() => Family(
    id: '',
    name: '',
    createdBy: '',
    createdAt: DateTime.now()
  );

  bool get isEmpty => id.isEmpty && name.isEmpty && createdBy.isEmpty;
  bool get isNotEmpty => !isEmpty;

  Duration get age => difference(createdAt);
  String get ageLabel => durationSince(age);
}