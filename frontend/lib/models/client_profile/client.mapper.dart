// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'client.dart';

class ClientMapper extends ClassMapperBase<Client> {
  ClientMapper._();

  static ClientMapper? _instance;
  static ClientMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Client';

  static String _$name(Client v) => v.name;
  static const Field<Client, String> _f$name = Field('name', _$name);
  static String _$email(Client v) => v.email;
  static const Field<Client, String> _f$email = Field('email', _$email);
  static String _$role(Client v) => v.role;
  static const Field<Client, String> _f$role = Field('role', _$role);

  @override
  final MappableFields<Client> fields = const {
    #name: _f$name,
    #email: _f$email,
    #role: _f$role,
  };

  static Client _instantiate(DecodingData data) {
    return Client(
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      role: data.dec(_f$role),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Client fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Client>(map);
  }

  static Client fromJson(String json) {
    return ensureInitialized().decodeJson<Client>(json);
  }
}

mixin ClientMappable {
  String toJson() {
    return ClientMapper.ensureInitialized().encodeJson<Client>(this as Client);
  }

  Map<String, dynamic> toMap() {
    return ClientMapper.ensureInitialized().encodeMap<Client>(this as Client);
  }

  ClientCopyWith<Client, Client, Client> get copyWith =>
      _ClientCopyWithImpl<Client, Client>(this as Client, $identity, $identity);
  @override
  String toString() {
    return ClientMapper.ensureInitialized().stringifyValue(this as Client);
  }

  @override
  bool operator ==(Object other) {
    return ClientMapper.ensureInitialized().equalsValue(this as Client, other);
  }

  @override
  int get hashCode {
    return ClientMapper.ensureInitialized().hashValue(this as Client);
  }
}

extension ClientValueCopy<$R, $Out> on ObjectCopyWith<$R, Client, $Out> {
  ClientCopyWith<$R, Client, $Out> get $asClient =>
      $base.as((v, t, t2) => _ClientCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ClientCopyWith<$R, $In extends Client, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? email, String? role});
  ClientCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ClientCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Client, $Out>
    implements ClientCopyWith<$R, Client, $Out> {
  _ClientCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Client> $mapper = ClientMapper.ensureInitialized();
  @override
  $R call({String? name, String? email, String? role}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (role != null) #role: role,
    }),
  );
  @override
  Client $make(CopyWithData data) => Client(
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    role: data.get(#role, or: $value.role),
  );

  @override
  ClientCopyWith<$R2, Client, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ClientCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

