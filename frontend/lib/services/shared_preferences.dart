import 'package:frontend/utils/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const _tokenKey = 'AUTH_KEY';
  static const _currentFamilyKey = 'FAMILY_KEY';

  Future<String?> fetchToken() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString(_tokenKey);
      return token;
    } on Exception {
      throw SessionException();
    }
  }

  Future<void> saveToken(String token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.getString(_tokenKey) != null) {
        sharedPreferences.remove(_tokenKey);
      }
      sharedPreferences.setString(_tokenKey, token);
      return;
    } on Exception {
      throw SessionException();
    }
  }

  Future<void> clearToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_tokenKey);
  }

  Future<void> saveFid(String fid) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.getString(_currentFamilyKey) != null) sharedPreferences.remove(_currentFamilyKey);
      sharedPreferences.setString(_currentFamilyKey, fid);
    } on Exception {
      throw Exception();
    }
  }

  Future<String?> fetchFid() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final fid = sharedPreferences.getString(_currentFamilyKey);
      return fid;
    } on Exception {
      throw Exception();
    }
  }

  Future<void> clearFid() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_currentFamilyKey);
  }

    Future<void> saveInviteToken(String fid, String token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.getString(fid) != null) sharedPreferences.remove(fid);
      sharedPreferences.setString(fid, token);
    } on Exception {
      throw Exception();
    }
  }

  Future<String?> fetchInviteToken(String fid) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString(fid);
      return token;
    } on Exception {
      throw Exception();
    }
  }

  Future<void> clearInviteToken(String fid) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(fid);
  }
}