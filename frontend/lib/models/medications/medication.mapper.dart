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
  static String _$name(Medication v) => v.name;
  static const Field<Medication, String> _f$name = Field('name', _$name);
  static String _$time(Medication v) => v.time;
  static const Field<Medication, String> _f$time = Field('time', _$time);
  static MedicationPriority _$priority(Medication v) => v.priority;
  static const Field<Medication, MedicationPriority> _f$priority = Field(
    'priority',
    _$priority,
    opt: true,
    def: MedicationPriority.low,
  );

  @override
  final MappableFields<Medication> fields = const {
    #id: _f$id,
    #name: _f$name,
    #time: _f$time,
    #priority: _f$priority,
  };

  static Medication _instantiate(DecodingData data) {
    return Medication(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      time: data.dec(_f$time),
      priority: data.dec(_f$priority),
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
    String? name,
    String? time,
    MedicationPriority? priority,
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
    String? name,
    String? time,
    MedicationPriority? priority,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (time != null) #time: time,
      if (priority != null) #priority: priority,
    }),
  );
  @override
  Medication $make(CopyWithData data) => Medication(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    time: data.get(#time, or: $value.time),
    priority: data.get(#priority, or: $value.priority),
  );

  @override
  MedicationCopyWith<$R2, Medication, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MedicationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

