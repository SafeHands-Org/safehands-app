// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'invitation.dart';

class InvitationMapper extends ClassMapperBase<Invitation> {
  InvitationMapper._();

  static InvitationMapper? _instance;
  static InvitationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InvitationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Invitation';

  static String _$id(Invitation v) => v.id;
  static const Field<Invitation, String> _f$id = Field('id', _$id);
  static String _$familyId(Invitation v) => v.familyId;
  static const Field<Invitation, String> _f$familyId = Field(
    'familyId',
    _$familyId,
  );
  static String _$email(Invitation v) => v.email;
  static const Field<Invitation, String> _f$email = Field('email', _$email);
  static InvitationStatus _$status(Invitation v) => v.status;
  static const Field<Invitation, InvitationStatus> _f$status = Field(
    'status',
    _$status,
  );
  static DateTime _$createdAt(Invitation v) => v.createdAt;
  static const Field<Invitation, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static DateTime? _$expiresAt(Invitation v) => v.expiresAt;
  static const Field<Invitation, DateTime> _f$expiresAt = Field(
    'expiresAt',
    _$expiresAt,
    opt: true,
  );

  @override
  final MappableFields<Invitation> fields = const {
    #id: _f$id,
    #familyId: _f$familyId,
    #email: _f$email,
    #status: _f$status,
    #createdAt: _f$createdAt,
    #expiresAt: _f$expiresAt,
  };

  static Invitation _instantiate(DecodingData data) {
    return Invitation(
      id: data.dec(_f$id),
      familyId: data.dec(_f$familyId),
      email: data.dec(_f$email),
      status: data.dec(_f$status),
      createdAt: data.dec(_f$createdAt),
      expiresAt: data.dec(_f$expiresAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Invitation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Invitation>(map);
  }

  static Invitation fromJson(String json) {
    return ensureInitialized().decodeJson<Invitation>(json);
  }
}

mixin InvitationMappable {
  String toJson() {
    return InvitationMapper.ensureInitialized().encodeJson<Invitation>(
      this as Invitation,
    );
  }

  Map<String, dynamic> toMap() {
    return InvitationMapper.ensureInitialized().encodeMap<Invitation>(
      this as Invitation,
    );
  }

  InvitationCopyWith<Invitation, Invitation, Invitation> get copyWith =>
      _InvitationCopyWithImpl<Invitation, Invitation>(
        this as Invitation,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return InvitationMapper.ensureInitialized().stringifyValue(
      this as Invitation,
    );
  }

  @override
  bool operator ==(Object other) {
    return InvitationMapper.ensureInitialized().equalsValue(
      this as Invitation,
      other,
    );
  }

  @override
  int get hashCode {
    return InvitationMapper.ensureInitialized().hashValue(this as Invitation);
  }
}

extension InvitationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Invitation, $Out> {
  InvitationCopyWith<$R, Invitation, $Out> get $asInvitation =>
      $base.as((v, t, t2) => _InvitationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class InvitationCopyWith<$R, $In extends Invitation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? familyId,
    String? email,
    InvitationStatus? status,
    DateTime? createdAt,
    DateTime? expiresAt,
  });
  InvitationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _InvitationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Invitation, $Out>
    implements InvitationCopyWith<$R, Invitation, $Out> {
  _InvitationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Invitation> $mapper =
      InvitationMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? familyId,
    String? email,
    InvitationStatus? status,
    DateTime? createdAt,
    Object? expiresAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (familyId != null) #familyId: familyId,
      if (email != null) #email: email,
      if (status != null) #status: status,
      if (createdAt != null) #createdAt: createdAt,
      if (expiresAt != $none) #expiresAt: expiresAt,
    }),
  );
  @override
  Invitation $make(CopyWithData data) => Invitation(
    id: data.get(#id, or: $value.id),
    familyId: data.get(#familyId, or: $value.familyId),
    email: data.get(#email, or: $value.email),
    status: data.get(#status, or: $value.status),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    expiresAt: data.get(#expiresAt, or: $value.expiresAt),
  );

  @override
  InvitationCopyWith<$R2, Invitation, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _InvitationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

