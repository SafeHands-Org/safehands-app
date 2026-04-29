// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assignmentRepository)
final assignmentRepositoryProvider = AssignmentRepositoryProvider._();

final class AssignmentRepositoryProvider
    extends
        $FunctionalProvider<
          FamilyMedicationRepositoryRemote,
          FamilyMedicationRepositoryRemote,
          FamilyMedicationRepositoryRemote
        >
    with $Provider<FamilyMedicationRepositoryRemote> {
  AssignmentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assignmentRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assignmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<FamilyMedicationRepositoryRemote> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FamilyMedicationRepositoryRemote create(Ref ref) {
    return assignmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FamilyMedicationRepositoryRemote value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FamilyMedicationRepositoryRemote>(
        value,
      ),
    );
  }
}

String _$assignmentRepositoryHash() =>
    r'95aae3fcb2349d23dad10ce8dad5c14cdfb9cf71';

@ProviderFor(assignmentChanged)
final assignmentChangedProvider = AssignmentChangedProvider._();

final class AssignmentChangedProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  AssignmentChangedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assignmentChangedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assignmentChangedHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return assignmentChanged(ref);
  }
}

String _$assignmentChangedHash() => r'ad5e434617e77a53da6dc6befa3b28b24e855deb';

@ProviderFor(Assignments)
final assignmentsProvider = AssignmentsProvider._();

final class AssignmentsProvider
    extends $AsyncNotifierProvider<Assignments, MemberAssignments> {
  AssignmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assignmentsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assignmentsHash();

  @$internal
  @override
  Assignments create() => Assignments();
}

String _$assignmentsHash() => r'e9470cd25e13cad583f87362a85b07f9988e56a6';

abstract class _$Assignments extends $AsyncNotifier<MemberAssignments> {
  FutureOr<MemberAssignments> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<MemberAssignments>, MemberAssignments>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MemberAssignments>, MemberAssignments>,
              AsyncValue<MemberAssignments>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
