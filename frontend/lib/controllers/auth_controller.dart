import 'package:flutter/material.dart';
import 'package:frontend/services/api/models/login/login_request.dart';
import 'package:frontend/services/api/models/registration/register_request.dart';
import 'package:frontend/services/api/models/session/session.dart';
import 'package:frontend/services/api/models/user/user.dart';
import 'package:frontend/services/auth_service.dart';

enum AuthState {
  loading,
  authenticated,
  unauthenticated,
}

enum RoleState {
  caregiver,
  familyMember
}

class AuthController extends ChangeNotifier {
  final AuthService _service;

  AuthState state = AuthState.loading;
  RoleState roleState = RoleState.familyMember;

  late Session _session;

  Session get session => _session;
  User? get user => _session.user;

  String get currentUserId => _session.user!.id;

  AuthController(this._service);

  Future<void> login(String email, String password) async {
    final result = await _service.login(LoginRequest(email: email, password: password));
    _session = Session(user: result.user, token: result.token);

    if (result.user.role == 'caregiver') {
      roleState = RoleState.caregiver;
    }
    else {
      roleState = RoleState.familyMember;
    }

    state = AuthState.authenticated;
    print('User Authenticated by login');
    notifyListeners();
  }

  Future<void> register(String name, String email, String password, String role) async {
    final result = await _service.register(RegisterRequest(
      name: name, email: email, password: password, role: role));
    _session = Session(user: result.user, token: result.token);

    if (result.user.role == 'caregiver') {
      roleState = RoleState.caregiver;
    }
    else {
      roleState = RoleState.familyMember;
    }

    state = AuthState.authenticated;
    print('User Authenticated by registration');
    notifyListeners();
  }

  Future<void> logout() async {
    await _service.clearToken();
    _session = Session(user: null, token: null);
    state = AuthState.unauthenticated;
    print('User Unauthenticated by logout');
    notifyListeners();
  }

  Future<void> restoreSession() async {
    final user = await _service.fetchMe();

    if (user != null) {
      final token = await _service.getToken();
       _session = Session(user: user, token: token);
       state = AuthState.authenticated;
       print('User Authenticated by fetch');
    } else {
      state = AuthState.unauthenticated;
      print('User Unauthenticated by fetch');
    }

    notifyListeners();
  }
}