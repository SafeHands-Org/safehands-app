// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'adherence_log.dart';

class MedicationAdherenceLogMapper
    extends ClassMapperBase<MedicationAdherenceLog> {
  MedicationAdherenceLogMapper._();

  static MedicationAdherenceLogMapper? _instance;
  static MedicationAdherenceLogMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicationAdherenceLogMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MedicationAdherenceLog';

  static String _$id(MedicationAdherenceLog v) => v.id;
  static const Field<MedicationAdherenceLog, String> _f$id = Field('id', _$id);
  static String _$fmid(MedicationAdherenceLog v) => v.fmid;
  static const Field<MedicationAdherenceLog, String> _f$fmid = Field(
    'fmid',
    _$fmid,
  );
  static String _$fmmid(MedicationAdherenceLog v) => v.fmmid;
  static const Field<MedicationAdherenceLog, String> _f$fmmid = Field(
    'fmmid',
    _$fmmid,
  );
  static String _$scheduledTime(MedicationAdherenceLog v) => v.scheduledTime;
  static const Field<MedicationAdherenceLog, String> _f$scheduledTime = Field(
    'scheduledTime',
    _$scheduledTime,
  );
  static DateTime? _$takenAt(MedicationAdherenceLog v) => v.takenAt;
  static const Field<MedicationAdherenceLog, DateTime> _f$takenAt = Field(
    'takenAt',
    _$takenAt,
    opt: true,
  );
  static String _$status(MedicationAdherenceLog v) => v.status;
  static const Field<MedicationAdherenceLog, String> _f$status = Field(
    'status',
    _$status,
  );
  static String _$recordedBy(MedicationAdherenceLog v) => v.recordedBy;
  static const Field<MedicationAdherenceLog, String> _f$recordedBy = Field(
    'recordedBy',
    _$recordedBy,
  );

  @override
  final MappableFields<MedicationAdherenceLog> fields = const {
    #id: _f$id,
    #fmid: _f$fmid,
    #fmmid: _f$fmmid,
    #scheduledTime: _f$scheduledTime,
    #takenAt: _f$takenAt,
    #status: _f$status,
    #recordedBy: _f$recordedBy,
  };

  static MedicationAdherenceLog _instantiate(DecodingData data) {
    return MedicationAdherenceLog(
      id: data.dec(_f$id),
      fmid: data.dec(_f$fmid),
      fmmid: data.dec(_f$fmmid),
      scheduledTime: data.dec(_f$scheduledTime),
      takenAt: data.dec(_f$takenAt),
      status: data.dec(_f$status),
      recordedBy: data.dec(_f$recordedBy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicationAdherenceLog fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicationAdherenceLog>(map);
  }

  static MedicationAdherenceLog fromJson(String json) {
    return ensureInitialized().decodeJson<MedicationAdherenceLog>(json);
  }
}

mixin MedicationAdherenceLogMappable {
  String toJson() {
    return MedicationAdherenceLogMapper.ensureInitialized()
        .encodeJson<MedicationAdherenceLog>(this as MedicationAdherenceLog);
  }

  Map<String, dynamic> toMap() {
    return MedicationAdherenceLogMapper.ensureInitialized()
        .encodeMap<MedicationAdherenceLog>(this as MedicationAdherenceLog);
  }

  MedicationAdherenceLogCopyWith<
    MedicationAdherenceLog,
    MedicationAdherenceLog,
    MedicationAdherenceLog
  >
  get copyWith =>
      _MedicationAdherenceLogCopyWithImpl<
        MedicationAdherenceLog,
        MedicationAdherenceLog
      >(this as MedicationAdherenceLog, $identity, $identity);
  @override
  String toString() {
    return MedicationAdherenceLogMapper.ensureInitialized().stringifyValue(
      this as MedicationAdherenceLog,
    );
  }

  @override
  bool operator ==(Object other) {
    return MedicationAdherenceLogMapper.ensureInitialized().equalsValue(
      this as MedicationAdherenceLog,
      other,
    );
  }

  @override
  int get hashCode {
    return MedicationAdherenceLogMapper.ensureInitialized().hashValue(
      this as MedicationAdherenceLog,
    );
  }
}

extension MedicationAdherenceLogValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicationAdherenceLog, $Out> {
  MedicationAdherenceLogCopyWith<$R, MedicationAdherenceLog, $Out>
  get $asMedicationAdherenceLog => $base.as(
    (v, t, t2) => _MedicationAdherenceLogCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MedicationAdherenceLogCopyWith<
  $R,
  $In extends MedicationAdherenceLog,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? fmid,
    String? fmmid,
    String? scheduledTime,
    DateTime? takenAt,
    String? status,
    String? recordedBy,
  });
  MedicationAdherenceLogCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MedicationAdherenceLogCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicationAdherenceLog, $Out>
    implements
        MedicationAdherenceLogCopyWith<$R, MedicationAdherenceLog, $Out> {
  _MedicationAdherenceLogCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicationAdherenceLog> $mapper =
      MedicationAdherenceLogMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? fmid,
    String? fmmid,
    String? scheduledTime,
    Object? takenAt = $none,
    String? status,
    String? recordedBy,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (fmid != null) #fmid: fmid,
      if (fmmid != null) #fmmid: fmmid,
      if (scheduledTime != null) #scheduledTime: scheduledTime,
      if (takenAt != $none) #takenAt: takenAt,
      if (status != null) #status: status,
      if (recordedBy != null) #recordedBy: recordedBy,
    }),
  );
  @override
  MedicationAdherenceLog $make(CopyWithData data) => MedicationAdherenceLog(
    id: data.get(#id, or: $value.id),
    fmid: data.get(#fmid, or: $value.fmid),
    fmmid: data.get(#fmmid, or: $value.fmmid),
    scheduledTime: data.get(#scheduledTime, or: $value.scheduledTime),
    takenAt: data.get(#takenAt, or: $value.takenAt),
    status: data.get(#status, or: $value.status),
    recordedBy: data.get(#recordedBy, or: $value.recordedBy),
  );

  @override
  MedicationAdherenceLogCopyWith<$R2, MedicationAdherenceLog, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MedicationAdherenceLogCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

