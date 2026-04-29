// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'collections.dart';

class AssignmentMapper extends ClassMapperBase<Assignment> {
  AssignmentMapper._();

  static AssignmentMapper? _instance;
  static AssignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignmentMapper._());
      FamilyMemberMapper.ensureInitialized();
      FamilyMemberMedicationMapper.ensureInitialized();
      MedicationMapper.ensureInitialized();
      MedicationScheduleMapper.ensureInitialized();
      MedicationAdherenceLogMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Assignment';

  static FamilyMember _$member(Assignment v) => v.member;
  static const Field<Assignment, FamilyMember> _f$member = Field(
    'member',
    _$member,
  );
  static FamilyMemberMedication _$assignment(Assignment v) => v.assignment;
  static const Field<Assignment, FamilyMemberMedication> _f$assignment = Field(
    'assignment',
    _$assignment,
  );
  static Medication _$reference(Assignment v) => v.reference;
  static const Field<Assignment, Medication> _f$reference = Field(
    'reference',
    _$reference,
  );
  static MedicationSchedule _$schedule(Assignment v) => v.schedule;
  static const Field<Assignment, MedicationSchedule> _f$schedule = Field(
    'schedule',
    _$schedule,
  );
  static List<MedicationAdherenceLog> _$logs(Assignment v) => v.logs;
  static const Field<Assignment, List<MedicationAdherenceLog>> _f$logs = Field(
    'logs',
    _$logs,
  );

  @override
  final MappableFields<Assignment> fields = const {
    #member: _f$member,
    #assignment: _f$assignment,
    #reference: _f$reference,
    #schedule: _f$schedule,
    #logs: _f$logs,
  };

  static Assignment _instantiate(DecodingData data) {
    return Assignment(
      data.dec(_f$member),
      data.dec(_f$assignment),
      data.dec(_f$reference),
      data.dec(_f$schedule),
      data.dec(_f$logs),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Assignment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Assignment>(map);
  }

  static Assignment fromJson(String json) {
    return ensureInitialized().decodeJson<Assignment>(json);
  }
}

