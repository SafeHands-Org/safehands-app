// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scheduleRepository)
final scheduleRepositoryProvider = ScheduleRepositoryProvider._();

final class ScheduleRepositoryProvider
    extends
        $FunctionalProvider<
          ScheduleRepositoryRemote,
          ScheduleRepositoryRemote,
          ScheduleRepositoryRemote
        >
    with $Provider<ScheduleRepositoryRemote> {
  ScheduleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleRepositoryHash();

  @$internal
  @override
  $ProviderElement<ScheduleRepositoryRemote> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScheduleRepositoryRemote create(Ref ref) {
    return scheduleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScheduleRepositoryRemote value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScheduleRepositoryRemote>(value),
    );
  }
}

String _$scheduleRepositoryHash() =>
    r'68e4407f18d061418de9799c75976ffcf92a28e4';

@ProviderFor(scheduleChanged)
final scheduleChangedProvider = ScheduleChangedProvider._();

final class ScheduleChangedProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  ScheduleChangedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleChangedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleChangedHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return scheduleChanged(ref);
  }
}

String _$scheduleChangedHash() => r'65f0f15ef52229dfc6141c4e0a79557bd795da9e';

@ProviderFor(Schedules)
final schedulesProvider = SchedulesProvider._();

final class SchedulesProvider
    extends $AsyncNotifierProvider<Schedules, MemberSchedules> {
  SchedulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'schedulesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$schedulesHash();

  @$internal
  @override
  Schedules create() => Schedules();
}

String _$schedulesHash() => r'3ad61c563559a31ef3eb695d05bbab8b7d06740a';

abstract class _$Schedules extends $AsyncNotifier<MemberSchedules> {
  FutureOr<MemberSchedules> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MemberSchedules>, MemberSchedules>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MemberSchedules>, MemberSchedules>,
              AsyncValue<MemberSchedules>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
