
import 'package:dart_mappable/dart_mappable.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/utils.dart';

part 'collections.mapper.dart';

@MappableClass()
class Assignment with AssignmentMappable {
  final FamilyMember member;
  final FamilyMemberMedication assignment;
  final Medication reference;
  final MedicationSchedule schedule;
  final List<MedicationAdherenceLog> logs;

  const Assignment(
    this.member,
    this.assignment,
    this.reference,
    this.schedule,
    this.logs,
  );

  String get medicationName => reference.names.first;
}

@MappableClass()
class Member with MemberMappable {
  final FamilyMember member;
  final Family family;
  final List<Assignment> assignments;

  const Member(this.member, this.family, this.assignments);

  List<MedicationAdherenceLog> get logs  => [...assignments.map((a) => a.logs).first];
  List<FamilyMemberMedication> get fmms  => assignments.map((a) => a.assignment).toList();
  List<Medication> get medications       => assignments.map((a) => a.reference).toList();
  List<MedicationSchedule> get schedules => assignments.map((a) => a.schedule).toList();

  String status (String fmmid) {
    final existingLogs = todaysLogs.where((log) => log.fmmid == fmmid).isNotEmpty;
    if (existingLogs) return todaysLogs.where((log) => log.fmmid == fmmid).first.status;
    return 'upcoming';
  }

  List<MedicationAdherenceLog> get todaysLogs {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return logs.where((log) {
      final dt = DateTime.tryParse('$today ${log.scheduledTime}:00');
      return dt != null;
    }).toList();
  }

  String get timeUntilNextDose {
    final diff = nextDoseTime.difference(DateTime.now());

    if (diff.inHours < 24) {
      final hours = diff.inHours;
      final minutes = diff.inMinutes % 60;
      if (hours == 0) return '${minutes}m';
      if (minutes == 0) return '${hours}h';
      return '${hours}h ${minutes}m';
    } else {
      return '${diff.inDays}d';
    }
  }

  int get adherencePercentage {
    if (logs.isEmpty) return 0;
    final taken = logs.where((log) => log.taken).length;
    return ((taken / logs.length) * 100).round();
  }

  DateTime get nextDoseTime  => schedules.map((s) => s.nextDoseTime).reduce((a, b) => a.isBefore(b) ? a : b);
  Duration get membershipAge => DateTime.now().difference(member.createdAt);

  int get todaysDoseCount     => schedules.where((schedule) => schedule.isScheduledToday).length;
  int get todayTakenCount    => todaysLogs.where((log) => log.taken).length;
  int get todayMissedCount   => todaysLogs.where((log) => log.isPastDueMissed).length;
  int get activeMedCount     => fmms.where((assignment) => assignment.active == true).length;

  String get riskLevel       => member.risklevel;
  String get joinDate        => formatDate(member.createdAt);
  String get adherenceLabel  => adherenceStatus.label;
  String get name            => member.name;
  String get id              => member.id;

  bool get isAdmin           => member.isAdmin;

  AdherenceStatus get adherenceStatus => AdherenceStatus.fromMissedCount(todayMissedCount);
}

@MappableClass()
class FamilyCollection with FamilyCollectionMappable{
  final Family family;
  final List<FamilyMember> members;
  final List<FamilyMemberMedication> assignments;
  final List<Medication> medications;
  final List<MedicationAdherenceLog> logs;
  final List<MedicationSchedule> schedules;

  const FamilyCollection(
    this.family,
    this.members,
    this.assignments,
    this.medications,
    this.logs,
    this.schedules,
  );

  List<MedicationAdherenceLog> get todayLogs {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return logs.where((log) {
      final dt = DateTime.tryParse('$today ${log.scheduledTime}:00');
      return dt != null;
    }).toList();
  }

  int get adherencePercentage {
    if (logs.isEmpty) return 0;
    final taken = logs.where((log) => log.taken).length;
    return ((taken / logs.length) * 100).round();
  }

  int get activeMeds => assignments.where((a) => a.active == true).length;
  int get completedDoses => todayLogs.where((log) => log.taken).length;
  int get totalMembers => members.length;
}

