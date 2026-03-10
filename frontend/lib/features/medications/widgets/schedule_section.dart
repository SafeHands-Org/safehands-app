import 'package:flutter/material.dart';
import 'package:frontend/features/medications/widgets/add_schedule_sheet.dart';
import 'package:provider/provider.dart';
import 'package:frontend/styles/app_theme.dart';
import "../../../models/medications/medication_service.dart";
import "../../../models/medications/medication_provider.dart";

class SchedulesTab extends StatelessWidget {
  final String memberId;
  const SchedulesTab({required this.memberId});

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(builder: (_, p, _) {
      final active = p.forMember(memberId).where((m) => m.active).toList();
      if (active.isEmpty) {
        return const Center(
            child: Text('Add medications first to manage schedules.'));
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: active.length,
        itemBuilder: (_, i) => _ScheduleSection(assignment: active[i]),
      );
    });
  }
}

class _ScheduleSection extends StatefulWidget {
  final MemberMedication assignment;
  const _ScheduleSection({required this.assignment});
  @override
  State<_ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<_ScheduleSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<MedicationProvider>().loadSchedules(widget.assignment.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(builder: (_, p, _) {
      final schedules = p.schedulesFor(widget.assignment.id);
      return Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const SizedBox(width: 8),
              Expanded(child: Text(widget.assignment.nameEntered ?? 'Medication',
                  style: AppTheme.body.copyWith(fontWeight: FontWeight.bold))),
              TextButton.icon(
                onPressed: () => _showAddSheet(context),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add'),
              ),
            ]),
            if (schedules.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('No schedules yet',
                    style: AppTheme.body.copyWith(color: Colors.grey)),
              )
            else
              ...schedules.map((s) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.access_time, color: AppTheme.primary),
                title: Text(s.displayTime, style: AppTheme.body),
                subtitle: Text(
                  '${s.frequency.replaceAll('_', ' ')}${s.daysOfWeek != null ? ' · ${s.daysOfWeek}' : ''}',
                  style: AppTheme.body.copyWith(color: Colors.grey, fontSize: 12),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                  onPressed: () =>
                      p.removeSchedule(s.id, widget.assignment.id),
                ),
              )),
          ]),
        ),
      );
    });
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => AddScheduleSheet(assignment: widget.assignment),
    );
  }
}