// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medication_schedule.dart';

class MedicationScheduleMapper extends ClassMapperBase<MedicationSchedule> {
  MedicationScheduleMapper._();

  static MedicationScheduleMapper? _instance;
  static MedicationScheduleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicationScheduleMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MedicationSchedule';

  static String _$id(MedicationSchedule v) => v.id;
  static const Field<MedicationSchedule, String> _f$id = Field('id', _$id);
  static String _$familyMemberMedicationId(MedicationSchedule v) =>
      v.familyMemberMedicationId;
  static const Field<MedicationSchedule, String> _f$familyMemberMedicationId =
      Field('familyMemberMedicationId', _$familyMemberMedicationId);
  static List<String> _$timesOfDay(MedicationSchedule v) => v.timesOfDay;
  static const Field<MedicationSchedule, List<String>> _f$timesOfDay = Field(
    'timesOfDay',
    _$timesOfDay,
  );
  static List<String>? _$daysOfWeek(MedicationSchedule v) => v.daysOfWeek;
  static const Field<MedicationSchedule, List<String>> _f$daysOfWeek = Field(
    'daysOfWeek',
    _$daysOfWeek,
    opt: true,
  );
  static int _$frequency(MedicationSchedule v) => v.frequency;
  static const Field<MedicationSchedule, int> _f$frequency = Field(
    'frequency',
    _$frequency,
  );
  static String _$frequencyUnit(MedicationSchedule v) => v.frequencyUnit;
  static const Field<MedicationSchedule, String> _f$frequencyUnit = Field(
    'frequencyUnit',
    _$frequencyUnit,
  );

  @override
  final MappableFields<MedicationSchedule> fields = const {
    #id: _f$id,
    #familyMemberMedicationId: _f$familyMemberMedicationId,
    #timesOfDay: _f$timesOfDay,
    #daysOfWeek: _f$daysOfWeek,
    #frequency: _f$frequency,
    #frequencyUnit: _f$frequencyUnit,
  };

  static MedicationSchedule _instantiate(DecodingData data) {
    return MedicationSchedule(
      id: data.dec(_f$id),
      familyMemberMedicationId: data.dec(_f$familyMemberMedicationId),
      timesOfDay: data.dec(_f$timesOfDay),
      daysOfWeek: data.dec(_f$daysOfWeek),
      frequency: data.dec(_f$frequency),
      frequencyUnit: data.dec(_f$frequencyUnit),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicationSchedule fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicationSchedule>(map);
  }

  static MedicationSchedule fromJson(String json) {
    return ensureInitialized().decodeJson<MedicationSchedule>(json);
  }
}

mixin MedicationScheduleMappable {
  String toJson() {
    return MedicationScheduleMapper.ensureInitialized()
        .encodeJson<MedicationSchedule>(this as MedicationSchedule);
  }

  Map<String, dynamic> toMap() {
    return MedicationScheduleMapper.ensureInitialized()
        .encodeMap<MedicationSchedule>(this as MedicationSchedule);
  }

  MedicationScheduleCopyWith<
    MedicationSchedule,
    MedicationSchedule,
    MedicationSchedule
  >
  get copyWith =>
      _MedicationScheduleCopyWithImpl<MedicationSchedule, MedicationSchedule>(
        this as MedicationSchedule,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MedicationScheduleMapper.ensureInitialized().stringifyValue(
      this as MedicationSchedule,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicationScheduleMapper.ensureInitialized().equalsValue(
      this as MedicationSchedule,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicationScheduleMapper.ensureInitialized().hashValue(
      this as MedicationSchedule,
    );
  }
}

extension MedicationScheduleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicationSchedule, $Out> {
  MedicationScheduleCopyWith<$R, MedicationSchedule, $Out>
  get $asMedicationSchedule => $base.as(
    (v, t, t2) => _MedicationScheduleCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicationScheduleCopyWith<
  $R,
  $In extends MedicationSchedule,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get timesOfDay;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get daysOfWeek;
  $R call({
    String? id,
    String? familyMemberMedicationId,
    List<String>? timesOfDay,
    List<String>? daysOfWeek,
    int? frequency,
    String? frequencyUnit,
  });
  MedicationScheduleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicationScheduleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicationSchedule, $Out>
    implements MedicationScheduleCopyWith<$R, MedicationSchedule, $Out> {
  _MedicationScheduleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicationSchedule> $mapper =
      MedicationScheduleMapper.ensureInitialized();
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
    String? id,
    String? familyMemberMedicationId,
    List<String>? timesOfDay,
    Object? daysOfWeek = $none,
    int? frequency,
    String? frequencyUnit,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (familyMemberMedicationId != null)
        #familyMemberMedicationId: familyMemberMedicationId,
      if (timesOfDay != null) #timesOfDay: timesOfDay,
      if (daysOfWeek != $none) #daysOfWeek: daysOfWeek,
      if (frequency != null) #frequency: frequency,
      if (frequencyUnit != null) #frequencyUnit: frequencyUnit,
    }),
  );
  @override
  MedicationSchedule $make(CopyWithData data) => MedicationSchedule(
    id: data.get(#id, or: $value.id),
    familyMemberMedicationId: data.get(
      #familyMemberMedicationId,
      or: $value.familyMemberMedicationId,
    ),
    timesOfDay: data.get(#timesOfDay, or: $value.timesOfDay),
    daysOfWeek: data.get(#daysOfWeek, or: $value.daysOfWeek),
    frequency: data.get(#frequency, or: $value.frequency),
    frequencyUnit: data.get(#frequencyUnit, or: $value.frequencyUnit),
  );

  @override
  MedicationScheduleCopyWith<$R2, MedicationSchedule, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MedicationScheduleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

