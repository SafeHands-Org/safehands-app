import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/styles/app_theme.dart';
import "../../../models/medications/medication_service.dart";
import "../../../models/medications/medication_provider.dart";

class AddScheduleSheet extends StatefulWidget {
  final MemberMedication assignment;
  const AddScheduleSheet({required this.assignment});
  @override
  State<AddScheduleSheet> createState() => AddScheduleSheetState();
}

class AddScheduleSheetState extends State<AddScheduleSheet> {
  TimeOfDay _time = TimeOfDay.now();
  String _frequency = 'daily';
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Schedule for ${widget.assignment.nameEntered ?? 'Medication'}',
            style: AppTheme.subtitle),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            final t = await showTimePicker(
              context: context, initialTime: _time,
              builder: (ctx, child) => Theme(
                data: Theme.of(ctx).copyWith(
                    colorScheme: const ColorScheme.light(primary: AppTheme.primary)),
                child: child!,
              ),
            );
            if (t != null) setState(() => _time = t);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
                color: AppTheme.inputFill,
                borderRadius: BorderRadius.circular(18)),
            child: Row(children: [
              const Icon(Icons.access_time, color: AppTheme.primary, size: 18),
              const SizedBox(width: 10),
              Text('Time: ${_time.format(context)}', style: AppTheme.body),
            ]),
          ),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          value: _frequency,
          decoration: AppTheme.inputDecoration(hintText: 'Frequency'),
          items: ['daily', 'weekly', 'specific_days', 'as_needed']
              .map((f) => DropdownMenuItem(
                    value: f,
                    child: Text(f.replaceAll('_', ' ').toUpperCase()),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _frequency = v ?? _frequency),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saving ? null : _save,
            style: AppTheme.buttonStyle,
            child: _saving
                ? const SizedBox(width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Add Schedule', style: AppTheme.button),
          ),
        ),
      ]),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final hh = _time.hour.toString().padLeft(2, '0');
    final mm = _time.minute.toString().padLeft(2, '0');
    final ok = await context.read<MedicationProvider>().addSchedule(
      familyMemberMedicationId: widget.assignment.id,
      timeOfDay: '$hh:$mm',
      frequency: _frequency,
    );
    if (mounted) {
      setState(() => _saving = false);
      if (ok) Navigator.pop(context);
    }
  }
}