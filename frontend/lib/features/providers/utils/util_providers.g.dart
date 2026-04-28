// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'util_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeMedications)
final activeMedicationsProvider = ActiveMedicationsProvider._();

final class ActiveMedicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Medication>>,
          List<Medication>,
          FutureOr<List<Medication>>
        >
    with $FutureModifier<List<Medication>>, $FutureProvider<List<Medication>> {
  ActiveMedicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeMedicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeMedicationsHash();

  @$internal
  @override
  $FutureProviderElement<List<Medication>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Medication>> create(Ref ref) {
    return activeMedications(ref);
  }
}

String _$activeMedicationsHash() => r'227851fdd25a3623b954af878ffc5529d69145f0';

@ProviderFor(activeAssignments)
final activeAssignmentsProvider = ActiveAssignmentsProvider._();

final class ActiveAssignmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FamilyMemberMedication>>,
          List<FamilyMemberMedication>,
          FutureOr<List<FamilyMemberMedication>>
        >
    with
        $FutureModifier<List<FamilyMemberMedication>>,
        $FutureProvider<List<FamilyMemberMedication>> {
  ActiveAssignmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeAssignmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeAssignmentsHash();

  @$internal
  @override
  $FutureProviderElement<List<FamilyMemberMedication>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FamilyMemberMedication>> create(Ref ref) {
    return activeAssignments(ref);
  }
}

String _$activeAssignmentsHash() => r'728172f24a3dba254a4ae9c6c87461e33864c2e1';

@ProviderFor(todaysLogs)
final todaysLogsProvider = TodaysLogsProvider._();

final class TodaysLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MedicationAdherenceLog>>,
          List<MedicationAdherenceLog>,
          FutureOr<List<MedicationAdherenceLog>>
        >
    with
        $FutureModifier<List<MedicationAdherenceLog>>,
        $FutureProvider<List<MedicationAdherenceLog>> {
  TodaysLogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todaysLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todaysLogsHash();

  @$internal
  @override
  $FutureProviderElement<List<MedicationAdherenceLog>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MedicationAdherenceLog>> create(Ref ref) {
    return todaysLogs(ref);
  }
}

String _$todaysLogsHash() => r'79b8a5d256c0788b81c40104eb382cb342860866';

@ProviderFor(upcomingFamilyDoses)
final upcomingFamilyDosesProvider = UpcomingFamilyDosesProvider._();

final class UpcomingFamilyDosesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Member>>,
          List<Member>,
          FutureOr<List<Member>>
        >
    with $FutureModifier<List<Member>>, $FutureProvider<List<Member>> {
  UpcomingFamilyDosesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingFamilyDosesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingFamilyDosesHash();

  @$internal
  @override
  $FutureProviderElement<List<Member>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Member>> create(Ref ref) {
    return upcomingFamilyDoses(ref);
  }
}

String _$upcomingFamilyDosesHash() =>
    r'd543f47eb11403eab31d9bb56af50aac881c6cde';

@ProviderFor(upcomingMemberDoses)
final upcomingMemberDosesProvider = UpcomingMemberDosesFamily._();

