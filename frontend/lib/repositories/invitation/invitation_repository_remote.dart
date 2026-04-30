import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/invitation/invitation_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/shared_preferences.dart';

class InvitationRepositoryRemote extends InvitationRepository {
  InvitationRepositoryRemote(this._api, this._storage, this._baseUrl);

  final ApiService _api;
  final SharedPreferenceService _storage;
  final String _baseUrl;

  Stream<void> get changes => _changeController.stream;
  void _notifyChange() => _changeController.add(null);

  final _changeController = StreamController<void>.broadcast();
  final _cachedInvitation = <String, Invitation>{};

  @override
  Future<Invitation> getInvitation(String id) async {
    print('$_baseUrl/invitations');
    try {
      if (!_cachedInvitation.containsKey(id)) {
        final result = await _api.get('$_baseUrl/invitations');
        final data = jsonDecode(result.body);
        print(data);
        Invitation invitation = InvitationMapper.fromMap(data);
        _cachedInvitation[id] = invitation ;
        _notifyChange();
      }
    } on Exception {
      rethrow;
    }
    return _cachedInvitation[id]!;
  }

  Future<void> saveInviteToken(String token) async => await _storage.setInvite(token);
  Future<void> clearInviteToken() async => await _storage.clearInvite();
  String? fetchInviteToken() => _storage.fetchInvite();

  void clearCache(){
    _cachedInvitation.clear();
    _notifyChange();
  }
}