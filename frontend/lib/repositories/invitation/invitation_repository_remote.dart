import 'package:frontend/repositories/invitation/invitation_repository.dart';

class InvitationRepositoryRemote extends InvitationRepository {
  InvitationRepositoryRemote();

  @override
  Future<bool> checkInvitation(String id) async {
    return false;
  }

  @override
  Future<void> createInvitation(String id, Map<String, dynamic> data) async {
    return;
  }
}