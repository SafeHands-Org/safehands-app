// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'member_medication_request.dart';

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

  static String _$priority(MemberMedicationRequest v) => v.priority;
  static const Field<MemberMedicationRequest, String> _f$priority = Field(
    'priority',
    _$priority,
  );
  static DateTime _$startDate(MemberMedicationRequest v) => v.startDate;
  static const Field<MemberMedicationRequest, DateTime> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static DateTime? _$endDate(MemberMedicationRequest v) => v.endDate;
  static const Field<MemberMedicationRequest, DateTime> _f$endDate = Field(
    'endDate',
    _$endDate,
    opt: true,
  );
  static bool _$active(MemberMedicationRequest v) => v.active;
  static const Field<MemberMedicationRequest, bool> _f$active = Field(
    'active',
    _$active,
  );

  @override
  final MappableFields<MemberMedicationRequest> fields = const {
    #priority: _f$priority,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #active: _f$active,
  };

  static MemberMedicationRequest _instantiate(DecodingData data) {
    return MemberMedicationRequest(
      priority: data.dec(_f$priority),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
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
    String? priority,
    DateTime? startDate,
    DateTime? endDate,
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
    String? priority,
    DateTime? startDate,
    Object? endDate = $none,
    bool? active,
  }) => $apply(
    FieldCopyWithData({
      if (priority != null) #priority: priority,
      if (startDate != null) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
      if (active != null) #active: active,
    }),
  );
  @override
  MemberMedicationRequest $make(CopyWithData data) => MemberMedicationRequest(
    priority: data.get(#priority, or: $value.priority),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    active: data.get(#active, or: $value.active),
  );

  @override
  MemberMedicationRequestCopyWith<$R2, MemberMedicationRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MemberMedicationRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

