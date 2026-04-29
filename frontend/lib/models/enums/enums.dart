// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';

part 'enums.mapper.dart';

@MappableEnum(mode: ValuesMode.named, caseStyle: CaseStyle.snakeCase)
enum UserRole { caregiver, familyMember, viewer }

@MappableEnum(mode: ValuesMode.named)
enum RiskLevel { low, medium, high }

@MappableEnum(mode: ValuesMode.named)
enum Priority { low, medium, high }

@MappableEnum(mode: ValuesMode.named)
enum DosageUnit { mg, mcg, g, mL, iu, tsp, tbsp, oz, units, percent }

@MappableEnum(mode: ValuesMode.named)
enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

@MappableEnum(mode: ValuesMode.named, defaultValue: AuthState.unauthenticated)
enum AuthState { authenticated, unauthenticated }

enum AdherenceStatus {
  allCaughtUp,
  inProgress,
  critical;

  static AdherenceStatus fromMissedCount(int count) {
    if (count == 0) return AdherenceStatus.allCaughtUp;
    if (count <= 2) return AdherenceStatus.inProgress;
    return AdherenceStatus.critical;
  }

  String get label => switch (this) {
    AdherenceStatus.allCaughtUp    => 'Completed',
    AdherenceStatus.inProgress     => 'Normal',
    AdherenceStatus.critical       => 'Critical',
  };

}