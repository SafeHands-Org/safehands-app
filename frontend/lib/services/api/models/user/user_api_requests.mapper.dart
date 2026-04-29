// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_api_requests.dart';

class UserUpdateMapper extends ClassMapperBase<UserUpdate> {
  UserUpdateMapper._();

  static UserUpdateMapper? _instance;
  static UserUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserUpdateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserUpdate';

  static String _$name(UserUpdate v) => v.name;
  static const Field<UserUpdate, String> _f$name = Field('name', _$name);
  static String _$email(UserUpdate v) => v.email;
  static const Field<UserUpdate, String> _f$email = Field('email', _$email);

  @override
  final MappableFields<UserUpdate> fields = const {
    #name: _f$name,
    #email: _f$email,
  };

  static UserUpdate _instantiate(DecodingData data) {
    return UserUpdate(name: data.dec(_f$name), email: data.dec(_f$email));
  }

  @override
  final Function instantiate = _instantiate;

  static UserUpdate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserUpdate>(map);
  }

  static UserUpdate fromJson(String json) {
    return ensureInitialized().decodeJson<UserUpdate>(json);
  }
}

mixin UserUpdateMappable {
  String toJson() {
    return UserUpdateMapper.ensureInitialized().encodeJson<UserUpdate>(
      this as UserUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return UserUpdateMapper.ensureInitialized().encodeMap<UserUpdate>(
      this as UserUpdate,
    );
  }

  UserUpdateCopyWith<UserUpdate, UserUpdate, UserUpdate> get copyWith =>
      _UserUpdateCopyWithImpl<UserUpdate, UserUpdate>(
        this as UserUpdate,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserUpdateMapper.ensureInitialized().stringifyValue(
      this as UserUpdate,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserUpdateMapper.ensureInitialized().equalsValue(
      this as UserUpdate,
      other,
    );
  }

  @override
  int get hashCode {
    return UserUpdateMapper.ensureInitialized().hashValue(this as UserUpdate);
  }
}

extension UserUpdateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserUpdate, $Out> {
  UserUpdateCopyWith<$R, UserUpdate, $Out> get $asUserUpdate =>
      $base.as((v, t, t2) => _UserUpdateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserUpdateCopyWith<$R, $In extends UserUpdate, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? email});
  UserUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserUpdate, $Out>
    implements UserUpdateCopyWith<$R, UserUpdate, $Out> {
  _UserUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserUpdate> $mapper =
      UserUpdateMapper.ensureInitialized();
  @override
  $R call({String? name, String? email}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (email != null) #email: email,
    }),
  );
  @override
  UserUpdate $make(CopyWithData data) => UserUpdate(
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
  );

  @override
  UserUpdateCopyWith<$R2, UserUpdate, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserUpdateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LoginRequestMapper extends ClassMapperBase<LoginRequest> {
  LoginRequestMapper._();

  static LoginRequestMapper? _instance;
  static LoginRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoginRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LoginRequest';

  static String _$email(LoginRequest v) => v.email;
  static const Field<LoginRequest, String> _f$email = Field('email', _$email);
  static String _$password(LoginRequest v) => v.password;
  static const Field<LoginRequest, String> _f$password = Field(
    'password',
    _$password,
  );

  @override
  final MappableFields<LoginRequest> fields = const {
    #email: _f$email,
    #password: _f$password,
  };

  static LoginRequest _instantiate(DecodingData data) {
    return LoginRequest(
      email: data.dec(_f$email),
      password: data.dec(_f$password),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LoginRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LoginRequest>(map);
  }

  static LoginRequest fromJson(String json) {
    return ensureInitialized().decodeJson<LoginRequest>(json);
  }
}

mixin LoginRequestMappable {
  String toJson() {
    return LoginRequestMapper.ensureInitialized().encodeJson<LoginRequest>(
      this as LoginRequest,
    );
  }

  Map<String, dynamic> toMap() {
    return LoginRequestMapper.ensureInitialized().encodeMap<LoginRequest>(
      this as LoginRequest,
    );
  }

  LoginRequestCopyWith<LoginRequest, LoginRequest, LoginRequest> get copyWith =>
      _LoginRequestCopyWithImpl<LoginRequest, LoginRequest>(
        this as LoginRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LoginRequestMapper.ensureInitialized().stringifyValue(
      this as LoginRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return LoginRequestMapper.ensureInitialized().equalsValue(
      this as LoginRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return LoginRequestMapper.ensureInitialized().hashValue(
      this as LoginRequest,
    );
  }
}

extension LoginRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LoginRequest, $Out> {
  LoginRequestCopyWith<$R, LoginRequest, $Out> get $asLoginRequest =>
      $base.as((v, t, t2) => _LoginRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LoginRequestCopyWith<$R, $In extends LoginRequest, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? email, String? password});
  LoginRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LoginRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LoginRequest, $Out>
    implements LoginRequestCopyWith<$R, LoginRequest, $Out> {
  _LoginRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LoginRequest> $mapper =
      LoginRequestMapper.ensureInitialized();
  @override
  $R call({String? email, String? password}) => $apply(
    FieldCopyWithData({
      if (email != null) #email: email,
      if (password != null) #password: password,
    }),
  );
  @override
  LoginRequest $make(CopyWithData data) => LoginRequest(
    email: data.get(#email, or: $value.email),
    password: data.get(#password, or: $value.password),
  );

  @override
  LoginRequestCopyWith<$R2, LoginRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LoginRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RegisterRequestMapper extends ClassMapperBase<RegisterRequest> {
  RegisterRequestMapper._();

  static RegisterRequestMapper? _instance;
  static RegisterRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegisterRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RegisterRequest';

  static String _$name(RegisterRequest v) => v.name;
  static const Field<RegisterRequest, String> _f$name = Field('name', _$name);
  static String _$email(RegisterRequest v) => v.email;
  static const Field<RegisterRequest, String> _f$email = Field(
    'email',
    _$email,
  );
  static String _$password(RegisterRequest v) => v.password;
  static const Field<RegisterRequest, String> _f$password = Field(
    'password',
    _$password,
  );
  static String _$role(RegisterRequest v) => v.role;
  static const Field<RegisterRequest, String> _f$role = Field('role', _$role);

  @override
  final MappableFields<RegisterRequest> fields = const {
    #name: _f$name,
    #email: _f$email,
    #password: _f$password,
    #role: _f$role,
  };

  static RegisterRequest _instantiate(DecodingData data) {
    return RegisterRequest(
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      password: data.dec(_f$password),
      role: data.dec(_f$role),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RegisterRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegisterRequest>(map);
  }

  static RegisterRequest fromJson(String json) {
    return ensureInitialized().decodeJson<RegisterRequest>(json);
  }
}

mixin RegisterRequestMappable {
  String toJson() {
    return RegisterRequestMapper.ensureInitialized()
        .encodeJson<RegisterRequest>(this as RegisterRequest);
  }

  Map<String, dynamic> toMap() {
    return RegisterRequestMapper.ensureInitialized().encodeMap<RegisterRequest>(
      this as RegisterRequest,
    );
  }

  RegisterRequestCopyWith<RegisterRequest, RegisterRequest, RegisterRequest>
  get copyWith =>
      _RegisterRequestCopyWithImpl<RegisterRequest, RegisterRequest>(
        this as RegisterRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return RegisterRequestMapper.ensureInitialized().stringifyValue(
      this as RegisterRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return RegisterRequestMapper.ensureInitialized().equalsValue(
      this as RegisterRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return RegisterRequestMapper.ensureInitialized().hashValue(
      this as RegisterRequest,
    );
  }
}

extension RegisterRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegisterRequest, $Out> {
  RegisterRequestCopyWith<$R, RegisterRequest, $Out> get $asRegisterRequest =>
      $base.as((v, t, t2) => _RegisterRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RegisterRequestCopyWith<$R, $In extends RegisterRequest, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? email, String? password, String? role});
  RegisterRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RegisterRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegisterRequest, $Out>
    implements RegisterRequestCopyWith<$R, RegisterRequest, $Out> {
  _RegisterRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegisterRequest> $mapper =
      RegisterRequestMapper.ensureInitialized();
  @override
  $R call({String? name, String? email, String? password, String? role}) =>
      $apply(
        FieldCopyWithData({
          if (name != null) #name: name,
          if (email != null) #email: email,
          if (password != null) #password: password,
          if (role != null) #role: role,
        }),
      );
  @override
  RegisterRequest $make(CopyWithData data) => RegisterRequest(
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    password: data.get(#password, or: $value.password),
    role: data.get(#role, or: $value.role),
  );

  @override
  RegisterRequestCopyWith<$R2, RegisterRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _RegisterRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

