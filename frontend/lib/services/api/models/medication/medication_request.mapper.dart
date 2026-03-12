// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medication_request.dart';

class MedicationRequestMapper extends ClassMapperBase<MedicationRequest> {
  MedicationRequestMapper._();

  static MedicationRequestMapper? _instance;
  static MedicationRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicationRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MedicationRequest';

  static String _$nameEntered(MedicationRequest v) => v.nameEntered;
  static const Field<MedicationRequest, String> _f$nameEntered = Field(
    'nameEntered',
    _$nameEntered,
  );
  static String? _$rxcui(MedicationRequest v) => v.rxcui;
  static const Field<MedicationRequest, String> _f$rxcui = Field(
    'rxcui',
    _$rxcui,
    opt: true,
  );
  static String? _$dosage(MedicationRequest v) => v.dosage;
  static const Field<MedicationRequest, String> _f$dosage = Field(
    'dosage',
    _$dosage,
    opt: true,
  );
  static String _$doseForm(MedicationRequest v) => v.doseForm;
  static const Field<MedicationRequest, String> _f$doseForm = Field(
    'doseForm',
    _$doseForm,
  );
  static String? _$instructions(MedicationRequest v) => v.instructions;
  static const Field<MedicationRequest, String> _f$instructions = Field(
    'instructions',
    _$instructions,
    opt: true,
  );

  @override
  final MappableFields<MedicationRequest> fields = const {
    #nameEntered: _f$nameEntered,
    #rxcui: _f$rxcui,
    #dosage: _f$dosage,
    #doseForm: _f$doseForm,
    #instructions: _f$instructions,
  };

  static MedicationRequest _instantiate(DecodingData data) {
    return MedicationRequest(
      nameEntered: data.dec(_f$nameEntered),
      rxcui: data.dec(_f$rxcui),
      dosage: data.dec(_f$dosage),
      doseForm: data.dec(_f$doseForm),
      instructions: data.dec(_f$instructions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicationRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicationRequest>(map);
  }

  static MedicationRequest fromJson(String json) {
    return ensureInitialized().decodeJson<MedicationRequest>(json);
  }
}

mixin MedicationRequestMappable {
  String toJson() {
    return MedicationRequestMapper.ensureInitialized()
        .encodeJson<MedicationRequest>(this as MedicationRequest);
  }

  Map<String, dynamic> toMap() {
    return MedicationRequestMapper.ensureInitialized()
        .encodeMap<MedicationRequest>(this as MedicationRequest);
  }

  MedicationRequestCopyWith<
    MedicationRequest,
    MedicationRequest,
    MedicationRequest
  >
  get copyWith =>
      _MedicationRequestCopyWithImpl<MedicationRequest, MedicationRequest>(
        this as MedicationRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MedicationRequestMapper.ensureInitialized().stringifyValue(
      this as MedicationRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicationRequestMapper.ensureInitialized().equalsValue(
      this as MedicationRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicationRequestMapper.ensureInitialized().hashValue(
      this as MedicationRequest,
    );
  }
}

extension MedicationRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicationRequest, $Out> {
  MedicationRequestCopyWith<$R, MedicationRequest, $Out>
  get $asMedicationRequest => $base.as(
    (v, t, t2) => _MedicationRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicationRequestCopyWith<
  $R,
  $In extends MedicationRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? nameEntered,
    String? rxcui,
    String? dosage,
    String? doseForm,
    String? instructions,
  });
  MedicationRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicationRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicationRequest, $Out>
    implements MedicationRequestCopyWith<$R, MedicationRequest, $Out> {
  _MedicationRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicationRequest> $mapper =
      MedicationRequestMapper.ensureInitialized();
  @override
  $R call({
    String? nameEntered,
    Object? rxcui = $none,
    Object? dosage = $none,
    String? doseForm,
    Object? instructions = $none,
  }) => $apply(
    FieldCopyWithData({
      if (nameEntered != null) #nameEntered: nameEntered,
      if (rxcui != $none) #rxcui: rxcui,
      if (dosage != $none) #dosage: dosage,
      if (doseForm != null) #doseForm: doseForm,
      if (instructions != $none) #instructions: instructions,
    }),
  );
  @override
  MedicationRequest $make(CopyWithData data) => MedicationRequest(
    nameEntered: data.get(#nameEntered, or: $value.nameEntered),
    rxcui: data.get(#rxcui, or: $value.rxcui),
    dosage: data.get(#dosage, or: $value.dosage),
    doseForm: data.get(#doseForm, or: $value.doseForm),
    instructions: data.get(#instructions, or: $value.instructions),
  );

  @override
  MedicationRequestCopyWith<$R2, MedicationRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MedicationRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

