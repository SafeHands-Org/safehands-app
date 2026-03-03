import 'package:dart_mappable/dart_mappable.dart';

part 'family_member.mapper.dart';

enum FamilyRole { admin, caregiver, member }

@MappableClass()
class FamilyMember with FamilyMemberMappable {
  final String id;
  final String userId;
  final String familyId;
  final String name;
  final FamilyRole role;

  const FamilyMember({
    required this.id,
    required this.userId,
    required this.familyId,
    required this.name,
    required this.role,
  });
}