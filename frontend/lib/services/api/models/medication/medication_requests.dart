import 'package:dart_mappable/dart_mappable.dart';

part 'medication_requests.mapper.dart';

@MappableClass()
class MedicationRequest with MedicationRequestMappable {
  final List<String> names;
  final String? rxcui;
  final String dosage;
  final String doseForm;
  final String instructions;

  const MedicationRequest({
    required this.names,
    this.rxcui,
    required this.dosage,
    required this.doseForm,
    required this.instructions,
  });
}

@MappableClass()
class MedicationUpdate with MedicationUpdateMappable {
  final String? id;
  final String? dosage;
  final String? doseForm;
  final String? instructions;

  const MedicationUpdate({
    this.id,
    this.dosage,
    this.doseForm,
    this.instructions,
  });
}

@MappableClass()
class MemberMedicationRequest with MemberMedicationRequestMappable {
  final String medicationId;
  final String familyMemberId;
  final String priority;
  final int quantity;
  final bool active;

  const MemberMedicationRequest({
    required this.medicationId,
    required this.familyMemberId,
    required this.priority,
    required this.quantity,
    required this.active,
  });
}

@MappableClass()
class MemberMedicationUpdate with MemberMedicationUpdateMappable {
  final String? id;
  final String? priority;
  final int? quantity;
  final bool? active;

  const MemberMedicationUpdate({
    this.id,
    this.priority,
    this.quantity,
    this.active,
  });
}

@MappableClass()
class ScheduleRequest with ScheduleRequestMappable {
  final String familyMemberMedicationId;
  final List<String> timesOfDay;
  final List<String>? daysOfWeek;
  final int frequency;

  const ScheduleRequest({
    required this.familyMemberMedicationId,
    required this.timesOfDay,
    this.daysOfWeek,
    required this.frequency,
  });
}

@MappableClass()
class ScheduleUpdate with ScheduleUpdateMappable {
  final String? id;
  final List<String>? timesOfDay;
  final List<String>? daysOfWeek;
  final int? frequency;

  const ScheduleUpdate({
    this.id,
    this.timesOfDay,
    this.daysOfWeek,
    this.frequency,
  });
}

@MappableClass()
class AdherenceLogRequest with AdherenceLogRequestMappable {
  final String familyMemberMedicationId;
  final String scheduledTime;
  final DateTime? takenAt;
  final String status;
  final String recordedBy;

  const AdherenceLogRequest({
    required this.familyMemberMedicationId,
    required this.scheduledTime,
    this.takenAt,
    required this.status,
    required this.recordedBy,
  });
}

@MappableClass()
class AdherenceLogUpdate with AdherenceLogUpdateMappable {
  final String? id;
  final DateTime? takenAt;
  final String? status;
  final String? recordedBy;

  const AdherenceLogUpdate({
    this.id,
    this.takenAt,
    this.status,
    this.recordedBy,
  });
}