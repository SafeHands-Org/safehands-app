import 'package:dart_mappable/dart_mappable.dart';

part 'invitation.mapper.dart';

enum InvitationStatus { pending, accepted, declined, expired }

@MappableClass()
class Invitation with InvitationMappable {
  final String id;
  final String familyId;
  final String email;
  final InvitationStatus status;
  final DateTime createdAt;
  final DateTime? expiresAt;

  const Invitation({
    required this.id,
    required this.familyId,
    required this.email,
    required this.status,
    required this.createdAt,
    this.expiresAt,
  });
}