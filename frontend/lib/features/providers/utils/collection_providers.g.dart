// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentMembers)
final currentMembersProvider = CurrentMembersProvider._();

final class CurrentMembersProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, FamilyMember>>,
          Map<String, FamilyMember>,
          FutureOr<Map<String, FamilyMember>>
        >
    with
        $FutureModifier<Map<String, FamilyMember>>,
        $FutureProvider<Map<String, FamilyMember>> {
  CurrentMembersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentMembersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentMembersHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, FamilyMember>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, FamilyMember>> create(Ref ref) {
    return currentMembers(ref);
  }
}

String _$currentMembersHash() => r'01c08b5c2b410e24cbbea61de7ddefa89c45a812';

@ProviderFor(currentAssignments)
final currentAssignmentsProvider = CurrentAssignmentsProvider._();

final class CurrentAssignmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, List<FamilyMemberMedication>>>,
          Map<String, List<FamilyMemberMedication>>,
          FutureOr<Map<String, List<FamilyMemberMedication>>>
        >
    with
        $FutureModifier<Map<String, List<FamilyMemberMedication>>>,
        $FutureProvider<Map<String, List<FamilyMemberMedication>>> {
  CurrentAssignmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentAssignmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentAssignmentsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, List<FamilyMemberMedication>>>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<FamilyMemberMedication>>> create(Ref ref) {
    return currentAssignments(ref);
  }
}

String _$currentAssignmentsHash() =>
    r'33fea0f7f6ba7a84036e3f86a65ac16c1689d995';

@ProviderFor(currentMedications)
final currentMedicationsProvider = CurrentMedicationsProvider._();

final class CurrentMedicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Medication>>,
          Map<String, Medication>,
          FutureOr<Map<String, Medication>>
        >
    with
        $FutureModifier<Map<String, Medication>>,
        $FutureProvider<Map<String, Medication>> {
  CurrentMedicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentMedicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentMedicationsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, Medication>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Medication>> create(Ref ref) {
    return currentMedications(ref);
  }
}

String _$currentMedicationsHash() =>
    r'214c0b7e27dfe93797cf4edf606489efd51b704c';

@ProviderFor(currentSchedules)
final currentSchedulesProvider = CurrentSchedulesProvider._();

final class CurrentSchedulesProvider
    extends
        $FunctionalProvider<
          AsyncValue<MemberSchedules>,
          MemberSchedules,
          FutureOr<MemberSchedules>
        >
    with $FutureModifier<MemberSchedules>, $FutureProvider<MemberSchedules> {
  CurrentSchedulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSchedulesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSchedulesHash();

  @$internal
  @override
  $FutureProviderElement<MemberSchedules> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MemberSchedules> create(Ref ref) {
    return currentSchedules(ref);
  }
}

String _$currentSchedulesHash() => r'75a28977f3eb71d757d97bc40cdfadfb64834f3d';

@ProviderFor(aggregateMember)
final aggregateMemberProvider = AggregateMemberFamily._();

final class AggregateMemberProvider
    extends $FunctionalProvider<AsyncValue<Member>, Member, FutureOr<Member>>
    with $FutureModifier<Member>, $FutureProvider<Member> {
  AggregateMemberProvider._({
    required AggregateMemberFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'aggregateMemberProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aggregateMemberHash();

  @override
  String toString() {
    return r'aggregateMemberProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Member> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Member> create(Ref ref) {
    final argument = this.argument as String;
    return aggregateMember(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AggregateMemberProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aggregateMemberHash() => r'334ee53e1a0397253091f83b5e601f520aea02c0';

final class AggregateMemberFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Member>, String> {
  AggregateMemberFamily._()
    : super(
        retry: null,
        name: r'aggregateMemberProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AggregateMemberProvider call(String fmid) =>
      AggregateMemberProvider._(argument: fmid, from: this);

  @override
  String toString() => r'aggregateMemberProvider';
}

@ProviderFor(aggregateMemberships)
final aggregateMembershipsProvider = AggregateMembershipsFamily._();

final class AggregateMembershipsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Member>>,
          List<Member>,
          FutureOr<List<Member>>
        >
    with $FutureModifier<List<Member>>, $FutureProvider<List<Member>> {
  AggregateMembershipsProvider._({
    required AggregateMembershipsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'aggregateMembershipsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aggregateMembershipsHash();

  @override
  String toString() {
    return r'aggregateMembershipsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Member>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Member>> create(Ref ref) {
    final argument = this.argument as String;
    return aggregateMemberships(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AggregateMembershipsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aggregateMembershipsHash() =>
    r'b2f6b1f9703a9c21c8a06a3fa1e6fcde6bdf9f12';

final class AggregateMembershipsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Member>>, String> {
  AggregateMembershipsFamily._()
    : super(
        retry: null,
        name: r'aggregateMembershipsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AggregateMembershipsProvider call(String fid) =>
      AggregateMembershipsProvider._(argument: fid, from: this);

  @override
  String toString() => r'aggregateMembershipsProvider';
}

@ProviderFor(aggregateFamily)
final aggregateFamilyProvider = AggregateFamilyProvider._();

final class AggregateFamilyProvider
    extends
        $FunctionalProvider<
          AsyncValue<FamilyCollection>,
          FamilyCollection,
          FutureOr<FamilyCollection>
        >
    with $FutureModifier<FamilyCollection>, $FutureProvider<FamilyCollection> {
  AggregateFamilyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aggregateFamilyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aggregateFamilyHash();

  @$internal
  @override
  $FutureProviderElement<FamilyCollection> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FamilyCollection> create(Ref ref) {
    return aggregateFamily(ref);
  }
}

String _$aggregateFamilyHash() => r'6f686e919720f4841f4a581cb2ca15dd326f6b51';
