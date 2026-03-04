// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'family_member_medication.dart';

class FamilyMemberMedicationMapper
    extends ClassMapperBase<FamilyMemberMedication> {
  FamilyMemberMedicationMapper._();

  static FamilyMemberMedicationMapper? _instance;
  static FamilyMemberMedicationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FamilyMemberMedicationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FamilyMemberMedication';

  static String _$id(FamilyMemberMedication v) => v.id;
  static const Field<FamilyMemberMedication, String> _f$id = Field('id', _$id);
  static String _$familyMemberId(FamilyMemberMedication v) => v.familyMemberId;
  static const Field<FamilyMemberMedication, String> _f$familyMemberId = Field(
    'familyMemberId',
    _$familyMemberId,
  );
  static String _$medicationId(FamilyMemberMedication v) => v.medicationId;
  static const Field<FamilyMemberMedication, String> _f$medicationId = Field(
    'medicationId',
    _$medicationId,
  );
  static String _$scheduleId(FamilyMemberMedication v) => v.scheduleId;
  static const Field<FamilyMemberMedication, String> _f$scheduleId = Field(
    'scheduleId',
    _$scheduleId,
  );
  static DateTime _$assignedAt(FamilyMemberMedication v) => v.assignedAt;
  static const Field<FamilyMemberMedication, DateTime> _f$assignedAt = Field(
    'assignedAt',
    _$assignedAt,
  );
  static bool _$active(FamilyMemberMedication v) => v.active;
  static const Field<FamilyMemberMedication, bool> _f$active = Field(
    'active',
    _$active,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<FamilyMemberMedication> fields = const {
    #id: _f$id,
    #familyMemberId: _f$familyMemberId,
    #medicationId: _f$medicationId,
    #scheduleId: _f$scheduleId,
    #assignedAt: _f$assignedAt,
    #active: _f$active,
  };

  static FamilyMemberMedication _instantiate(DecodingData data) {
    return FamilyMemberMedication(
      id: data.dec(_f$id),
      familyMemberId: data.dec(_f$familyMemberId),
      medicationId: data.dec(_f$medicationId),
      scheduleId: data.dec(_f$scheduleId),
      assignedAt: data.dec(_f$assignedAt),
      active: data.dec(_f$active),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FamilyMemberMedication fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FamilyMemberMedication>(map);
  }

  static FamilyMemberMedication fromJson(String json) {
    return ensureInitialized().decodeJson<FamilyMemberMedication>(json);
  }
}

mixin FamilyMemberMedicationMappable {
  String toJson() {
    return FamilyMemberMedicationMapper.ensureInitialized()
        .encodeJson<FamilyMemberMedication>(this as FamilyMemberMedication);
  }

  Map<String, dynamic> toMap() {
    return FamilyMemberMedicationMapper.ensureInitialized()
        .encodeMap<FamilyMemberMedication>(this as FamilyMemberMedication);
  }

  FamilyMemberMedicationCopyWith<
    FamilyMemberMedication,
    FamilyMemberMedication,
    FamilyMemberMedication
  >
  get copyWith =>
      _FamilyMemberMedicationCopyWithImpl<
        FamilyMemberMedication,
        FamilyMemberMedication
      >(this as FamilyMemberMedication, $identity, $identity);
  @override
  String toString() {
    return FamilyMemberMedicationMapper.ensureInitialized().stringifyValue(
      this as FamilyMemberMedication,
    );
  }

  @override
  bool operator ==(Object other) {
    return FamilyMemberMedicationMapper.ensureInitialized().equalsValue(
      this as FamilyMemberMedication,
      other,
    );
  }

  @override
  int get hashCode {
    return FamilyMemberMedicationMapper.ensureInitialized().hashValue(
      this as FamilyMemberMedication,
    );
  }
}

extension FamilyMemberMedicationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FamilyMemberMedication, $Out> {
  FamilyMemberMedicationCopyWith<$R, FamilyMemberMedication, $Out>
  get $asFamilyMemberMedication => $base.as(
    (v, t, t2) => _FamilyMemberMedicationCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FamilyMemberMedicationCopyWith<
  $R,
  $In extends FamilyMemberMedication,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? familyMemberId,
    String? medicationId,
    String? scheduleId,
    DateTime? assignedAt,
    bool? active,
  });
  FamilyMemberMedicationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FamilyMemberMedicationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FamilyMemberMedication, $Out>
    implements
        FamilyMemberMedicationCopyWith<$R, FamilyMemberMedication, $Out> {
  _FamilyMemberMedicationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FamilyMemberMedication> $mapper =
      FamilyMemberMedicationMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? familyMemberId,
    String? medicationId,
    String? scheduleId,
    DateTime? assignedAt,
    bool? active,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (familyMemberId != null) #familyMemberId: familyMemberId,
      if (medicationId != null) #medicationId: medicationId,
      if (scheduleId != null) #scheduleId: scheduleId,
      if (assignedAt != null) #assignedAt: assignedAt,
      if (active != null) #active: active,
    }),
  );
  @override
  FamilyMemberMedication $make(CopyWithData data) => FamilyMemberMedication(
    id: data.get(#id, or: $value.id),
    familyMemberId: data.get(#familyMemberId, or: $value.familyMemberId),
    medicationId: data.get(#medicationId, or: $value.medicationId),
    scheduleId: data.get(#scheduleId, or: $value.scheduleId),
    assignedAt: data.get(#assignedAt, or: $value.assignedAt),
    active: data.get(#active, or: $value.active),
  );

  @override
  FamilyMemberMedicationCopyWith<$R2, FamilyMemberMedication, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FamilyMemberMedicationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

