import 'package:dart_mappable/dart_mappable.dart';

part 'member_medication_request.mapper.dart';

@MappableClass()
class MemberMedicationRequest with MemberMedicationRequestMappable {
  final String priority;
  final DateTime startDate;
  final DateTime? endDate;
  final bool active;

  const MemberMedicationRequest({
    required this.priority,
    required this.startDate,
    this.endDate,
    required this.active,
  });
}