final class UpcomingMemberDosesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MedicationSchedule>>,
          List<MedicationSchedule>,
          FutureOr<List<MedicationSchedule>>
        >
    with
        $FutureModifier<List<MedicationSchedule>>,
        $FutureProvider<List<MedicationSchedule>> {
  UpcomingMemberDosesProvider._({
    required UpcomingMemberDosesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'upcomingMemberDosesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$upcomingMemberDosesHash();

  @override
  String toString() {
    return r'upcomingMemberDosesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MedicationSchedule>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MedicationSchedule>> create(Ref ref) {
    final argument = this.argument as String;
    return upcomingMemberDoses(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpcomingMemberDosesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upcomingMemberDosesHash() =>
    r'f018f16e426d1d37e408de34381811e4f8be1b23';

final class UpcomingMemberDosesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MedicationSchedule>>, String> {
  UpcomingMemberDosesFamily._()
    : super(
        retry: null,
        name: r'upcomingMemberDosesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpcomingMemberDosesProvider call(String fmid) =>
      UpcomingMemberDosesProvider._(argument: fmid, from: this);

  @override
  String toString() => r'upcomingMemberDosesProvider';
}

@ProviderFor(todaysFamilyDoses)
final todaysFamilyDosesProvider = TodaysFamilyDosesProvider._();

final class TodaysFamilyDosesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Member>>,
          List<Member>,
          FutureOr<List<Member>>
        >
    with $FutureModifier<List<Member>>, $FutureProvider<List<Member>> {
  TodaysFamilyDosesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todaysFamilyDosesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todaysFamilyDosesHash();

  @$internal
  @override
  $FutureProviderElement<List<Member>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Member>> create(Ref ref) {
    return todaysFamilyDoses(ref);
  }
}

String _$todaysFamilyDosesHash() => r'07dce6ccd270ebba28080fd7a91723e02f822bb5';

@ProviderFor(todaysMemberDoses)
final todaysMemberDosesProvider = TodaysMemberDosesFamily._();

final class TodaysMemberDosesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MedicationSchedule>>,
          List<MedicationSchedule>,
          FutureOr<List<MedicationSchedule>>
        >
    with
        $FutureModifier<List<MedicationSchedule>>,
        $FutureProvider<List<MedicationSchedule>> {
  TodaysMemberDosesProvider._({
    required TodaysMemberDosesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'todaysMemberDosesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$todaysMemberDosesHash();

  @override
  String toString() {
    return r'todaysMemberDosesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MedicationSchedule>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MedicationSchedule>> create(Ref ref) {
    final argument = this.argument as String;
    return todaysMemberDoses(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TodaysMemberDosesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$todaysMemberDosesHash() => r'cb0ecde5d7ef9b4e53c183475882ff613c4188c0';

final class TodaysMemberDosesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MedicationSchedule>>, String> {
  TodaysMemberDosesFamily._()
    : super(
        retry: null,
        name: r'todaysMemberDosesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TodaysMemberDosesProvider call(String fmid) =>
      TodaysMemberDosesProvider._(argument: fmid, from: this);

  @override
  String toString() => r'todaysMemberDosesProvider';
}

@ProviderFor(sortByPriority)
final sortByPriorityProvider = SortByPriorityFamily._();

final class SortByPriorityProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FamilyMember>>,
          List<FamilyMember>,
          FutureOr<List<FamilyMember>>
        >
    with
        $FutureModifier<List<FamilyMember>>,
        $FutureProvider<List<FamilyMember>> {
  SortByPriorityProvider._({
    required SortByPriorityFamily super.from,
    required List<FamilyMember> super.argument,
  }) : super(
         retry: null,
         name: r'sortByPriorityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sortByPriorityHash();

  @override
  String toString() {
    return r'sortByPriorityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FamilyMember>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FamilyMember>> create(Ref ref) {
    final argument = this.argument as List<FamilyMember>;
    return sortByPriority(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SortByPriorityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sortByPriorityHash() => r'a1c13956ea4e3197aaca61a3860c319611201719';

final class SortByPriorityFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<FamilyMember>>,
          List<FamilyMember>
        > {
  SortByPriorityFamily._()
    : super(
        retry: null,
        name: r'sortByPriorityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SortByPriorityProvider call(List<FamilyMember> memberList) =>
      SortByPriorityProvider._(argument: memberList, from: this);

  @override
  String toString() => r'sortByPriorityProvider';
}

@ProviderFor(familyStats)
final familyStatsProvider = FamilyStatsFamily._();

final class FamilyStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FamilyMember>>,
          List<FamilyMember>,
          FutureOr<List<FamilyMember>>
        >
    with
        $FutureModifier<List<FamilyMember>>,
        $FutureProvider<List<FamilyMember>> {
  FamilyStatsProvider._({
    required FamilyStatsFamily super.from,
    required List<FamilyMember> super.argument,
  }) : super(
         retry: null,
         name: r'familyStatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$familyStatsHash();

  @override
  String toString() {
    return r'familyStatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FamilyMember>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FamilyMember>> create(Ref ref) {
    final argument = this.argument as List<FamilyMember>;
    return familyStats(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FamilyStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$familyStatsHash() => r'391032644d624eb1e390cb9e3d6a897a546e0b19';

final class FamilyStatsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<FamilyMember>>,
          List<FamilyMember>
        > {
  FamilyStatsFamily._()
    : super(
        retry: null,
        name: r'familyStatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FamilyStatsProvider call(List<FamilyMember> memberList) =>
      FamilyStatsProvider._(argument: memberList, from: this);

  @override
  String toString() => r'familyStatsProvider';
}
