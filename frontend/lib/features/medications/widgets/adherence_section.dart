import 'package:flutter/material.dart';
import 'package:frontend/features/medications/widgets/log_sheet.dart';
import 'package:provider/provider.dart';
import 'package:frontend/styles/app_theme.dart';
import "../../../models/medications/medication_service.dart";
import "../../../models/medications/medication_provider.dart";

class AdherenceTab extends StatelessWidget {
  final String memberId;
  final String currentUserId;
  const AdherenceTab({required this.memberId, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(builder: (_, p, _) {
      final active = p.forMember(memberId).where((m) => m.active).toList();
      if (active.isEmpty) {
        return const Center(
            child: Text('Add medications first to log adherence.'));
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: active.length,
        itemBuilder: (_, i) => _AdherenceSection(
          assignment: active[i],
          currentUserId: currentUserId,
        ),
      );
    });
  }
}

class _AdherenceSection extends StatefulWidget {
  final MemberMedication assignment;
  final String currentUserId;
  const _AdherenceSection(
      {required this.assignment, required this.currentUserId});
  @override
  State<_AdherenceSection> createState() => _AdherenceSectionState();
}

class _AdherenceSectionState extends State<_AdherenceSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<MedicationProvider>().loadLogs(widget.assignment.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(builder: (_, p, _) {
      final logs = p.logsFor(widget.assignment.id);
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
                onPressed: () => _showLogSheet(context),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Log'),
              ),
            ]),
            if (logs.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('No logs yet',
                    style: AppTheme.body.copyWith(color: Colors.grey)),
              )
            else
              ...logs.take(5).map((l) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(_statusIcon(l.status),
                    color: _statusColor(l.status)),
                title: Text(
                  l.status[0].toUpperCase() + l.status.substring(1),
                  style: AppTheme.body.copyWith(color: _statusColor(l.status)),
                ),
                subtitle: Text(_fmtTs(l.scheduledTime),
                    style: AppTheme.body
                        .copyWith(color: Colors.grey, fontSize: 12)),
              )),
          ]),
        ),
      );
    });
  }

  IconData _statusIcon(String s) => s == 'taken'
      ? Icons.check_circle_outline
      : s == 'missed'
          ? Icons.cancel_outlined
          : Icons.remove_circle_outline;

  Color _statusColor(String s) =>
      s == 'taken' ? Colors.green : s == 'missed' ? Colors.red : Colors.orange;

  String _fmtTs(String ts) {
    try {
      final d = DateTime.parse(ts).toLocal();
      return '${d.day}/${d.month}/${d.year} '
          '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return ts;
    }
  }

  void _showLogSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => LogSheet(
        assignment: widget.assignment,
        currentUserId: widget.currentUserId,
      ),
    );
  }
}