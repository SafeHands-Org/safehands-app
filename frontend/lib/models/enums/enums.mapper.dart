// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enums.dart';

class UserRoleMapper extends EnumMapper<UserRole> {
  UserRoleMapper._();

  static UserRoleMapper? _instance;
  static UserRoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserRoleMapper._());
    }
    return _instance!;
  }

  static UserRole fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  UserRole decode(dynamic value) {
    switch (value) {
      case r'caregiver':
        return UserRole.caregiver;
      case r'family_member':
        return UserRole.familyMember;
      case r'viewer':
        return UserRole.viewer;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(UserRole self) {
    switch (self) {
      case UserRole.caregiver:
        return r'caregiver';
      case UserRole.familyMember:
        return r'family_member';
      case UserRole.viewer:
        return r'viewer';
    }
  }
}

extension UserRoleMapperExtension on UserRole {
  String toValue() {
    UserRoleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<UserRole>(this) as String;
  }
}

class RiskLevelMapper extends EnumMapper<RiskLevel> {
  RiskLevelMapper._();

  static RiskLevelMapper? _instance;
  static RiskLevelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RiskLevelMapper._());
    }
    return _instance!;
  }

  static RiskLevel fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  RiskLevel decode(dynamic value) {
    switch (value) {
      case r'low':
        return RiskLevel.low;
      case r'medium':
        return RiskLevel.medium;
      case r'high':
        return RiskLevel.high;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(RiskLevel self) {
    switch (self) {
      case RiskLevel.low:
        return r'low';
      case RiskLevel.medium:
        return r'medium';
      case RiskLevel.high:
        return r'high';
    }
  }
}

extension RiskLevelMapperExtension on RiskLevel {
  String toValue() {
    RiskLevelMapper.ensureInitialized();
    return MapperContainer.globals.toValue<RiskLevel>(this) as String;
  }
}

class PriorityMapper extends EnumMapper<Priority> {
  PriorityMapper._();

  static PriorityMapper? _instance;
  static PriorityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PriorityMapper._());
    }
    return _instance!;
  }

  static Priority fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Priority decode(dynamic value) {
    switch (value) {
      case r'low':
        return Priority.low;
      case r'medium':
        return Priority.medium;
      case r'high':
        return Priority.high;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Priority self) {
    switch (self) {
      case Priority.low:
        return r'low';
      case Priority.medium:
        return r'medium';
      case Priority.high:
        return r'high';
    }
  }
}

extension PriorityMapperExtension on Priority {
  String toValue() {
    PriorityMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Priority>(this) as String;
  }
}

class DosageUnitMapper extends EnumMapper<DosageUnit> {
  DosageUnitMapper._();

  static DosageUnitMapper? _instance;
  static DosageUnitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DosageUnitMapper._());
    }
    return _instance!;
  }

  static DosageUnit fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DosageUnit decode(dynamic value) {
    switch (value) {
      case r'mg':
        return DosageUnit.mg;
      case r'mcg':
        return DosageUnit.mcg;
      case r'g':
        return DosageUnit.g;
      case r'mL':
        return DosageUnit.mL;
      case r'iu':
        return DosageUnit.iu;
      case r'tsp':
        return DosageUnit.tsp;
      case r'tbsp':
        return DosageUnit.tbsp;
      case r'oz':
        return DosageUnit.oz;
      case r'units':
        return DosageUnit.units;
      case r'percent':
        return DosageUnit.percent;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DosageUnit self) {
    switch (self) {
      case DosageUnit.mg:
        return r'mg';
      case DosageUnit.mcg:
        return r'mcg';
      case DosageUnit.g:
        return r'g';
      case DosageUnit.mL:
        return r'mL';
      case DosageUnit.iu:
        return r'iu';
      case DosageUnit.tsp:
        return r'tsp';
      case DosageUnit.tbsp:
        return r'tbsp';
      case DosageUnit.oz:
        return r'oz';
      case DosageUnit.units:
        return r'units';
      case DosageUnit.percent:
        return r'percent';
    }
  }
}

extension DosageUnitMapperExtension on DosageUnit {
  String toValue() {
    DosageUnitMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DosageUnit>(this) as String;
  }
}

class WeekdayMapper extends EnumMapper<Weekday> {
  WeekdayMapper._();

  static WeekdayMapper? _instance;
  static WeekdayMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeekdayMapper._());
    }
    return _instance!;
  }

  static Weekday fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Weekday decode(dynamic value) {
    switch (value) {
      case r'monday':
        return Weekday.monday;
      case r'tuesday':
        return Weekday.tuesday;
      case r'wednesday':
        return Weekday.wednesday;
      case r'thursday':
        return Weekday.thursday;
      case r'friday':
        return Weekday.friday;
      case r'saturday':
        return Weekday.saturday;
      case r'sunday':
        return Weekday.sunday;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Weekday self) {
    switch (self) {
      case Weekday.monday:
        return r'monday';
      case Weekday.tuesday:
        return r'tuesday';
      case Weekday.wednesday:
        return r'wednesday';
      case Weekday.thursday:
        return r'thursday';
      case Weekday.friday:
        return r'friday';
      case Weekday.saturday:
        return r'saturday';
      case Weekday.sunday:
        return r'sunday';
    }
  }
}

extension WeekdayMapperExtension on Weekday {
  String toValue() {
    WeekdayMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Weekday>(this) as String;
  }
}

class AuthStateMapper extends EnumMapper<AuthState> {
  AuthStateMapper._();

  static AuthStateMapper? _instance;
  static AuthStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateMapper._());
    }
    return _instance!;
  }

  static AuthState fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AuthState decode(dynamic value) {
    switch (value) {
      case r'authenticated':
        return AuthState.authenticated;
      case r'unauthenticated':
        return AuthState.unauthenticated;
      default:
        return AuthState.values[1];
    }
  }

  @override
  dynamic encode(AuthState self) {
    switch (self) {
      case AuthState.authenticated:
        return r'authenticated';
      case AuthState.unauthenticated:
        return r'unauthenticated';
    }
  }
}

extension AuthStateMapperExtension on AuthState {
  String toValue() {
    AuthStateMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AuthState>(this) as String;
  }
}

