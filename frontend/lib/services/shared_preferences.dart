import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService(this._prefs);

  final SharedPreferencesWithCache _prefs;

  static const _tokenKey = 'AUTH_KEY';
  static const _currentFamilyKey = 'FAMILY_KEY';
  static const _inviteKey = 'INVITE_KEY';

  Future<void> setToken(String token) => _prefs.setString(_tokenKey, token);
  Future<void> clearToken() => _prefs.remove(_tokenKey);
  String? getToken() => _prefs.getString(_tokenKey);

  Future<void> setFid(String fid) => _prefs.setString(_currentFamilyKey, fid);
  Future<void> clearFid() => _prefs.remove(_currentFamilyKey);
  String? fetchFid() => _prefs.getString(_currentFamilyKey);

  Future<void> setInvite(String invite) => _prefs.setString(_inviteKey, invite);
  Future<void> clearInvite() => _prefs.remove(_inviteKey);
  String? fetchInvite() => _prefs.getString(_inviteKey);
}