mixin AssignmentMappable {
  String toJson() {
    return AssignmentMapper.ensureInitialized().encodeJson<Assignment>(
      this as Assignment,
    );
  }

  Map<String, dynamic> toMap() {
    return AssignmentMapper.ensureInitialized().encodeMap<Assignment>(
      this as Assignment,
    );
  }

  AssignmentCopyWith<Assignment, Assignment, Assignment> get copyWith =>
      _AssignmentCopyWithImpl<Assignment, Assignment>(
        this as Assignment,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssignmentMapper.ensureInitialized().stringifyValue(
      this as Assignment,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssignmentMapper.ensureInitialized().equalsValue(
      this as Assignment,
      other,
    );
  }

  @override
  int get hashCode {
    return AssignmentMapper.ensureInitialized().hashValue(this as Assignment);
  }
}

extension AssignmentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Assignment, $Out> {
  AssignmentCopyWith<$R, Assignment, $Out> get $asAssignment =>
      $base.as((v, t, t2) => _AssignmentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssignmentCopyWith<$R, $In extends Assignment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  FamilyMemberCopyWith<$R, FamilyMember, FamilyMember> get member;
  FamilyMemberMedicationCopyWith<
    $R,
    FamilyMemberMedication,
    FamilyMemberMedication
  >
  get assignment;
  MedicationCopyWith<$R, Medication, Medication> get reference;
  MedicationScheduleCopyWith<$R, MedicationSchedule, MedicationSchedule>
  get schedule;
  ListCopyWith<
    $R,
    MedicationAdherenceLog,
    MedicationAdherenceLogCopyWith<
      $R,
      MedicationAdherenceLog,
      MedicationAdherenceLog
    >
  >
  get logs;
  $R call({
    FamilyMember? member,
    FamilyMemberMedication? assignment,
    Medication? reference,
    MedicationSchedule? schedule,
    List<MedicationAdherenceLog>? logs,
  });
  AssignmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssignmentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Assignment, $Out>
    implements AssignmentCopyWith<$R, Assignment, $Out> {
  _AssignmentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Assignment> $mapper =
      AssignmentMapper.ensureInitialized();
  @override
  FamilyMemberCopyWith<$R, FamilyMember, FamilyMember> get member =>
      $value.member.copyWith.$chain((v) => call(member: v));
  @override
  FamilyMemberMedicationCopyWith<
    $R,
    FamilyMemberMedication,
    FamilyMemberMedication
  >
  get assignment =>
      $value.assignment.copyWith.$chain((v) => call(assignment: v));
  @override
  MedicationCopyWith<$R, Medication, Medication> get reference =>
      $value.reference.copyWith.$chain((v) => call(reference: v));
  @override
  MedicationScheduleCopyWith<$R, MedicationSchedule, MedicationSchedule>
  get schedule => $value.schedule.copyWith.$chain((v) => call(schedule: v));
  @override
  ListCopyWith<
    $R,
    MedicationAdherenceLog,
    MedicationAdherenceLogCopyWith<
      $R,
      MedicationAdherenceLog,
      MedicationAdherenceLog
    >
  >
  get logs => ListCopyWith(
    $value.logs,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(logs: v),
  );
  @override
  $R call({
    FamilyMember? member,
    FamilyMemberMedication? assignment,
    Medication? reference,
    MedicationSchedule? schedule,
    List<MedicationAdherenceLog>? logs,
  }) => $apply(
    FieldCopyWithData({
      if (member != null) #member: member,
      if (assignment != null) #assignment: assignment,
      if (reference != null) #reference: reference,
      if (schedule != null) #schedule: schedule,
      if (logs != null) #logs: logs,
    }),
  );
  @override
  Assignment $make(CopyWithData data) => Assignment(
    data.get(#member, or: $value.member),
    data.get(#assignment, or: $value.assignment),
    data.get(#reference, or: $value.reference),
    data.get(#schedule, or: $value.schedule),
    data.get(#logs, or: $value.logs),
  );

  @override
  AssignmentCopyWith<$R2, Assignment, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssignmentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MemberMapper extends ClassMapperBase<Member> {
  MemberMapper._();

  static MemberMapper? _instance;
  static MemberMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MemberMapper._());
      FamilyMemberMapper.ensureInitialized();
      FamilyMapper.ensureInitialized();
      AssignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Member';

  static FamilyMember _$member(Member v) => v.member;
  static const Field<Member, FamilyMember> _f$member = Field(
    'member',
    _$member,
  );
  static Family _$family(Member v) => v.family;
  static const Field<Member, Family> _f$family = Field('family', _$family);
  static List<Assignment> _$assignments(Member v) => v.assignments;
  static const Field<Member, List<Assignment>> _f$assignments = Field(
    'assignments',
    _$assignments,
  );

  @override
  final MappableFields<Member> fields = const {
    #member: _f$member,
    #family: _f$family,
    #assignments: _f$assignments,
  };

  static Member _instantiate(DecodingData data) {
    return Member(
      data.dec(_f$member),
      data.dec(_f$family),
      data.dec(_f$assignments),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Member fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Member>(map);
  }

  static Member fromJson(String json) {
    return ensureInitialized().decodeJson<Member>(json);
  }
}

mixin MemberMappable {
  String toJson() {
    return MemberMapper.ensureInitialized().encodeJson<Member>(this as Member);
  }

  Map<String, dynamic> toMap() {
    return MemberMapper.ensureInitialized().encodeMap<Member>(this as Member);
  }

  MemberCopyWith<Member, Member, Member> get copyWith =>
      _MemberCopyWithImpl<Member, Member>(this as Member, $identity, $identity);
  @override
  String toString() {
    return MemberMapper.ensureInitialized().stringifyValue(this as Member);
  }

  @override
  bool operator ==(Object other) {
    return MemberMapper.ensureInitialized().equalsValue(this as Member, other);
  }

  @override
  int get hashCode {
    return MemberMapper.ensureInitialized().hashValue(this as Member);
  }
}

extension MemberValueCopy<$R, $Out> on ObjectCopyWith<$R, Member, $Out> {
  MemberCopyWith<$R, Member, $Out> get $asMember =>
      $base.as((v, t, t2) => _MemberCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MemberCopyWith<$R, $In extends Member, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  FamilyMemberCopyWith<$R, FamilyMember, FamilyMember> get member;
  FamilyCopyWith<$R, Family, Family> get family;
  ListCopyWith<$R, Assignment, AssignmentCopyWith<$R, Assignment, Assignment>>
  get assignments;
  $R call({
    FamilyMember? member,
    Family? family,
    List<Assignment>? assignments,
  });
  MemberCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MemberCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Member, $Out>
    implements MemberCopyWith<$R, Member, $Out> {
  _MemberCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Member> $mapper = MemberMapper.ensureInitialized();
  @override
  FamilyMemberCopyWith<$R, FamilyMember, FamilyMember> get member =>
      $value.member.copyWith.$chain((v) => call(member: v));
  @override
  FamilyCopyWith<$R, Family, Family> get family =>
      $value.family.copyWith.$chain((v) => call(family: v));
  @override
  ListCopyWith<$R, Assignment, AssignmentCopyWith<$R, Assignment, Assignment>>
  get assignments => ListCopyWith(
    $value.assignments,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(assignments: v),
  );
  @override
  $R call({
    FamilyMember? member,
    Family? family,
    List<Assignment>? assignments,
  }) => $apply(
    FieldCopyWithData({
      if (member != null) #member: member,
      if (family != null) #family: family,
      if (assignments != null) #assignments: assignments,
    }),
  );
  @override
  Member $make(CopyWithData data) => Member(
    data.get(#member, or: $value.member),
    data.get(#family, or: $value.family),
    data.get(#assignments, or: $value.assignments),
  );

  @override
  MemberCopyWith<$R2, Member, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MemberCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FamilyCollectionMapper extends ClassMapperBase<FamilyCollection> {
  FamilyCollectionMapper._();

  static FamilyCollectionMapper? _instance;
  static FamilyCollectionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FamilyCollectionMapper._());
      FamilyMapper.ensureInitialized();
      FamilyMemberMapper.ensureInitialized();
      FamilyMemberMedicationMapper.ensureInitialized();
      MedicationMapper.ensureInitialized();
      MedicationAdherenceLogMapper.ensureInitialized();
      MedicationScheduleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FamilyCollection';

  static Family _$family(FamilyCollection v) => v.family;
  static const Field<FamilyCollection, Family> _f$family = Field(
    'family',
    _$family,
  );
  static List<FamilyMember> _$members(FamilyCollection v) => v.members;
  static const Field<FamilyCollection, List<FamilyMember>> _f$members = Field(
    'members',
    _$members,
  );
  static List<FamilyMemberMedication> _$assignments(FamilyCollection v) =>
      v.assignments;
  static const Field<FamilyCollection, List<FamilyMemberMedication>>
  _f$assignments = Field('assignments', _$assignments);
  static List<Medication> _$medications(FamilyCollection v) => v.medications;
  static const Field<FamilyCollection, List<Medication>> _f$medications = Field(
    'medications',
    _$medications,
  );
  static List<MedicationAdherenceLog> _$logs(FamilyCollection v) => v.logs;
  static const Field<FamilyCollection, List<MedicationAdherenceLog>> _f$logs =
      Field('logs', _$logs);
  static List<MedicationSchedule> _$schedules(FamilyCollection v) =>
      v.schedules;
  static const Field<FamilyCollection, List<MedicationSchedule>> _f$schedules =
      Field('schedules', _$schedules);

  @override
  final MappableFields<FamilyCollection> fields = const {
    #family: _f$family,
    #members: _f$members,
    #assignments: _f$assignments,
    #medications: _f$medications,
    #logs: _f$logs,
    #schedules: _f$schedules,
  };

  static FamilyCollection _instantiate(DecodingData data) {
    return FamilyCollection(
      data.dec(_f$family),
      data.dec(_f$members),
      data.dec(_f$assignments),
      data.dec(_f$medications),
      data.dec(_f$logs),
      data.dec(_f$schedules),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FamilyCollection fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FamilyCollection>(map);
  }

  static FamilyCollection fromJson(String json) {
    return ensureInitialized().decodeJson<FamilyCollection>(json);
  }
}

mixin FamilyCollectionMappable {
  String toJson() {
    return FamilyCollectionMapper.ensureInitialized()
        .encodeJson<FamilyCollection>(this as FamilyCollection);
  }

  Map<String, dynamic> toMap() {
    return FamilyCollectionMapper.ensureInitialized()
        .encodeMap<FamilyCollection>(this as FamilyCollection);
  }

  FamilyCollectionCopyWith<FamilyCollection, FamilyCollection, FamilyCollection>
  get copyWith =>
      _FamilyCollectionCopyWithImpl<FamilyCollection, FamilyCollection>(
        this as FamilyCollection,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FamilyCollectionMapper.ensureInitialized().stringifyValue(
      this as FamilyCollection,
    );
  }

  @override
  bool operator ==(Object other) {
    return FamilyCollectionMapper.ensureInitialized().equalsValue(
      this as FamilyCollection,
      other,
    );
  }

  @override
  int get hashCode {
    return FamilyCollectionMapper.ensureInitialized().hashValue(
      this as FamilyCollection,
    );
  }
}

extension FamilyCollectionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FamilyCollection, $Out> {
  FamilyCollectionCopyWith<$R, FamilyCollection, $Out>
  get $asFamilyCollection =>
      $base.as((v, t, t2) => _FamilyCollectionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FamilyCollectionCopyWith<$R, $In extends FamilyCollection, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  FamilyCopyWith<$R, Family, Family> get family;
  ListCopyWith<
    $R,
    FamilyMember,
    FamilyMemberCopyWith<$R, FamilyMember, FamilyMember>
  >
  get members;
  ListCopyWith<
    $R,
    FamilyMemberMedication,
    FamilyMemberMedicationCopyWith<
      $R,
      FamilyMemberMedication,
      FamilyMemberMedication
    >
  >
  get assignments;
  ListCopyWith<$R, Medication, MedicationCopyWith<$R, Medication, Medication>>
  get medications;
  ListCopyWith<
    $R,
    MedicationAdherenceLog,
    MedicationAdherenceLogCopyWith<
      $R,
      MedicationAdherenceLog,
      MedicationAdherenceLog
    >
  >
  get logs;
  ListCopyWith<
    $R,
    MedicationSchedule,
    MedicationScheduleCopyWith<$R, MedicationSchedule, MedicationSchedule>
  >
  get schedules;
  $R call({
    Family? family,
    List<FamilyMember>? members,
    List<FamilyMemberMedication>? assignments,
    List<Medication>? medications,
    List<MedicationAdherenceLog>? logs,
    List<MedicationSchedule>? schedules,
  });
  FamilyCollectionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FamilyCollectionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FamilyCollection, $Out>
    implements FamilyCollectionCopyWith<$R, FamilyCollection, $Out> {
  _FamilyCollectionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FamilyCollection> $mapper =
      FamilyCollectionMapper.ensureInitialized();
  @override
  FamilyCopyWith<$R, Family, Family> get family =>
      $value.family.copyWith.$chain((v) => call(family: v));
  @override
  ListCopyWith<
    $R,
    FamilyMember,
    FamilyMemberCopyWith<$R, FamilyMember, FamilyMember>
  >
  get members => ListCopyWith(
    $value.members,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(members: v),
  );
  @override
  ListCopyWith<
    $R,
    FamilyMemberMedication,
    FamilyMemberMedicationCopyWith<
      $R,
      FamilyMemberMedication,
      FamilyMemberMedication
    >
  >
  get assignments => ListCopyWith(
    $value.assignments,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(assignments: v),
  );
  @override
  ListCopyWith<$R, Medication, MedicationCopyWith<$R, Medication, Medication>>
  get medications => ListCopyWith(
    $value.medications,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(medications: v),
  );
  @override
  ListCopyWith<
    $R,
    MedicationAdherenceLog,
    MedicationAdherenceLogCopyWith<
      $R,
      MedicationAdherenceLog,
      MedicationAdherenceLog
    >
  >
  get logs => ListCopyWith(
    $value.logs,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(logs: v),
  );
  @override
  ListCopyWith<
    $R,
    MedicationSchedule,
    MedicationScheduleCopyWith<$R, MedicationSchedule, MedicationSchedule>
  >
  get schedules => ListCopyWith(
    $value.schedules,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(schedules: v),
  );
  @override
  $R call({
    Family? family,
    List<FamilyMember>? members,
    List<FamilyMemberMedication>? assignments,
    List<Medication>? medications,
    List<MedicationAdherenceLog>? logs,
    List<MedicationSchedule>? schedules,
  }) => $apply(
    FieldCopyWithData({
      if (family != null) #family: family,
      if (members != null) #members: members,
      if (assignments != null) #assignments: assignments,
      if (medications != null) #medications: medications,
      if (logs != null) #logs: logs,
      if (schedules != null) #schedules: schedules,
    }),
  );
  @override
  FamilyCollection $make(CopyWithData data) => FamilyCollection(
    data.get(#family, or: $value.family),
    data.get(#members, or: $value.members),
    data.get(#assignments, or: $value.assignments),
    data.get(#medications, or: $value.medications),
    data.get(#logs, or: $value.logs),
    data.get(#schedules, or: $value.schedules),
  );

  @override
  FamilyCollectionCopyWith<$R2, FamilyCollection, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FamilyCollectionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

