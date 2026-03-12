// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medication_schedule_request.dart';

class MedicationScheduleRequestMapper
    extends ClassMapperBase<MedicationScheduleRequest> {
  MedicationScheduleRequestMapper._();

  static MedicationScheduleRequestMapper? _instance;
  static MedicationScheduleRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = MedicationScheduleRequestMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'MedicationScheduleRequest';

  static List<String> _$timesOfDay(MedicationScheduleRequest v) => v.timesOfDay;
  static const Field<MedicationScheduleRequest, List<String>> _f$timesOfDay =
      Field('timesOfDay', _$timesOfDay);
  static List<String>? _$daysOfWeek(MedicationScheduleRequest v) =>
      v.daysOfWeek;
  static const Field<MedicationScheduleRequest, List<String>> _f$daysOfWeek =
      Field('daysOfWeek', _$daysOfWeek, opt: true);
  static int _$frequency(MedicationScheduleRequest v) => v.frequency;
  static const Field<MedicationScheduleRequest, int> _f$frequency = Field(
    'frequency',
    _$frequency,
  );
  static String _$frequencyUnit(MedicationScheduleRequest v) => v.frequencyUnit;
  static const Field<MedicationScheduleRequest, String> _f$frequencyUnit =
      Field('frequencyUnit', _$frequencyUnit);

  @override
  final MappableFields<MedicationScheduleRequest> fields = const {
    #timesOfDay: _f$timesOfDay,
    #daysOfWeek: _f$daysOfWeek,
    #frequency: _f$frequency,
    #frequencyUnit: _f$frequencyUnit,
  };

  static MedicationScheduleRequest _instantiate(DecodingData data) {
    return MedicationScheduleRequest(
      timesOfDay: data.dec(_f$timesOfDay),
      daysOfWeek: data.dec(_f$daysOfWeek),
      frequency: data.dec(_f$frequency),
      frequencyUnit: data.dec(_f$frequencyUnit),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicationScheduleRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicationScheduleRequest>(map);
  }

  static MedicationScheduleRequest fromJson(String json) {
    return ensureInitialized().decodeJson<MedicationScheduleRequest>(json);
  }
}

mixin MedicationScheduleRequestMappable {
  String toJson() {
    return MedicationScheduleRequestMapper.ensureInitialized()
        .encodeJson<MedicationScheduleRequest>(
          this as MedicationScheduleRequest,
        );
  }

  Map<String, dynamic> toMap() {
    return MedicationScheduleRequestMapper.ensureInitialized()
        .encodeMap<MedicationScheduleRequest>(
          this as MedicationScheduleRequest,
        );
  }

  MedicationScheduleRequestCopyWith<
    MedicationScheduleRequest,
    MedicationScheduleRequest,
    MedicationScheduleRequest
  >
  get copyWith =>
      _MedicationScheduleRequestCopyWithImpl<
        MedicationScheduleRequest,
        MedicationScheduleRequest
      >(this as MedicationScheduleRequest, $identity, $identity);
  @override
  String toString() {
    return MedicationScheduleRequestMapper.ensureInitialized().stringifyValue(
      this as MedicationScheduleRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicationScheduleRequestMapper.ensureInitialized().equalsValue(
      this as MedicationScheduleRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicationScheduleRequestMapper.ensureInitialized().hashValue(
      this as MedicationScheduleRequest,
    );
  }
}

extension MedicationScheduleRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicationScheduleRequest, $Out> {
  MedicationScheduleRequestCopyWith<$R, MedicationScheduleRequest, $Out>
  get $asMedicationScheduleRequest => $base.as(
    (v, t, t2) => _MedicationScheduleRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicationScheduleRequestCopyWith<
  $R,
  $In extends MedicationScheduleRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get timesOfDay;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get daysOfWeek;
  $R call({
    List<String>? timesOfDay,
    List<String>? daysOfWeek,
    int? frequency,
    String? frequencyUnit,
  });
  MedicationScheduleRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicationScheduleRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicationScheduleRequest, $Out>
    implements
        MedicationScheduleRequestCopyWith<$R, MedicationScheduleRequest, $Out> {
  _MedicationScheduleRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicationScheduleRequest> $mapper =
      MedicationScheduleRequestMapper.ensureInitialized();
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
    List<String>? timesOfDay,
    Object? daysOfWeek = $none,
    int? frequency,
    String? frequencyUnit,
  }) => $apply(
    FieldCopyWithData({
      if (timesOfDay != null) #timesOfDay: timesOfDay,
      if (daysOfWeek != $none) #daysOfWeek: daysOfWeek,
      if (frequency != null) #frequency: frequency,
      if (frequencyUnit != null) #frequencyUnit: frequencyUnit,
    }),
  );
  @override
  MedicationScheduleRequest $make(CopyWithData data) =>
      MedicationScheduleRequest(
        timesOfDay: data.get(#timesOfDay, or: $value.timesOfDay),
        daysOfWeek: data.get(#daysOfWeek, or: $value.daysOfWeek),
        frequency: data.get(#frequency, or: $value.frequency),
        frequencyUnit: data.get(#frequencyUnit, or: $value.frequencyUnit),
      );

  @override
  MedicationScheduleRequestCopyWith<$R2, MedicationScheduleRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MedicationScheduleRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

