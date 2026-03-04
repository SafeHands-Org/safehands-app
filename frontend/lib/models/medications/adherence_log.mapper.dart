// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'adherence_log.dart';

class AdherenceLogMapper extends ClassMapperBase<AdherenceLog> {
  AdherenceLogMapper._();

  static AdherenceLogMapper? _instance;
  static AdherenceLogMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdherenceLogMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AdherenceLog';

  static String _$id(AdherenceLog v) => v.id;
  static const Field<AdherenceLog, String> _f$id = Field('id', _$id);
  static String _$familyMemberMedicationId(AdherenceLog v) =>
      v.familyMemberMedicationId;
  static const Field<AdherenceLog, String> _f$familyMemberMedicationId = Field(
    'familyMemberMedicationId',
    _$familyMemberMedicationId,
  );
  static DateTime _$scheduledTime(AdherenceLog v) => v.scheduledTime;
  static const Field<AdherenceLog, DateTime> _f$scheduledTime = Field(
    'scheduledTime',
    _$scheduledTime,
  );
  static AdherenceStatus _$status(AdherenceLog v) => v.status;
  static const Field<AdherenceLog, AdherenceStatus> _f$status = Field(
    'status',
    _$status,
  );
  static DateTime? _$takenAt(AdherenceLog v) => v.takenAt;
  static const Field<AdherenceLog, DateTime> _f$takenAt = Field(
    'takenAt',
    _$takenAt,
    opt: true,
  );
  static String? _$notes(AdherenceLog v) => v.notes;
  static const Field<AdherenceLog, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );

  @override
  final MappableFields<AdherenceLog> fields = const {
    #id: _f$id,
    #familyMemberMedicationId: _f$familyMemberMedicationId,
    #scheduledTime: _f$scheduledTime,
    #status: _f$status,
    #takenAt: _f$takenAt,
    #notes: _f$notes,
  };

  static AdherenceLog _instantiate(DecodingData data) {
    return AdherenceLog(
      id: data.dec(_f$id),
      familyMemberMedicationId: data.dec(_f$familyMemberMedicationId),
      scheduledTime: data.dec(_f$scheduledTime),
      status: data.dec(_f$status),
      takenAt: data.dec(_f$takenAt),
      notes: data.dec(_f$notes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AdherenceLog fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdherenceLog>(map);
  }

  static AdherenceLog fromJson(String json) {
    return ensureInitialized().decodeJson<AdherenceLog>(json);
  }
}

mixin AdherenceLogMappable {
  String toJson() {
    return AdherenceLogMapper.ensureInitialized().encodeJson<AdherenceLog>(
      this as AdherenceLog,
    );
  }

  Map<String, dynamic> toMap() {
    return AdherenceLogMapper.ensureInitialized().encodeMap<AdherenceLog>(
      this as AdherenceLog,
    );
  }

  AdherenceLogCopyWith<AdherenceLog, AdherenceLog, AdherenceLog> get copyWith =>
      _AdherenceLogCopyWithImpl<AdherenceLog, AdherenceLog>(
        this as AdherenceLog,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AdherenceLogMapper.ensureInitialized().stringifyValue(
      this as AdherenceLog,
    );
  }

  @override
  bool operator ==(Object other) {
    return AdherenceLogMapper.ensureInitialized().equalsValue(
      this as AdherenceLog,
      other,
    );
  }

  @override
  int get hashCode {
    return AdherenceLogMapper.ensureInitialized().hashValue(
      this as AdherenceLog,
    );
  }
}

extension AdherenceLogValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdherenceLog, $Out> {
  AdherenceLogCopyWith<$R, AdherenceLog, $Out> get $asAdherenceLog =>
      $base.as((v, t, t2) => _AdherenceLogCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdherenceLogCopyWith<$R, $In extends AdherenceLog, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? familyMemberMedicationId,
    DateTime? scheduledTime,
    AdherenceStatus? status,
    DateTime? takenAt,
    String? notes,
  });
  AdherenceLogCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdherenceLogCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdherenceLog, $Out>
    implements AdherenceLogCopyWith<$R, AdherenceLog, $Out> {
  _AdherenceLogCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdherenceLog> $mapper =
      AdherenceLogMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? familyMemberMedicationId,
    DateTime? scheduledTime,
    AdherenceStatus? status,
    Object? takenAt = $none,
    Object? notes = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (familyMemberMedicationId != null)
        #familyMemberMedicationId: familyMemberMedicationId,
      if (scheduledTime != null) #scheduledTime: scheduledTime,
      if (status != null) #status: status,
      if (takenAt != $none) #takenAt: takenAt,
      if (notes != $none) #notes: notes,
    }),
  );
  @override
  AdherenceLog $make(CopyWithData data) => AdherenceLog(
    id: data.get(#id, or: $value.id),
    familyMemberMedicationId: data.get(
      #familyMemberMedicationId,
      or: $value.familyMemberMedicationId,
    ),
    scheduledTime: data.get(#scheduledTime, or: $value.scheduledTime),
    status: data.get(#status, or: $value.status),
    takenAt: data.get(#takenAt, or: $value.takenAt),
    notes: data.get(#notes, or: $value.notes),
  );

  @override
  AdherenceLogCopyWith<$R2, AdherenceLog, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AdherenceLogCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

