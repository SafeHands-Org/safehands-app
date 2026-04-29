import 'package:frontend/models/models.dart';
import 'package:frontend/services/api/models/family/family_api_requests.dart';

abstract class FamilyMemberRepository {
  Future<Map<String, FamilyMember>> getFamilyMembers();
  Future<void> addFamilyMember(String userId, FamilyMemberRequest data);
  Future<FamilyMember> getFamilyMember(String id);
  Future<void> updateFamilyMember(String id, FamilyMemberUpdate data);
  Future<void> removeFamilyMember(String id);
}