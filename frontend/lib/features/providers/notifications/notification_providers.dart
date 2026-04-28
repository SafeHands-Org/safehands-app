import 'dart:async';

import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/services/notification_service.dart';
import 'package:frontend/utils/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_providers.g.dart';

@riverpod
void medicationAlertAll(Ref ref) {
  final schedulesAsync = ref.watch(schedulesProvider);
  final assignmentsAsync = ref.watch(assignmentsProvider);
  final medicationsAsync = ref.watch(medicationsProvider);

  schedulesAsync.whenData((schedules) {
    assignmentsAsync.whenData((assignments) {
      medicationsAsync.whenData((medications) {
        final allSchedules = schedules.values.expand((list) => list).toList();
        _scheduleMedicationAlerts(ref, allSchedules, assignments, medications);
      });
    });
  });
}

@riverpod
void medicationAlertByFm(Ref ref, String fmId) {
  final schedulesAsync = ref.watch(schedulesProvider);
  final assignmentsAsync = ref.watch(assignmentsProvider);
  final medicationsAsync = ref.watch(medicationsProvider);

  schedulesAsync.whenData((schedules) {
    assignmentsAsync.whenData((assignments) {
      medicationsAsync.whenData((medications) {
        final fmSchedules = schedules[fmId] ?? [];
        _scheduleMedicationAlerts(ref, fmSchedules, assignments, medications);
      });
    });
  });
}

void _scheduleMedicationAlerts(
  Ref ref,
  List<MedicationSchedule> schedules,
  MemberAssignments assignments,
  UserMedications medications,
) {
  if (schedules.isEmpty) return;

  final now = DateTime.now();

  for (final schedule in schedules) {
    final nextDose = schedule.nextDoseTime;
    final delay = nextDose.difference(now);
    if (delay.isNegative) continue;

    final fmAssignments = assignments[schedule.fmid] ?? [];
    final assignment = fmAssignments.cast<FamilyMemberMedication?>().firstWhere(
      (a) => a?.id == schedule.fmmid,
      orElse: () => null,
    );
    final medication = assignment != null ? medications[assignment.medicationId] : null;
    final medName = medication?.names.firstOrNull ?? 'Your medication';
    final dosage = medication?.dosage ?? '';
    final body = dosage.isNotEmpty ? '$medName — $dosage' : medName;

    final timer = Timer(delay, () {
      NotificationService.sendNotification(
        notificationId: schedule.id.hashCode,
        title: 'Medication Reminder',
        body: body,
        scheduleTime: nextDose,
        groupKey: schedule.fmid,
      );
    });

    ref.onDispose(timer.cancel);
  }
}