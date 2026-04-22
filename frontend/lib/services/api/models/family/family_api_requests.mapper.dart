// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'family_api_requests.dart';

class FamilyRequestMapper extends ClassMapperBase<FamilyRequest> {
  FamilyRequestMapper._();

  static FamilyRequestMapper? _instance;
  static FamilyRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FamilyRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FamilyRequest';

  static String _$name(FamilyRequest v) => v.name;
  static const Field<FamilyRequest, String> _f$name = Field('name', _$name);
  static String _$createdBy(FamilyRequest v) => v.createdBy;
  static const Field<FamilyRequest, String> _f$createdBy = Field(
    'createdBy',
    _$createdBy,
  );

  @override
  final MappableFields<FamilyRequest> fields = const {
    #name: _f$name,
    #createdBy: _f$createdBy,
  };

  static FamilyRequest _instantiate(DecodingData data) {
    return FamilyRequest(
      name: data.dec(_f$name),
      createdBy: data.dec(_f$createdBy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FamilyRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FamilyRequest>(map);
  }

  static FamilyRequest fromJson(String json) {
    return ensureInitialized().decodeJson<FamilyRequest>(json);
  }
}

mixin FamilyRequestMappable {
  String toJson() {
    return FamilyRequestMapper.ensureInitialized().encodeJson<FamilyRequest>(
      this as FamilyRequest,
    );
  }

  Map<String, dynamic> toMap() {
    return FamilyRequestMapper.ensureInitialized().encodeMap<FamilyRequest>(
      this as FamilyRequest,
    );
  }

  FamilyRequestCopyWith<FamilyRequest, FamilyRequest, FamilyRequest>
  get copyWith => _FamilyRequestCopyWithImpl<FamilyRequest, FamilyRequest>(
    this as FamilyRequest,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return FamilyRequestMapper.ensureInitialized().stringifyValue(
      this as FamilyRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return FamilyRequestMapper.ensureInitialized().equalsValue(
      this as FamilyRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return FamilyRequestMapper.ensureInitialized().hashValue(
      this as FamilyRequest,
    );
  }
}

extension FamilyRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FamilyRequest, $Out> {
  FamilyRequestCopyWith<$R, FamilyRequest, $Out> get $asFamilyRequest =>
      $base.as((v, t, t2) => _FamilyRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FamilyRequestCopyWith<$R, $In extends FamilyRequest, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? createdBy});
  FamilyRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FamilyRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FamilyRequest, $Out>
    implements FamilyRequestCopyWith<$R, FamilyRequest, $Out> {
  _FamilyRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FamilyRequest> $mapper =
      FamilyRequestMapper.ensureInitialized();
  @override
  $R call({String? name, String? createdBy}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (createdBy != null) #createdBy: createdBy,
    }),
  );
  @override
  FamilyRequest $make(CopyWithData data) => FamilyRequest(
    name: data.get(#name, or: $value.name),
    createdBy: data.get(#createdBy, or: $value.createdBy),
  );

  @override
  FamilyRequestCopyWith<$R2, FamilyRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FamilyRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FamilyMemberRequestMapper extends ClassMapperBase<FamilyMemberRequest> {
  FamilyMemberRequestMapper._();

  static FamilyMemberRequestMapper? _instance;
  static FamilyMemberRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FamilyMemberRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FamilyMemberRequest';

  static String _$userId(FamilyMemberRequest v) => v.userId;
  static const Field<FamilyMemberRequest, String> _f$userId = Field(
    'userId',
    _$userId,
  );
  static String _$familyId(FamilyMemberRequest v) => v.familyId;
  static const Field<FamilyMemberRequest, String> _f$familyId = Field(
    'familyId',
    _$familyId,
  );
  static String _$riskLevel(FamilyMemberRequest v) => v.riskLevel;
  static const Field<FamilyMemberRequest, String> _f$riskLevel = Field(
    'riskLevel',
    _$riskLevel,
  );

  @override
  final MappableFields<FamilyMemberRequest> fields = const {
    #userId: _f$userId,
    #familyId: _f$familyId,
    #riskLevel: _f$riskLevel,
  };

  static FamilyMemberRequest _instantiate(DecodingData data) {
    return FamilyMemberRequest(
      userId: data.dec(_f$userId),
      familyId: data.dec(_f$familyId),
      riskLevel: data.dec(_f$riskLevel),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FamilyMemberRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FamilyMemberRequest>(map);
  }

  static FamilyMemberRequest fromJson(String json) {
    return ensureInitialized().decodeJson<FamilyMemberRequest>(json);
  }
}

mixin FamilyMemberRequestMappable {
  String toJson() {
    return FamilyMemberRequestMapper.ensureInitialized()
        .encodeJson<FamilyMemberRequest>(this as FamilyMemberRequest);
  }

  Map<String, dynamic> toMap() {
    return FamilyMemberRequestMapper.ensureInitialized()
        .encodeMap<FamilyMemberRequest>(this as FamilyMemberRequest);
  }

  FamilyMemberRequestCopyWith<
    FamilyMemberRequest,
    FamilyMemberRequest,
    FamilyMemberRequest
  >
  get copyWith =>
      _FamilyMemberRequestCopyWithImpl<
        FamilyMemberRequest,
        FamilyMemberRequest
      >(this as FamilyMemberRequest, $identity, $identity);
  @override
  String toString() {
    return FamilyMemberRequestMapper.ensureInitialized().stringifyValue(
      this as FamilyMemberRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return FamilyMemberRequestMapper.ensureInitialized().equalsValue(
      this as FamilyMemberRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return FamilyMemberRequestMapper.ensureInitialized().hashValue(
      this as FamilyMemberRequest,
    );
  }
}

extension FamilyMemberRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FamilyMemberRequest, $Out> {
  FamilyMemberRequestCopyWith<$R, FamilyMemberRequest, $Out>
  get $asFamilyMemberRequest => $base.as(
    (v, t, t2) => _FamilyMemberRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FamilyMemberRequestCopyWith<
  $R,
  $In extends FamilyMemberRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? userId, String? familyId, String? riskLevel});
  FamilyMemberRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FamilyMemberRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FamilyMemberRequest, $Out>
    implements FamilyMemberRequestCopyWith<$R, FamilyMemberRequest, $Out> {
  _FamilyMemberRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FamilyMemberRequest> $mapper =
      FamilyMemberRequestMapper.ensureInitialized();
  @override
  $R call({String? userId, String? familyId, String? riskLevel}) => $apply(
    FieldCopyWithData({
      if (userId != null) #userId: userId,
      if (familyId != null) #familyId: familyId,
      if (riskLevel != null) #riskLevel: riskLevel,
    }),
  );
  @override
  FamilyMemberRequest $make(CopyWithData data) => FamilyMemberRequest(
    userId: data.get(#userId, or: $value.userId),
    familyId: data.get(#familyId, or: $value.familyId),
    riskLevel: data.get(#riskLevel, or: $value.riskLevel),
  );

  @override
  FamilyMemberRequestCopyWith<$R2, FamilyMemberRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FamilyMemberRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FamilyMemberUpdateMapper extends ClassMapperBase<FamilyMemberUpdate> {
  FamilyMemberUpdateMapper._();

  static FamilyMemberUpdateMapper? _instance;
  static FamilyMemberUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FamilyMemberUpdateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FamilyMemberUpdate';

  static String? _$riskLevel(FamilyMemberUpdate v) => v.riskLevel;
  static const Field<FamilyMemberUpdate, String> _f$riskLevel = Field(
    'riskLevel',
    _$riskLevel,
    opt: true,
  );

  @override
  final MappableFields<FamilyMemberUpdate> fields = const {
    #riskLevel: _f$riskLevel,
  };

  static FamilyMemberUpdate _instantiate(DecodingData data) {
    return FamilyMemberUpdate(riskLevel: data.dec(_f$riskLevel));
  }

  @override
  final Function instantiate = _instantiate;

  static FamilyMemberUpdate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FamilyMemberUpdate>(map);
  }

  static FamilyMemberUpdate fromJson(String json) {
    return ensureInitialized().decodeJson<FamilyMemberUpdate>(json);
  }
}

mixin FamilyMemberUpdateMappable {
  String toJson() {
    return FamilyMemberUpdateMapper.ensureInitialized()
        .encodeJson<FamilyMemberUpdate>(this as FamilyMemberUpdate);
  }

  Map<String, dynamic> toMap() {
    return FamilyMemberUpdateMapper.ensureInitialized()
        .encodeMap<FamilyMemberUpdate>(this as FamilyMemberUpdate);
  }

  FamilyMemberUpdateCopyWith<
    FamilyMemberUpdate,
    FamilyMemberUpdate,
    FamilyMemberUpdate
  >
  get copyWith =>
      _FamilyMemberUpdateCopyWithImpl<FamilyMemberUpdate, FamilyMemberUpdate>(
        this as FamilyMemberUpdate,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FamilyMemberUpdateMapper.ensureInitialized().stringifyValue(
      this as FamilyMemberUpdate,
    );
  }

  @override
  bool operator ==(Object other) {
    return FamilyMemberUpdateMapper.ensureInitialized().equalsValue(
      this as FamilyMemberUpdate,
      other,
    );
  }

  @override
  int get hashCode {
    return FamilyMemberUpdateMapper.ensureInitialized().hashValue(
      this as FamilyMemberUpdate,
    );
  }
}

extension FamilyMemberUpdateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FamilyMemberUpdate, $Out> {
  FamilyMemberUpdateCopyWith<$R, FamilyMemberUpdate, $Out>
  get $asFamilyMemberUpdate => $base.as(
    (v, t, t2) => _FamilyMemberUpdateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FamilyMemberUpdateCopyWith<
  $R,
  $In extends FamilyMemberUpdate,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? riskLevel});
  FamilyMemberUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FamilyMemberUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FamilyMemberUpdate, $Out>
    implements FamilyMemberUpdateCopyWith<$R, FamilyMemberUpdate, $Out> {
  _FamilyMemberUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FamilyMemberUpdate> $mapper =
      FamilyMemberUpdateMapper.ensureInitialized();
  @override
  $R call({Object? riskLevel = $none}) => $apply(
    FieldCopyWithData({if (riskLevel != $none) #riskLevel: riskLevel}),
  );
  @override
  FamilyMemberUpdate $make(CopyWithData data) =>
      FamilyMemberUpdate(riskLevel: data.get(#riskLevel, or: $value.riskLevel));

  @override
  FamilyMemberUpdateCopyWith<$R2, FamilyMemberUpdate, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FamilyMemberUpdateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

