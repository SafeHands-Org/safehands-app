import 'package:dart_mappable/dart_mappable.dart';

part 'family_api_requests.mapper.dart';

@MappableClass()
class FamilyRequest with FamilyRequestMappable {
  final String name;
  final String createdBy;

  const FamilyRequest({
    required this.name,
    required this.createdBy,
  });
}

@MappableClass()
class FamilyMemberRequest with FamilyMemberRequestMappable {
  final String userId;
  final String familyId;
  final String riskLevel;

  const FamilyMemberRequest({
    required this.userId,
    required this.familyId,
    required this.riskLevel,
  });
}

@MappableClass()
class FamilyMemberUpdate with FamilyMemberRequestMappable {
  final String? riskLevel;

  const FamilyMemberUpdate({
    this.riskLevel,
  });
}

@MappableClass()
class InvitationRequest with InvitationRequestMappable {
  final String id;

  const InvitationRequest({
    required this.id
  });
}
