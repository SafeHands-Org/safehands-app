// ignore_for_file: non_constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';

part 'family_member.mapper.dart';

enum FamilyRole { admin, caregiver, member }

@MappableClass()
class FamilyMember with FamilyMemberMappable {
  final String id;
  final String userId;
  final String familyId;
  final String riskLevel;
  final bool isAdmin;
  final DateTime createdAt;

  const FamilyMember({
    required this.id,
    required this.userId,
    required this.familyId,
    required this.riskLevel,
    required this.isAdmin,
    required this.createdAt,
  });
}
