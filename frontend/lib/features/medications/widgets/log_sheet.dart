import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/medication_controller.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/services/medication_service.dart';
import 'package:provider/provider.dart';

class LogSheet extends StatefulWidget {
  final MemberMedication assignment;
  final String currentUserId;
  const LogSheet({super.key, required this.assignment, required this.currentUserId});
  @override
  State<LogSheet> createState() => LogSheetState();
}

class LogSheetState extends State<LogSheet> {
  String _status = 'taken';
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Log: ${widget.assignment.nameEntered ?? 'Medication'}',
            style: AppTheme.subtitle),
        const SizedBox(height: 16),
        Row(
          children: ['taken', 'missed', 'skipped'].map((s) {
            final selected = _status == s;
            final color = s == 'taken'
                ? Colors.green
                : s == 'missed'
                    ? Colors.red
                    : Colors.orange;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () => setState(() => _status = s),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selected ? color : color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: color.withValues(alpha: selected ? 1 : 0.3)),
                    ),
                    child: Center(
                      child: Text(
                        s[0].toUpperCase() + s.substring(1),
                        style: TextStyle(
                          color: selected ? Colors.white : color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saving ? null : _log,
            style: AppTheme.buttonStyle,
            child: _saving
                ? const SizedBox(width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Save Log', style: AppTheme.button),
          ),
        ),
      ]),
    );
  }

  Future<void> _log() async {
    setState(() => _saving = true);
    final now = DateTime.now().toUtc().toIso8601String();
    final ok = await context.read<MedicationController>().logAdherence(
      familyMemberMedicationId: widget.assignment.id,
      scheduledTime: now,
      status: _status,
      recordedBy: widget.currentUserId,
      takenAt: _status == 'taken' ? now : null,
    );
    if (mounted) {
      setState(() => _saving = false);
      if (ok) Navigator.pop(context);
    }
  }
}