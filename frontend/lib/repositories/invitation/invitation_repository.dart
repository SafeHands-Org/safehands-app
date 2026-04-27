import 'package:frontend/models/models.dart';
import 'package:frontend/services/api/models/family/family_api_requests.dart';

abstract class InvitationRepository {
  Future<Invitation> getInvitation(String id);

  Future<bool> checkInvitation(String id, String token);

  Future<void> createInvitation(String id, InvitationRequest data);
}