// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'adherence_log_request.dart';

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

  static String _$scheduledTime(AdherenceLogRequest v) => v.scheduledTime;
  static const Field<AdherenceLogRequest, String> _f$scheduledTime = Field(
    'scheduledTime',
    _$scheduledTime,
  );
  static String _$status(AdherenceLogRequest v) => v.status;
  static const Field<AdherenceLogRequest, String> _f$status = Field(
    'status',
    _$status,
  );
  static DateTime? _$takenAt(AdherenceLogRequest v) => v.takenAt;
  static const Field<AdherenceLogRequest, DateTime> _f$takenAt = Field(
    'takenAt',
    _$takenAt,
    opt: true,
  );

  @override
  final MappableFields<AdherenceLogRequest> fields = const {
    #scheduledTime: _f$scheduledTime,
    #status: _f$status,
    #takenAt: _f$takenAt,
  };

  static AdherenceLogRequest _instantiate(DecodingData data) {
    return AdherenceLogRequest(
      scheduledTime: data.dec(_f$scheduledTime),
      status: data.dec(_f$status),
      takenAt: data.dec(_f$takenAt),
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
  $R call({String? scheduledTime, String? status, DateTime? takenAt});
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
  $R call({String? scheduledTime, String? status, Object? takenAt = $none}) =>
      $apply(
        FieldCopyWithData({
          if (scheduledTime != null) #scheduledTime: scheduledTime,
          if (status != null) #status: status,
          if (takenAt != $none) #takenAt: takenAt,
        }),
      );
  @override
  AdherenceLogRequest $make(CopyWithData data) => AdherenceLogRequest(
    scheduledTime: data.get(#scheduledTime, or: $value.scheduledTime),
    status: data.get(#status, or: $value.status),
    takenAt: data.get(#takenAt, or: $value.takenAt),
  );

  @override
  AdherenceLogRequestCopyWith<$R2, AdherenceLogRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AdherenceLogRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

