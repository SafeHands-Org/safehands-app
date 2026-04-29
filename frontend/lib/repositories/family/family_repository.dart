import 'package:frontend/models/models.dart';

abstract class FamilyRepository {
  Future<void> getFamilies();
  Future<void> createFamily(String data);

  Future<Family> getFamily(String id);
  Future<void>updateFamily(String id, String data);
  Future<void>deleteFamily(String id);
}