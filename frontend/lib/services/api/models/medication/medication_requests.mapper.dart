// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medication_requests.dart';

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

  static List<String> _$names(MedicationRequest v) => v.names;
  static const Field<MedicationRequest, List<String>> _f$names = Field(
    'names',
    _$names,
  );
  static String? _$rxcui(MedicationRequest v) => v.rxcui;
  static const Field<MedicationRequest, String> _f$rxcui = Field(
    'rxcui',
    _$rxcui,
    opt: true,
  );
  static String _$dosage(MedicationRequest v) => v.dosage;
  static const Field<MedicationRequest, String> _f$dosage = Field(
    'dosage',
    _$dosage,
  );
  static String _$doseForm(MedicationRequest v) => v.doseForm;
  static const Field<MedicationRequest, String> _f$doseForm = Field(
    'doseForm',
    _$doseForm,
  );
  static String _$instructions(MedicationRequest v) => v.instructions;
  static const Field<MedicationRequest, String> _f$instructions = Field(
    'instructions',
    _$instructions,
  );

  @override
  final MappableFields<MedicationRequest> fields = const {
    #names: _f$names,
    #rxcui: _f$rxcui,
    #dosage: _f$dosage,
    #doseForm: _f$doseForm,
    #instructions: _f$instructions,
  };

  static MedicationRequest _instantiate(DecodingData data) {
    return MedicationRequest(
      names: data.dec(_f$names),
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get names;
  $R call({
    List<String>? names,
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get names =>
      ListCopyWith(
        $value.names,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(names: v),
      );
  @override
  $R call({
    List<String>? names,
    Object? rxcui = $none,
    String? dosage,
    String? doseForm,
    String? instructions,
  }) => $apply(
    FieldCopyWithData({
      if (names != null) #names: names,
      if (rxcui != $none) #rxcui: rxcui,
      if (dosage != null) #dosage: dosage,
      if (doseForm != null) #doseForm: doseForm,
      if (instructions != null) #instructions: instructions,
    }),
  );
  @override
  MedicationRequest $make(CopyWithData data) => MedicationRequest(
    names: data.get(#names, or: $value.names),
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

class MedicationUpdateMapper extends ClassMapperBase<MedicationUpdate> {
  MedicationUpdateMapper._();

  static MedicationUpdateMapper? _instance;
  static MedicationUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicationUpdateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MedicationUpdate';

  static String? _$id(MedicationUpdate v) => v.id;
  static const Field<MedicationUpdate, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$dosage(MedicationUpdate v) => v.dosage;
  static const Field<MedicationUpdate, String> _f$dosage = Field(
    'dosage',
    _$dosage,
    opt: true,
  );
  static String? _$doseForm(MedicationUpdate v) => v.doseForm;
  static const Field<MedicationUpdate, String> _f$doseForm = Field(
    'doseForm',
    _$doseForm,
    opt: true,
  );
  static String? _$instructions(MedicationUpdate v) => v.instructions;
  static const Field<MedicationUpdate, String> _f$instructions = Field(
    'instructions',
    _$instructions,
    opt: true,
  );

  @override
  final MappableFields<MedicationUpdate> fields = const {
    #id: _f$id,
    #dosage: _f$dosage,
    #doseForm: _f$doseForm,
    #instructions: _f$instructions,
  };

  static MedicationUpdate _instantiate(DecodingData data) {
    return MedicationUpdate(
      id: data.dec(_f$id),
      dosage: data.dec(_f$dosage),
      doseForm: data.dec(_f$doseForm),
      instructions: data.dec(_f$instructions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicationUpdate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicationUpdate>(map);
  }

  static MedicationUpdate fromJson(String json) {
    return ensureInitialized().decodeJson<MedicationUpdate>(json);
  }
}

mixin MedicationUpdateMappable {
  String toJson() {
    return MedicationUpdateMapper.ensureInitialized()
        .encodeJson<MedicationUpdate>(this as MedicationUpdate);
  }

  Map<String, dynamic> toMap() {
    return MedicationUpdateMapper.ensureInitialized()
        .encodeMap<MedicationUpdate>(this as MedicationUpdate);
  }

  MedicationUpdateCopyWith<MedicationUpdate, MedicationUpdate, MedicationUpdate>
  get copyWith =>
      _MedicationUpdateCopyWithImpl<MedicationUpdate, MedicationUpdate>(
        this as MedicationUpdate,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MedicationUpdateMapper.ensureInitialized().stringifyValue(
      this as MedicationUpdate,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicationUpdateMapper.ensureInitialized().equalsValue(
      this as MedicationUpdate,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicationUpdateMapper.ensureInitialized().hashValue(
      this as MedicationUpdate,
    );
  }
}

extension MedicationUpdateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicationUpdate, $Out> {
  MedicationUpdateCopyWith<$R, MedicationUpdate, $Out>
  get $asMedicationUpdate =>
      $base.as((v, t, t2) => _MedicationUpdateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MedicationUpdateCopyWith<$R, $In extends MedicationUpdate, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? dosage, String? doseForm, String? instructions});
  MedicationUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicationUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicationUpdate, $Out>
    implements MedicationUpdateCopyWith<$R, MedicationUpdate, $Out> {
  _MedicationUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicationUpdate> $mapper =
      MedicationUpdateMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? dosage = $none,
    Object? doseForm = $none,
    Object? instructions = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (dosage != $none) #dosage: dosage,
      if (doseForm != $none) #doseForm: doseForm,
      if (instructions != $none) #instructions: instructions,
    }),
  );
  @override
  MedicationUpdate $make(CopyWithData data) => MedicationUpdate(
    id: data.get(#id, or: $value.id),
    dosage: data.get(#dosage, or: $value.dosage),
    doseForm: data.get(#doseForm, or: $value.doseForm),
    instructions: data.get(#instructions, or: $value.instructions),
  );

  @override
  MedicationUpdateCopyWith<$R2, MedicationUpdate, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MedicationUpdateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MemberMedicationRequestMapper
    extends ClassMapperBase<MemberMedicationRequest> {
  MemberMedicationRequestMapper._();

  static MemberMedicationRequestMapper? _instance;
  static MemberMedicationRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = MemberMedicationRequestMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'MemberMedicationRequest';

  static String _$medicationId(MemberMedicationRequest v) => v.medicationId;
  static const Field<MemberMedicationRequest, String> _f$medicationId = Field(
    'medicationId',
    _$medicationId,
  );
  static String _$familyMemberId(MemberMedicationRequest v) => v.familyMemberId;
  static const Field<MemberMedicationRequest, String> _f$familyMemberId = Field(
    'familyMemberId',
    _$familyMemberId,
  );
  static String _$priority(MemberMedicationRequest v) => v.priority;
  static const Field<MemberMedicationRequest, String> _f$priority = Field(
    'priority',
    _$priority,
  );
  static int _$quantity(MemberMedicationRequest v) => v.quantity;
  static const Field<MemberMedicationRequest, int> _f$quantity = Field(
    'quantity',
    _$quantity,
  );
  static bool _$active(MemberMedicationRequest v) => v.active;
  static const Field<MemberMedicationRequest, bool> _f$active = Field(
    'active',
    _$active,
  );

  @override
  final MappableFields<MemberMedicationRequest> fields = const {
    #medicationId: _f$medicationId,
    #familyMemberId: _f$familyMemberId,
    #priority: _f$priority,
    #quantity: _f$quantity,
    #active: _f$active,
  };

  static MemberMedicationRequest _instantiate(DecodingData data) {
    return MemberMedicationRequest(
      medicationId: data.dec(_f$medicationId),
      familyMemberId: data.dec(_f$familyMemberId),
      priority: data.dec(_f$priority),
      quantity: data.dec(_f$quantity),
      active: data.dec(_f$active),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MemberMedicationRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MemberMedicationRequest>(map);
  }

  static MemberMedicationRequest fromJson(String json) {
    return ensureInitialized().decodeJson<MemberMedicationRequest>(json);
  }
}

mixin MemberMedicationRequestMappable {
  String toJson() {
    return MemberMedicationRequestMapper.ensureInitialized()
        .encodeJson<MemberMedicationRequest>(this as MemberMedicationRequest);
  }

  Map<String, dynamic> toMap() {
    return MemberMedicationRequestMapper.ensureInitialized()
        .encodeMap<MemberMedicationRequest>(this as MemberMedicationRequest);
  }

  MemberMedicationRequestCopyWith<
    MemberMedicationRequest,
    MemberMedicationRequest,
    MemberMedicationRequest
  >
  get copyWith =>
      _MemberMedicationRequestCopyWithImpl<
        MemberMedicationRequest,
        MemberMedicationRequest
      >(this as MemberMedicationRequest, $identity, $identity);
  @override
  String toString() {
    return MemberMedicationRequestMapper.ensureInitialized().stringifyValue(
      this as MemberMedicationRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return MemberMedicationRequestMapper.ensureInitialized().equalsValue(
      this as MemberMedicationRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return MemberMedicationRequestMapper.ensureInitialized().hashValue(
      this as MemberMedicationRequest,
    );
  }
}

extension MemberMedicationRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MemberMedicationRequest, $Out> {
  MemberMedicationRequestCopyWith<$R, MemberMedicationRequest, $Out>
  get $asMemberMedicationRequest => $base.as(
    (v, t, t2) => _MemberMedicationRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MemberMedicationRequestCopyWith<
  $R,
  $In extends MemberMedicationRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? medicationId,
    String? familyMemberId,
    String? priority,
    int? quantity,
    bool? active,
  });
  MemberMedicationRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MemberMedicationRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MemberMedicationRequest, $Out>
    implements
        MemberMedicationRequestCopyWith<$R, MemberMedicationRequest, $Out> {
  _MemberMedicationRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MemberMedicationRequest> $mapper =
      MemberMedicationRequestMapper.ensureInitialized();
  @override
  $R call({
    String? medicationId,
    String? familyMemberId,
    String? priority,
    int? quantity,
    bool? active,
  }) => $apply(
    FieldCopyWithData({
      if (medicationId != null) #medicationId: medicationId,
      if (familyMemberId != null) #familyMemberId: familyMemberId,
      if (priority != null) #priority: priority,
      if (quantity != null) #quantity: quantity,
      if (active != null) #active: active,
    }),
  );
  @override
  MemberMedicationRequest $make(CopyWithData data) => MemberMedicationRequest(
    medicationId: data.get(#medicationId, or: $value.medicationId),
    familyMemberId: data.get(#familyMemberId, or: $value.familyMemberId),
    priority: data.get(#priority, or: $value.priority),
    quantity: data.get(#quantity, or: $value.quantity),
    active: data.get(#active, or: $value.active),
  );

  @override
  MemberMedicationRequestCopyWith<$R2, MemberMedicationRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MemberMedicationRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MemberMedicationUpdateMapper
    extends ClassMapperBase<MemberMedicationUpdate> {
  MemberMedicationUpdateMapper._();

  static MemberMedicationUpdateMapper? _instance;
  static MemberMedicationUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MemberMedicationUpdateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MemberMedicationUpdate';

  static String? _$id(MemberMedicationUpdate v) => v.id;
  static const Field<MemberMedicationUpdate, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$priority(MemberMedicationUpdate v) => v.priority;
  static const Field<MemberMedicationUpdate, String> _f$priority = Field(
    'priority',
    _$priority,
    opt: true,
  );
  static int? _$quantity(MemberMedicationUpdate v) => v.quantity;
  static const Field<MemberMedicationUpdate, int> _f$quantity = Field(
    'quantity',
    _$quantity,
    opt: true,
  );
  static bool? _$active(MemberMedicationUpdate v) => v.active;
  static const Field<MemberMedicationUpdate, bool> _f$active = Field(
    'active',
    _$active,
    opt: true,
  );

  @override
  final MappableFields<MemberMedicationUpdate> fields = const {
    #id: _f$id,
    #priority: _f$priority,
    #quantity: _f$quantity,
    #active: _f$active,
  };

  static MemberMedicationUpdate _instantiate(DecodingData data) {
    return MemberMedicationUpdate(
      id: data.dec(_f$id),
      priority: data.dec(_f$priority),
      quantity: data.dec(_f$quantity),
      active: data.dec(_f$active),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MemberMedicationUpdate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MemberMedicationUpdate>(map);
  }

  static MemberMedicationUpdate fromJson(String json) {
    return ensureInitialized().decodeJson<MemberMedicationUpdate>(json);
  }
}

mixin MemberMedicationUpdateMappable {
  String toJson() {
    return MemberMedicationUpdateMapper.ensureInitialized()
        .encodeJson<MemberMedicationUpdate>(this as MemberMedicationUpdate);
  }

  Map<String, dynamic> toMap() {
    return MemberMedicationUpdateMapper.ensureInitialized()
        .encodeMap<MemberMedicationUpdate>(this as MemberMedicationUpdate);
  }

  MemberMedicationUpdateCopyWith<
    MemberMedicationUpdate,
    MemberMedicationUpdate,
    MemberMedicationUpdate
  >
  get copyWith =>
      _MemberMedicationUpdateCopyWithImpl<
        MemberMedicationUpdate,
        MemberMedicationUpdate
      >(this as MemberMedicationUpdate, $identity, $identity);
  @override
  String toString() {
    return MemberMedicationUpdateMapper.ensureInitialized().stringifyValue(
      this as MemberMedicationUpdate,
    );
  }

  @override
  bool operator ==(Object other) {
    return MemberMedicationUpdateMapper.ensureInitialized().equalsValue(
      this as MemberMedicationUpdate,
      other,
    );
  }

  @override
  int get hashCode {
    return MemberMedicationUpdateMapper.ensureInitialized().hashValue(
      this as MemberMedicationUpdate,
    );
  }
}

extension MemberMedicationUpdateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MemberMedicationUpdate, $Out> {
  MemberMedicationUpdateCopyWith<$R, MemberMedicationUpdate, $Out>
  get $asMemberMedicationUpdate => $base.as(
    (v, t, t2) => _MemberMedicationUpdateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MemberMedicationUpdateCopyWith<
  $R,
  $In extends MemberMedicationUpdate,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? priority, int? quantity, bool? active});
  MemberMedicationUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MemberMedicationUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MemberMedicationUpdate, $Out>
    implements
        MemberMedicationUpdateCopyWith<$R, MemberMedicationUpdate, $Out> {
  _MemberMedicationUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MemberMedicationUpdate> $mapper =
      MemberMedicationUpdateMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? priority = $none,
    Object? quantity = $none,
    Object? active = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (priority != $none) #priority: priority,
      if (quantity != $none) #quantity: quantity,
      if (active != $none) #active: active,
    }),
  );
  @override
  MemberMedicationUpdate $make(CopyWithData data) => MemberMedicationUpdate(
    id: data.get(#id, or: $value.id),
    priority: data.get(#priority, or: $value.priority),
    quantity: data.get(#quantity, or: $value.quantity),
    active: data.get(#active, or: $value.active),
  );

  @override
  MemberMedicationUpdateCopyWith<$R2, MemberMedicationUpdate, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MemberMedicationUpdateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScheduleRequestMapper extends ClassMapperBase<ScheduleRequest> {
  ScheduleRequestMapper._();

  static ScheduleRequestMapper? _instance;
  static ScheduleRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScheduleRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ScheduleRequest';

  static String _$familyMemberMedicationId(ScheduleRequest v) =>
      v.familyMemberMedicationId;
  static const Field<ScheduleRequest, String> _f$familyMemberMedicationId =
      Field('familyMemberMedicationId', _$familyMemberMedicationId);
  static List<String> _$timesOfDay(ScheduleRequest v) => v.timesOfDay;
  static const Field<ScheduleRequest, List<String>> _f$timesOfDay = Field(
    'timesOfDay',
    _$timesOfDay,
  );
  static List<String>? _$daysOfWeek(ScheduleRequest v) => v.daysOfWeek;
  static const Field<ScheduleRequest, List<String>> _f$daysOfWeek = Field(
    'daysOfWeek',
    _$daysOfWeek,
    opt: true,
  );
  static int _$frequency(ScheduleRequest v) => v.frequency;
  static const Field<ScheduleRequest, int> _f$frequency = Field(
    'frequency',
    _$frequency,
  );

  @override
  final MappableFields<ScheduleRequest> fields = const {
    #familyMemberMedicationId: _f$familyMemberMedicationId,
    #timesOfDay: _f$timesOfDay,
    #daysOfWeek: _f$daysOfWeek,
    #frequency: _f$frequency,
  };

  static ScheduleRequest _instantiate(DecodingData data) {
    return ScheduleRequest(
      familyMemberMedicationId: data.dec(_f$familyMemberMedicationId),
      timesOfDay: data.dec(_f$timesOfDay),
      daysOfWeek: data.dec(_f$daysOfWeek),
      frequency: data.dec(_f$frequency),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ScheduleRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScheduleRequest>(map);
  }

  static ScheduleRequest fromJson(String json) {
    return ensureInitialized().decodeJson<ScheduleRequest>(json);
  }
}

mixin ScheduleRequestMappable {
  String toJson() {
    return ScheduleRequestMapper.ensureInitialized()
        .encodeJson<ScheduleRequest>(this as ScheduleRequest);
  }

  Map<String, dynamic> toMap() {
    return ScheduleRequestMapper.ensureInitialized().encodeMap<ScheduleRequest>(
      this as ScheduleRequest,
    );
  }

  ScheduleRequestCopyWith<ScheduleRequest, ScheduleRequest, ScheduleRequest>
  get copyWith =>
      _ScheduleRequestCopyWithImpl<ScheduleRequest, ScheduleRequest>(
        this as ScheduleRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ScheduleRequestMapper.ensureInitialized().stringifyValue(
      this as ScheduleRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScheduleRequestMapper.ensureInitialized().equalsValue(
      this as ScheduleRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return ScheduleRequestMapper.ensureInitialized().hashValue(
      this as ScheduleRequest,
    );
  }
}

extension ScheduleRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScheduleRequest, $Out> {
  ScheduleRequestCopyWith<$R, ScheduleRequest, $Out> get $asScheduleRequest =>
      $base.as((v, t, t2) => _ScheduleRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ScheduleRequestCopyWith<$R, $In extends ScheduleRequest, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get timesOfDay;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get daysOfWeek;
  $R call({
    String? familyMemberMedicationId,
    List<String>? timesOfDay,
    List<String>? daysOfWeek,
    int? frequency,
  });
  ScheduleRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ScheduleRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScheduleRequest, $Out>
    implements ScheduleRequestCopyWith<$R, ScheduleRequest, $Out> {
  _ScheduleRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScheduleRequest> $mapper =
      ScheduleRequestMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get timesOfDay =>
      ListCopyWith(
        $value.timesOfDay,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(timesOfDay: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get daysOfWeek => $value.daysOfWeek != null
      ? ListCopyWith(
          $value.daysOfWeek!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(daysOfWeek: v),
        )
      : null;
  @override
  $R call({
    String? familyMemberMedicationId,
    List<String>? timesOfDay,
    Object? daysOfWeek = $none,
    int? frequency,
  }) => $apply(
    FieldCopyWithData({
      if (familyMemberMedicationId != null)
        #familyMemberMedicationId: familyMemberMedicationId,
      if (timesOfDay != null) #timesOfDay: timesOfDay,
      if (daysOfWeek != $none) #daysOfWeek: daysOfWeek,
      if (frequency != null) #frequency: frequency,
    }),
  );
  @override
  ScheduleRequest $make(CopyWithData data) => ScheduleRequest(
    familyMemberMedicationId: data.get(
      #familyMemberMedicationId,
      or: $value.familyMemberMedicationId,
    ),
    timesOfDay: data.get(#timesOfDay, or: $value.timesOfDay),
    daysOfWeek: data.get(#daysOfWeek, or: $value.daysOfWeek),
    frequency: data.get(#frequency, or: $value.frequency),
  );

  @override
  ScheduleRequestCopyWith<$R2, ScheduleRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ScheduleRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ScheduleUpdateMapper extends ClassMapperBase<ScheduleUpdate> {
  ScheduleUpdateMapper._();

  static ScheduleUpdateMapper? _instance;
  static ScheduleUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScheduleUpdateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ScheduleUpdate';

  static String? _$id(ScheduleUpdate v) => v.id;
  static const Field<ScheduleUpdate, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static List<String>? _$timesOfDay(ScheduleUpdate v) => v.timesOfDay;
  static const Field<ScheduleUpdate, List<String>> _f$timesOfDay = Field(
    'timesOfDay',
    _$timesOfDay,
    opt: true,
  );
  static List<String>? _$daysOfWeek(ScheduleUpdate v) => v.daysOfWeek;
  static const Field<ScheduleUpdate, List<String>> _f$daysOfWeek = Field(
    'daysOfWeek',
    _$daysOfWeek,
    opt: true,
  );
  static int? _$frequency(ScheduleUpdate v) => v.frequency;
  static const Field<ScheduleUpdate, int> _f$frequency = Field(
    'frequency',
    _$frequency,
    opt: true,
  );

  @override
  final MappableFields<ScheduleUpdate> fields = const {
    #id: _f$id,
    #timesOfDay: _f$timesOfDay,
    #daysOfWeek: _f$daysOfWeek,
    #frequency: _f$frequency,
  };

  static ScheduleUpdate _instantiate(DecodingData data) {
    return ScheduleUpdate(
      id: data.dec(_f$id),
      timesOfDay: data.dec(_f$timesOfDay),
      daysOfWeek: data.dec(_f$daysOfWeek),
      frequency: data.dec(_f$frequency),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ScheduleUpdate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScheduleUpdate>(map);
  }

  static ScheduleUpdate fromJson(String json) {
    return ensureInitialized().decodeJson<ScheduleUpdate>(json);
  }
}

mixin ScheduleUpdateMappable {
  String toJson() {
    return ScheduleUpdateMapper.ensureInitialized().encodeJson<ScheduleUpdate>(
      this as ScheduleUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return ScheduleUpdateMapper.ensureInitialized().encodeMap<ScheduleUpdate>(
      this as ScheduleUpdate,
    );
  }

  ScheduleUpdateCopyWith<ScheduleUpdate, ScheduleUpdate, ScheduleUpdate>
  get copyWith => _ScheduleUpdateCopyWithImpl<ScheduleUpdate, ScheduleUpdate>(
    this as ScheduleUpdate,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ScheduleUpdateMapper.ensureInitialized().stringifyValue(
      this as ScheduleUpdate,
    );
  }

  @override
  bool operator ==(Object other) {
    return ScheduleUpdateMapper.ensureInitialized().equalsValue(
      this as ScheduleUpdate,
      other,
    );
  }

  @override
  int get hashCode {
    return ScheduleUpdateMapper.ensureInitialized().hashValue(
      this as ScheduleUpdate,
    );
  }
}

extension ScheduleUpdateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScheduleUpdate, $Out> {
  ScheduleUpdateCopyWith<$R, ScheduleUpdate, $Out> get $asScheduleUpdate =>
      $base.as((v, t, t2) => _ScheduleUpdateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ScheduleUpdateCopyWith<$R, $In extends ScheduleUpdate, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get timesOfDay;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get daysOfWeek;
  $R call({
    String? id,
    List<String>? timesOfDay,
    List<String>? daysOfWeek,
    int? frequency,
  });
  ScheduleUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ScheduleUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScheduleUpdate, $Out>
    implements ScheduleUpdateCopyWith<$R, ScheduleUpdate, $Out> {
  _ScheduleUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScheduleUpdate> $mapper =
      ScheduleUpdateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get timesOfDay => $value.timesOfDay != null
      ? ListCopyWith(
          $value.timesOfDay!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(timesOfDay: v),
        )
      : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get daysOfWeek => $value.daysOfWeek != null
      ? ListCopyWith(
          $value.daysOfWeek!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(daysOfWeek: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? timesOfDay = $none,
    Object? daysOfWeek = $none,
    Object? frequency = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (timesOfDay != $none) #timesOfDay: timesOfDay,
      if (daysOfWeek != $none) #daysOfWeek: daysOfWeek,
      if (frequency != $none) #frequency: frequency,
    }),
  );
  @override
  ScheduleUpdate $make(CopyWithData data) => ScheduleUpdate(
    id: data.get(#id, or: $value.id),
    timesOfDay: data.get(#timesOfDay, or: $value.timesOfDay),
    daysOfWeek: data.get(#daysOfWeek, or: $value.daysOfWeek),
    frequency: data.get(#frequency, or: $value.frequency),
  );

  @override
  ScheduleUpdateCopyWith<$R2, ScheduleUpdate, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ScheduleUpdateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AdherenceLogRequestMapper extends ClassMapperBase<AdherenceLogRequest> {
  AdherenceLogRequestMapper._();

  static AdherenceLogRequestMapper? _instance;
  static AdherenceLogRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdherenceLogRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AdherenceLogRequest';

  static String _$familyMemberMedicationId(AdherenceLogRequest v) =>
      v.familyMemberMedicationId;
  static const Field<AdherenceLogRequest, String> _f$familyMemberMedicationId =
      Field('familyMemberMedicationId', _$familyMemberMedicationId);
  static String _$scheduledTime(AdherenceLogRequest v) => v.scheduledTime;
  static const Field<AdherenceLogRequest, String> _f$scheduledTime = Field(
    'scheduledTime',
    _$scheduledTime,
  );
  static DateTime? _$takenAt(AdherenceLogRequest v) => v.takenAt;
  static const Field<AdherenceLogRequest, DateTime> _f$takenAt = Field(
    'takenAt',
    _$takenAt,
    opt: true,
  );
  static String _$status(AdherenceLogRequest v) => v.status;
  static const Field<AdherenceLogRequest, String> _f$status = Field(
    'status',
    _$status,
  );
  static String _$recordedBy(AdherenceLogRequest v) => v.recordedBy;
  static const Field<AdherenceLogRequest, String> _f$recordedBy = Field(
    'recordedBy',
    _$recordedBy,
  );

  @override
  final MappableFields<AdherenceLogRequest> fields = const {
    #familyMemberMedicationId: _f$familyMemberMedicationId,
    #scheduledTime: _f$scheduledTime,
    #takenAt: _f$takenAt,
    #status: _f$status,
    #recordedBy: _f$recordedBy,
  };

  static AdherenceLogRequest _instantiate(DecodingData data) {
    return AdherenceLogRequest(
      familyMemberMedicationId: data.dec(_f$familyMemberMedicationId),
      scheduledTime: data.dec(_f$scheduledTime),
      takenAt: data.dec(_f$takenAt),
      status: data.dec(_f$status),
      recordedBy: data.dec(_f$recordedBy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AdherenceLogRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdherenceLogRequest>(map);
  }

  static AdherenceLogRequest fromJson(String json) {
    return ensureInitialized().decodeJson<AdherenceLogRequest>(json);
  }
}

mixin AdherenceLogRequestMappable {
  String toJson() {
    return AdherenceLogRequestMapper.ensureInitialized()
        .encodeJson<AdherenceLogRequest>(this as AdherenceLogRequest);
  }

  Map<String, dynamic> toMap() {
    return AdherenceLogRequestMapper.ensureInitialized()
        .encodeMap<AdherenceLogRequest>(this as AdherenceLogRequest);
  }

  AdherenceLogRequestCopyWith<
    AdherenceLogRequest,
    AdherenceLogRequest,
    AdherenceLogRequest
  >
  get copyWith =>
      _AdherenceLogRequestCopyWithImpl<
        AdherenceLogRequest,
        AdherenceLogRequest
      >(this as AdherenceLogRequest, $identity, $identity);
  @override
  String toString() {
    return AdherenceLogRequestMapper.ensureInitialized().stringifyValue(
      this as AdherenceLogRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return AdherenceLogRequestMapper.ensureInitialized().equalsValue(
      this as AdherenceLogRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return AdherenceLogRequestMapper.ensureInitialized().hashValue(
      this as AdherenceLogRequest,
    );
  }
}

extension AdherenceLogRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdherenceLogRequest, $Out> {
  AdherenceLogRequestCopyWith<$R, AdherenceLogRequest, $Out>
  get $asAdherenceLogRequest => $base.as(
    (v, t, t2) => _AdherenceLogRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AdherenceLogRequestCopyWith<
  $R,
  $In extends AdherenceLogRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? familyMemberMedicationId,
    String? scheduledTime,
    DateTime? takenAt,
    String? status,
    String? recordedBy,
  });
  AdherenceLogRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AdherenceLogRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdherenceLogRequest, $Out>
    implements AdherenceLogRequestCopyWith<$R, AdherenceLogRequest, $Out> {
  _AdherenceLogRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdherenceLogRequest> $mapper =
      AdherenceLogRequestMapper.ensureInitialized();
  @override
  $R call({
    String? familyMemberMedicationId,
    String? scheduledTime,
    Object? takenAt = $none,
    String? status,
    String? recordedBy,
  }) => $apply(
    FieldCopyWithData({
      if (familyMemberMedicationId != null)
        #familyMemberMedicationId: familyMemberMedicationId,
      if (scheduledTime != null) #scheduledTime: scheduledTime,
      if (takenAt != $none) #takenAt: takenAt,
      if (status != null) #status: status,
      if (recordedBy != null) #recordedBy: recordedBy,
    }),
  );
  @override
  AdherenceLogRequest $make(CopyWithData data) => AdherenceLogRequest(
    familyMemberMedicationId: data.get(
      #familyMemberMedicationId,
      or: $value.familyMemberMedicationId,
    ),
    scheduledTime: data.get(#scheduledTime, or: $value.scheduledTime),
    takenAt: data.get(#takenAt, or: $value.takenAt),
    status: data.get(#status, or: $value.status),
    recordedBy: data.get(#recordedBy, or: $value.recordedBy),
  );

  @override
  AdherenceLogRequestCopyWith<$R2, AdherenceLogRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AdherenceLogRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AdherenceLogUpdateMapper extends ClassMapperBase<AdherenceLogUpdate> {
  AdherenceLogUpdateMapper._();

  static AdherenceLogUpdateMapper? _instance;
  static AdherenceLogUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdherenceLogUpdateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AdherenceLogUpdate';

  static String? _$id(AdherenceLogUpdate v) => v.id;
  static const Field<AdherenceLogUpdate, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static DateTime? _$takenAt(AdherenceLogUpdate v) => v.takenAt;
  static const Field<AdherenceLogUpdate, DateTime> _f$takenAt = Field(
    'takenAt',
    _$takenAt,
    opt: true,
  );
  static String? _$status(AdherenceLogUpdate v) => v.status;
  static const Field<AdherenceLogUpdate, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$recordedBy(AdherenceLogUpdate v) => v.recordedBy;
  static const Field<AdherenceLogUpdate, String> _f$recordedBy = Field(
    'recordedBy',
    _$recordedBy,
    opt: true,
  );

  @override
  final MappableFields<AdherenceLogUpdate> fields = const {
    #id: _f$id,
    #takenAt: _f$takenAt,
    #status: _f$status,
    #recordedBy: _f$recordedBy,
  };

  static AdherenceLogUpdate _instantiate(DecodingData data) {
    return AdherenceLogUpdate(
      id: data.dec(_f$id),
      takenAt: data.dec(_f$takenAt),
      status: data.dec(_f$status),
      recordedBy: data.dec(_f$recordedBy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AdherenceLogUpdate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdherenceLogUpdate>(map);
  }

  static AdherenceLogUpdate fromJson(String json) {
    return ensureInitialized().decodeJson<AdherenceLogUpdate>(json);
  }
}

mixin AdherenceLogUpdateMappable {
  String toJson() {
    return AdherenceLogUpdateMapper.ensureInitialized()
        .encodeJson<AdherenceLogUpdate>(this as AdherenceLogUpdate);
  }

  Map<String, dynamic> toMap() {
    return AdherenceLogUpdateMapper.ensureInitialized()
        .encodeMap<AdherenceLogUpdate>(this as AdherenceLogUpdate);
  }

  AdherenceLogUpdateCopyWith<
    AdherenceLogUpdate,
    AdherenceLogUpdate,
    AdherenceLogUpdate
  >
  get copyWith =>
      _AdherenceLogUpdateCopyWithImpl<AdherenceLogUpdate, AdherenceLogUpdate>(
        this as AdherenceLogUpdate,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AdherenceLogUpdateMapper.ensureInitialized().stringifyValue(
      this as AdherenceLogUpdate,
    );
  }

  @override
  bool operator ==(Object other) {
    return AdherenceLogUpdateMapper.ensureInitialized().equalsValue(
      this as AdherenceLogUpdate,
      other,
    );
  }

  @override
  int get hashCode {
    return AdherenceLogUpdateMapper.ensureInitialized().hashValue(
      this as AdherenceLogUpdate,
    );
  }
}

extension AdherenceLogUpdateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdherenceLogUpdate, $Out> {
  AdherenceLogUpdateCopyWith<$R, AdherenceLogUpdate, $Out>
  get $asAdherenceLogUpdate => $base.as(
    (v, t, t2) => _AdherenceLogUpdateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AdherenceLogUpdateCopyWith<
  $R,
  $In extends AdherenceLogUpdate,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, DateTime? takenAt, String? status, String? recordedBy});
  AdherenceLogUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AdherenceLogUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdherenceLogUpdate, $Out>
    implements AdherenceLogUpdateCopyWith<$R, AdherenceLogUpdate, $Out> {
  _AdherenceLogUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdherenceLogUpdate> $mapper =
      AdherenceLogUpdateMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? takenAt = $none,
    Object? status = $none,
    Object? recordedBy = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (takenAt != $none) #takenAt: takenAt,
      if (status != $none) #status: status,
      if (recordedBy != $none) #recordedBy: recordedBy,
    }),
  );
  @override
  AdherenceLogUpdate $make(CopyWithData data) => AdherenceLogUpdate(
    id: data.get(#id, or: $value.id),
    takenAt: data.get(#takenAt, or: $value.takenAt),
    status: data.get(#status, or: $value.status),
    recordedBy: data.get(#recordedBy, or: $value.recordedBy),
  );

  @override
  AdherenceLogUpdateCopyWith<$R2, AdherenceLogUpdate, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AdherenceLogUpdateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

