import 'dart:async';
import 'dart:convert';

import 'package:frontend/models/models.dart';
import 'package:frontend/repositories/family/family_repository.dart';
import 'package:frontend/services/api/api_service.dart';
import 'package:frontend/services/shared_preferences.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:http/http.dart';

class FamilyRepositoryRemote extends FamilyRepository {
  final ApiService _api;
  final SharedPreferenceService _storage;
  final String _baseUrl;

  FamilyRepositoryRemote(this._api, this._storage, this._baseUrl);

  Stream<void> get changes => _changeController.stream;
  void _notifyChange() => _changeController.add(null);

  final _changeController = StreamController<void>.broadcast();
  final _cachedFamilies = <String, Family>{};

  @override
  Future<Map<String, Family>> getFamilies() async {
    try {
      if (_cachedFamilies.isEmpty) {
        final result = await _api.get('$_baseUrl/');
        final data = jsonDecode(result.body) as List;

        if (data.isEmpty) return <String, Family>{};

        final familyList = data.map((element) => FamilyMapper.fromMap(element['family'])).toList();

        _cachedFamilies.addAll({for (final family in familyList) family.id: family});
      }
    } on Exception {
      rethrow;
    }
    return Map.unmodifiable(_cachedFamilies);
  }

  @override
  Future<void> createFamily(String name) async {
    if (_cachedFamilies.values.any((f) => f.name == name)) throw DuplicateException("$name Family already exists.");

    try {
      final Response result = await _api.post('$_baseUrl/', {'name': name});
      Family newFamily = FamilyMapper.fromMap(jsonDecode(result.body));
      _cachedFamilies.putIfAbsent(newFamily.id, () => newFamily);

      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Family> getFamily(String id) async {
    try {
      if (!_cachedFamilies.containsKey(id)) {
        final result = await _api.get('$_baseUrl/$id');
        Family family = FamilyMapper.fromMap(result.value);
        _cachedFamilies[family.id] = family;
      }
    } on Exception {
      rethrow;
    }

    return _cachedFamilies[id]!;
  }

  @override
  Future<void> updateFamily(String id, String name) async {
    if (!_cachedFamilies.containsKey(id)) throw NotFoundException();

    try {
      final result = await _api.put('$_baseUrl/$id', {'name': name});
      Family updatedFamily = FamilyMapper.fromMap(result.value);
      _cachedFamilies.update(id, (family) => updatedFamily);
      _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> deleteFamily(String id) async {
    if (!_cachedFamilies.containsKey(id)) throw NotFoundException();

    try {
      await _api.delete('$_baseUrl/$id');
       _cachedFamilies.remove(id);
       _notifyChange();
    } on Exception {
      rethrow;
    }
  }

  Future<void> saveCurrentFamily(String fid) async => await _storage.saveFid(fid);
  Future<void> clearCurrentFamily() async => await _storage.clearFid();
  Future<String> fetchCurrentFamily() async => await _storage.fetchFid() ?? '';
}