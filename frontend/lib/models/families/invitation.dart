import 'package:dart_mappable/dart_mappable.dart';

part 'invitation.mapper.dart';

@MappableClass()
class Invitation with InvitationMappable {
  final String id;
  final String familyId;
  final String role;
  final String token;
  final DateTime expiresAt;
  final bool used;
  final String createdBy;
  final DateTime createdAt;

  const Invitation({
    required this.id,
    required this.familyId,
    required this.role,
    required this.token,
    required this.expiresAt,
    required this.used,
    required this.createdBy,
    required this.createdAt
  });
}