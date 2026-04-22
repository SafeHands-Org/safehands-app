import 'package:dart_mappable/dart_mappable.dart';

part 'family_member.mapper.dart';

/*
Caregiver
"member": {
  "id": "f284575f-7faa-41f3-bbd7-e10545fca48c",
  "uid": "0432ab9c-eedc-421f-8903-dc4f70b513a3",
  "fid": "c8fb062a-ca7a-44e8-9850-71a17dd0cc2f",
  "name": "Malcolm",
  "risklevel": "high",
  "isAdmin": false,
  "createdAt": "2026-04-01 20:52:50.864102"
}

Family Members
"member": {
  "id": "f284575f-7faa-41f3-bbd7-e10545fca48c",
  "name": "Malcolm",
  "isAdmin": false
}

 */
@MappableClass()
class FamilyMember with FamilyMemberMappable{
  final String id;
  final String uid;
  final String fid;
  final String name;
  final String risklevel;
  final bool isAdmin;
  final DateTime createdAt;

  const FamilyMember({
    required this.id,
    required this.uid,
    required this.fid,
    required this.name,
    required this.risklevel,
    required this.isAdmin,
    required this.createdAt,
  });

  factory FamilyMember.empty() => FamilyMember(
    id: '',
    uid: '',
    fid: '',
    name: '',
    risklevel: '',
    isAdmin: false,
    createdAt:  DateTime.now()
  );

  bool get isEmpty => id.isEmpty && uid.isEmpty && fid.isEmpty;
  bool get isNotEmpty => !isEmpty;
}