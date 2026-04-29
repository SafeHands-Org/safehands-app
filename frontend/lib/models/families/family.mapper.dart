// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'family.dart';

class FamilyMapper extends ClassMapperBase<Family> {
  FamilyMapper._();

  static FamilyMapper? _instance;
  static FamilyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FamilyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Family';

  static String _$id(Family v) => v.id;
  static const Field<Family, String> _f$id = Field('id', _$id);
  static String _$name(Family v) => v.name;
  static const Field<Family, String> _f$name = Field('name', _$name);
  static String _$createdBy(Family v) => v.createdBy;
  static const Field<Family, String> _f$createdBy = Field(
    'createdBy',
    _$createdBy,
  );
  static DateTime _$createdAt(Family v) => v.createdAt;
  static const Field<Family, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<Family> fields = const {
    #id: _f$id,
    #name: _f$name,
    #createdBy: _f$createdBy,
    #createdAt: _f$createdAt,
  };

  static Family _instantiate(DecodingData data) {
    return Family(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      createdBy: data.dec(_f$createdBy),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Family fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Family>(map);
  }

  static Family fromJson(String json) {
    return ensureInitialized().decodeJson<Family>(json);
  }
}

mixin FamilyMappable {
  String toJson() {
    return FamilyMapper.ensureInitialized().encodeJson<Family>(this as Family);
  }

  Map<String, dynamic> toMap() {
    return FamilyMapper.ensureInitialized().encodeMap<Family>(this as Family);
  }

  FamilyCopyWith<Family, Family, Family> get copyWith =>
      _FamilyCopyWithImpl<Family, Family>(this as Family, $identity, $identity);
  @override
  String toString() {
    return FamilyMapper.ensureInitialized().stringifyValue(this as Family);
  }

  @override
  bool operator ==(Object other) {
    return FamilyMapper.ensureInitialized().equalsValue(this as Family, other);
  }

  @override
  int get hashCode {
    return FamilyMapper.ensureInitialized().hashValue(this as Family);
  }
}

extension FamilyValueCopy<$R, $Out> on ObjectCopyWith<$R, Family, $Out> {
  FamilyCopyWith<$R, Family, $Out> get $asFamily =>
      $base.as((v, t, t2) => _FamilyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FamilyCopyWith<$R, $In extends Family, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? createdBy, DateTime? createdAt});
  FamilyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FamilyCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Family, $Out>
    implements FamilyCopyWith<$R, Family, $Out> {
  _FamilyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Family> $mapper = FamilyMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, String? createdBy, DateTime? createdAt}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (name != null) #name: name,
          if (createdBy != null) #createdBy: createdBy,
          if (createdAt != null) #createdAt: createdAt,
        }),
      );
  @override
  Family $make(CopyWithData data) => Family(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    createdBy: data.get(#createdBy, or: $value.createdBy),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  FamilyCopyWith<$R2, Family, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FamilyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

