import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/invitation/invitation_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/family/family_api_requests.dart';
import 'package:frontend/services/shared_preferences.dart';
import 'package:http/http.dart';

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
  Future<bool> checkInvitation(String id, String token) async {
    try {
      if (_cachedInvitation.isEmpty) {
        final result = await _api.get('$_baseUrl/members');
        final data = jsonDecode(result.body);
        if (data == false) return false;
      }
    } on Exception {
      rethrow;
    }
    return true;
  }

  @override
  Future<Invitation> getInvitation(String id) async {
    try {
      if (!_cachedInvitation.containsKey(id)) {
        final result = await _api.post('$_baseUrl/invitations', {'familyId': id});
        Invitation invitation = InvitationMapper.fromMap(result.value);
        _cachedInvitation[id] = invitation ;
        _notifyChange();
      }
    } on Exception {
      rethrow;
    }
    return _cachedInvitation[id]!;
  }

  @override
  Future<void> createInvitation(String id, InvitationRequest data) async {
    try {
      if (!_cachedInvitation.containsKey(id)) {
        final Response result = await _api.post('$_baseUrl/invitation', data.toMap());
        final json = jsonDecode(result.body);

        final newInvitation = InvitationMapper.fromMap(json);

        _cachedInvitation[id] = newInvitation;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<void> saveInviteToken(String fid, String token) async => await _storage.saveInviteToken(fid, token);
  Future<void> clearInviteToken(String fid) async => await _storage.clearInviteToken(fid);
  Future<String> fetchInviteToken(String fid) async => await _storage.fetchInviteToken(fid) ?? '';
}