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
  static String _$medicationId(FamilyMemberMedication v) => v.medicationId;
  static const Field<FamilyMemberMedication, String> _f$medicationId = Field(
    'medicationId',
    _$medicationId,
  );
  static String _$familyMemberId(FamilyMemberMedication v) => v.familyMemberId;
  static const Field<FamilyMemberMedication, String> _f$familyMemberId = Field(
    'familyMemberId',
    _$familyMemberId,
  );
  static String _$priority(FamilyMemberMedication v) => v.priority;
  static const Field<FamilyMemberMedication, String> _f$priority = Field(
    'priority',
    _$priority,
  );
  static int _$quantity(FamilyMemberMedication v) => v.quantity;
  static const Field<FamilyMemberMedication, int> _f$quantity = Field(
    'quantity',
    _$quantity,
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
    #medicationId: _f$medicationId,
    #familyMemberId: _f$familyMemberId,
    #priority: _f$priority,
    #quantity: _f$quantity,
    #active: _f$active,
  };

  static FamilyMemberMedication _instantiate(DecodingData data) {
    return FamilyMemberMedication(
      id: data.dec(_f$id),
      medicationId: data.dec(_f$medicationId),
      familyMemberId: data.dec(_f$familyMemberId),
      priority: data.dec(_f$priority),
      quantity: data.dec(_f$quantity),
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
    String? medicationId,
    String? familyMemberId,
    String? priority,
    int? quantity,
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
    String? medicationId,
    String? familyMemberId,
    String? priority,
    int? quantity,
    bool? active,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (medicationId != null) #medicationId: medicationId,
      if (familyMemberId != null) #familyMemberId: familyMemberId,
      if (priority != null) #priority: priority,
      if (quantity != null) #quantity: quantity,
      if (active != null) #active: active,
    }),
  );
  @override
  FamilyMemberMedication $make(CopyWithData data) => FamilyMemberMedication(
    id: data.get(#id, or: $value.id),
    medicationId: data.get(#medicationId, or: $value.medicationId),
    familyMemberId: data.get(#familyMemberId, or: $value.familyMemberId),
    priority: data.get(#priority, or: $value.priority),
    quantity: data.get(#quantity, or: $value.quantity),
    active: data.get(#active, or: $value.active),
  );

  @override
  FamilyMemberMedicationCopyWith<$R2, FamilyMemberMedication, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FamilyMemberMedicationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

