import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/family_member/family_member_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/api/models/family/family_api_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:frontend/utils/types.dart';

class FamilyMemberRepositoryRemote extends FamilyMemberRepository {
  FamilyMemberRepositoryRemote(this._api, this._baseUrl);

  final ApiService _api;
  final String _baseUrl;

  Stream<void> get changes => _changeController.stream;
  void _notifyChange() => _changeController.add(null);

  final _changeController = StreamController<void>.broadcast();
  final _cachedMembers = <String, FamilyMember>{};

  @override
  Future<FamilyMemberships> getFamilyMembers() async {
    try {
      if (_cachedMembers.isEmpty) {
        final result = await _api.get('$_baseUrl/members');
        final data = jsonDecode(result.body) as List;

        if (data.isEmpty) return <String, FamilyMember>{};

        final membersList = data.map((element) => FamilyMemberMapper.fromMap(element['member'])).toList();

        _cachedMembers.addAll({ for (final member in membersList) member.id: member });
      }
    } on Exception {
      rethrow;
    }
    return Map.unmodifiable(_cachedMembers);
  }

  @override
  Future<void> addFamilyMember(String userId, FamilyMemberRequest data) async {
    if (_cachedMembers.values.any((m) => m.uid == userId)) throw DuplicateException("Member already added.");

    try {
      final result = await _api.post('$_baseUrl/members', data.toMap());
      final json = jsonDecode(result.body);
      FamilyMember newFamilyMember = FamilyMemberMapper.fromMap(json);
      _cachedMembers[newFamilyMember.id] = newFamilyMember;
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<FamilyMember> getFamilyMember(String id) async {
    try {
      if (!_cachedMembers.containsKey(id)) {
        final result = await _api.get('$_baseUrl/members/$id');
        FamilyMember member = FamilyMemberMapper.fromMap(result.value);
        _cachedMembers[member.id] = member;
        _notifyChange();
      }

    } on Exception {
      rethrow;
    }

    return _cachedMembers[id]!;
  }

  @override
  Future<void> updateFamilyMember(String id, FamilyMemberUpdate data) async {
    if (!_cachedMembers.containsKey(id)) throw NotFoundException();
    try {
      final result = await _api.put('$_baseUrl/members/$id', {'riskLevel': data.riskLevel?.toLowerCase()});
      final json = jsonDecode(result.body);
      FamilyMember updatedFamilyMember = FamilyMemberMapper.fromMap(json);
      _cachedMembers.update(id, (member) => updatedFamilyMember);
      _notifyChange();
    } on Exception {
      print('EXCEPTION: $Exception');
      rethrow;
    }
  }

  @override
  Future<void> removeFamilyMember(String id) async {
    if (!_cachedMembers.containsKey(id)) throw NotFoundException();

    try {
      await _api.delete('$_baseUrl/members/$id');
       _cachedMembers.remove(id);
       _notifyChange();
    } on Exception {
      rethrow;
    }
  }
}