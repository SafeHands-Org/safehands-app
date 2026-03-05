// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'family_member.dart';

class FamilyMemberMapper extends ClassMapperBase<FamilyMember> {
  FamilyMemberMapper._();

  static FamilyMemberMapper? _instance;
  static FamilyMemberMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FamilyMemberMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FamilyMember';

  static String _$id(FamilyMember v) => v.id;
  static const Field<FamilyMember, String> _f$id = Field('id', _$id);
  static String _$userId(FamilyMember v) => v.userId;
  static const Field<FamilyMember, String> _f$userId = Field(
    'userId',
    _$userId,
  );
  static String _$familyId(FamilyMember v) => v.familyId;
  static const Field<FamilyMember, String> _f$familyId = Field(
    'familyId',
    _$familyId,
  );
  static String _$riskLevel(FamilyMember v) => v.riskLevel;
  static const Field<FamilyMember, String> _f$riskLevel = Field(
    'riskLevel',
    _$riskLevel,
  );
  static bool _$isAdmin(FamilyMember v) => v.isAdmin;
  static const Field<FamilyMember, bool> _f$isAdmin = Field(
    'isAdmin',
    _$isAdmin,
  );
  static DateTime _$createdAt(FamilyMember v) => v.createdAt;
  static const Field<FamilyMember, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<FamilyMember> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #familyId: _f$familyId,
    #riskLevel: _f$riskLevel,
    #isAdmin: _f$isAdmin,
    #createdAt: _f$createdAt,
  };

  static FamilyMember _instantiate(DecodingData data) {
    return FamilyMember(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      familyId: data.dec(_f$familyId),
      riskLevel: data.dec(_f$riskLevel),
      isAdmin: data.dec(_f$isAdmin),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FamilyMember fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FamilyMember>(map);
  }

  static FamilyMember fromJson(String json) {
    return ensureInitialized().decodeJson<FamilyMember>(json);
  }
}

mixin FamilyMemberMappable {
  String toJson() {
    return FamilyMemberMapper.ensureInitialized().encodeJson<FamilyMember>(
      this as FamilyMember,
    );
  }

  Map<String, dynamic> toMap() {
    return FamilyMemberMapper.ensureInitialized().encodeMap<FamilyMember>(
      this as FamilyMember,
    );
  }

  FamilyMemberCopyWith<FamilyMember, FamilyMember, FamilyMember> get copyWith =>
      _FamilyMemberCopyWithImpl<FamilyMember, FamilyMember>(
        this as FamilyMember,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FamilyMemberMapper.ensureInitialized().stringifyValue(
      this as FamilyMember,
    );
  }

  @override
  bool operator ==(Object other) {
    return FamilyMemberMapper.ensureInitialized().equalsValue(
      this as FamilyMember,
      other,
    );
  }

  @override
  int get hashCode {
    return FamilyMemberMapper.ensureInitialized().hashValue(
      this as FamilyMember,
    );
  }
}

extension FamilyMemberValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FamilyMember, $Out> {
  FamilyMemberCopyWith<$R, FamilyMember, $Out> get $asFamilyMember =>
      $base.as((v, t, t2) => _FamilyMemberCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FamilyMemberCopyWith<$R, $In extends FamilyMember, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? familyId,
    String? riskLevel,
    bool? isAdmin,
    DateTime? createdAt,
  });
  FamilyMemberCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FamilyMemberCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FamilyMember, $Out>
    implements FamilyMemberCopyWith<$R, FamilyMember, $Out> {
  _FamilyMemberCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FamilyMember> $mapper =
      FamilyMemberMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? familyId,
    String? riskLevel,
    bool? isAdmin,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (familyId != null) #familyId: familyId,
      if (riskLevel != null) #riskLevel: riskLevel,
      if (isAdmin != null) #isAdmin: isAdmin,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  FamilyMember $make(CopyWithData data) => FamilyMember(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    familyId: data.get(#familyId, or: $value.familyId),
    riskLevel: data.get(#riskLevel, or: $value.riskLevel),
    isAdmin: data.get(#isAdmin, or: $value.isAdmin),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  FamilyMemberCopyWith<$R2, FamilyMember, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FamilyMemberCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

