import 'package:frontend/models/models.dart';

typedef MemberAssignments = Map<String, List<FamilyMemberMedication>>;
typedef MemberSchedules = Map<String, List<MedicationSchedule>>;
typedef MemberLogs = Map<String, List<MedicationAdherenceLog>>;

typedef UserFamilies = Map<String, Family>;
typedef UserMedications = Map<String, Medication>;
typedef FamilyMemberships = Map<String, FamilyMember>;


typedef ScheduleOverviewInfo = (MemberSchedules, MemberAssignments, List<String>);