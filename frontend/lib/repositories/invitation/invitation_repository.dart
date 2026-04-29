import 'package:frontend/models/models.dart';

abstract class InvitationRepository {
  Future<Invitation> getInvitation(String id);
}