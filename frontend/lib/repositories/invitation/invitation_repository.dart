abstract class InvitationRepository {
  Future<bool> checkInvitation(String id);
  Future<void> createInvitation(String id, Map<String, dynamic> data);
}