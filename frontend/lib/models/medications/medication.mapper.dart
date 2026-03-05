// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medication.dart';

class MedicationMapper extends ClassMapperBase<Medication> {
  MedicationMapper._();

  static MedicationMapper? _instance;
  static MedicationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Medication';

  static String _$id(Medication v) => v.id;
  static const Field<Medication, String> _f$id = Field('id', _$id);
  static String _$nameEntered(Medication v) => v.nameEntered;
  static const Field<Medication, String> _f$nameEntered = Field(
    'nameEntered',
    _$nameEntered,
  );
  static String _$rxcui(Medication v) => v.rxcui;
  static const Field<Medication, String> _f$rxcui = Field('rxcui', _$rxcui);
  static String _$dosage(Medication v) => v.dosage;
  static const Field<Medication, String> _f$dosage = Field('dosage', _$dosage);
  static String _$doseForm(Medication v) => v.doseForm;
  static const Field<Medication, String> _f$doseForm = Field(
    'doseForm',
    _$doseForm,
  );
  static String _$instructions(Medication v) => v.instructions;
  static const Field<Medication, String> _f$instructions = Field(
    'instructions',
    _$instructions,
  );
  static String _$createdBy(Medication v) => v.createdBy;
  static const Field<Medication, String> _f$createdBy = Field(
    'createdBy',
    _$createdBy,
  );
  static String _$createdAt(Medication v) => v.createdAt;
  static const Field<Medication, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<Medication> fields = const {
    #id: _f$id,
    #nameEntered: _f$nameEntered,
    #rxcui: _f$rxcui,
    #dosage: _f$dosage,
    #doseForm: _f$doseForm,
    #instructions: _f$instructions,
    #createdBy: _f$createdBy,
    #createdAt: _f$createdAt,
  };

  static Medication _instantiate(DecodingData data) {
    return Medication(
      id: data.dec(_f$id),
      nameEntered: data.dec(_f$nameEntered),
      rxcui: data.dec(_f$rxcui),
      dosage: data.dec(_f$dosage),
      doseForm: data.dec(_f$doseForm),
      instructions: data.dec(_f$instructions),
      createdBy: data.dec(_f$createdBy),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Medication fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Medication>(map);
  }

  static Medication fromJson(String json) {
    return ensureInitialized().decodeJson<Medication>(json);
  }
}

mixin MedicationMappable {
  String toJson() {
    return MedicationMapper.ensureInitialized().encodeJson<Medication>(
      this as Medication,
    );
  }

  Map<String, dynamic> toMap() {
    return MedicationMapper.ensureInitialized().encodeMap<Medication>(
      this as Medication,
    );
  }

  MedicationCopyWith<Medication, Medication, Medication> get copyWith =>
      _MedicationCopyWithImpl<Medication, Medication>(
        this as Medication,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MedicationMapper.ensureInitialized().stringifyValue(
      this as Medication,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicationMapper.ensureInitialized().equalsValue(
      this as Medication,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicationMapper.ensureInitialized().hashValue(this as Medication);
  }
}

extension MedicationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Medication, $Out> {
  MedicationCopyWith<$R, Medication, $Out> get $asMedication =>
      $base.as((v, t, t2) => _MedicationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MedicationCopyWith<$R, $In extends Medication, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? nameEntered,
    String? rxcui,
    String? dosage,
    String? doseForm,
    String? instructions,
    String? createdBy,
    String? createdAt,
  });
  MedicationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MedicationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Medication, $Out>
    implements MedicationCopyWith<$R, Medication, $Out> {
  _MedicationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Medication> $mapper =
      MedicationMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? nameEntered,
    String? rxcui,
    String? dosage,
    String? doseForm,
    String? instructions,
    String? createdBy,
    String? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (nameEntered != null) #nameEntered: nameEntered,
      if (rxcui != null) #rxcui: rxcui,
      if (dosage != null) #dosage: dosage,
      if (doseForm != null) #doseForm: doseForm,
      if (instructions != null) #instructions: instructions,
      if (createdBy != null) #createdBy: createdBy,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  Medication $make(CopyWithData data) => Medication(
    id: data.get(#id, or: $value.id),
    nameEntered: data.get(#nameEntered, or: $value.nameEntered),
    rxcui: data.get(#rxcui, or: $value.rxcui),
    dosage: data.get(#dosage, or: $value.dosage),
    doseForm: data.get(#doseForm, or: $value.doseForm),
    instructions: data.get(#instructions, or: $value.instructions),
    createdBy: data.get(#createdBy, or: $value.createdBy),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  MedicationCopyWith<$R2, Medication, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MedicationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

