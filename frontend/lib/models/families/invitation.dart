import 'package:dart_mappable/dart_mappable.dart';

part 'invitation.mapper.dart';

@MappableClass()
class Invitation with InvitationMappable{
  final String id;
  final String familyId;
  final String token;
  final DateTime expiration;

  const Invitation({
    required this.id,
    required this.familyId,
    required this.token,
    required this.expiration
  });

  bool get isExpired => DateTime.now().isAfter(expiration);
  bool get isValid => !isExpired;

  Duration get timeRemaining => expiration.difference(DateTime.now());
  String get expirationLabel {
    if (isExpired) return 'Expired';

    final hours   = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes % 60;

    if (hours >= 24) {
      final days = timeRemaining.inDays;
      return 'Expires in $days day${days == 1 ? '' : 's'}';
    }
    if (hours > 0) return 'Expires in ${hours}h ${minutes}m';
    return 'Expires in ${minutes}m';
  }
}