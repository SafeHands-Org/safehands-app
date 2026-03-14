import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/medication_controller.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/services/medication_service.dart';
import 'package:frontend/services/rxnorm_service.dart';

class AddMedicationSheet extends StatefulWidget {
  final String memberId;
  final String currentUserId;
  final MedicationController controller;
  const AddMedicationSheet({super.key, 
    required this.memberId,
    required this.currentUserId,
    required this.controller,
  });

  @override
  State<AddMedicationSheet> createState() => AddMedicationSheetState();
}

class AddMedicationSheetState extends State<AddMedicationSheet> {
  final _nameCtrl    = TextEditingController();
  final _dosageCtrl  = TextEditingController();
  String _doseForm   = 'tablet';
  String? _rxcui;

  List<RxSuggestion> _suggestions = [];
  bool _searching  = false;
  bool _saving     = false;
  Timer? _debounce;

  DateTime _startDate = DateTime.now();

  final _doseForms = const [
    'tablet','capsule','liquid','inhaler','injection',
    'topical','drops','patch','suppository','other',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _dosageCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onNameChanged(String v) {
    _rxcui = null;
    _debounce?.cancel();
    if (v.trim().length < 2) {
      setState(() => _suggestions = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      setState(() => _searching = true);
      final results = await rxNormSearch(v);
      if (mounted) setState(() { _suggestions = results; _searching = false; });
    });
  }

  void _selectSuggestion(RxSuggestion s) {
    _nameCtrl.text = s.name;
    _rxcui = s.rxcui;
    setState(() => _suggestions = []);
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);

    final start =
        '${_startDate.year}-${_startDate.month.toString().padLeft(2,'0')}-${_startDate.day.toString().padLeft(2,'0')}';

    try {
      final med = await createMedication(
        nameEntered: _nameCtrl.text.trim(),
        doseForm: _doseForm,
        dosage: _dosageCtrl.text.trim().isEmpty ? null : _dosageCtrl.text.trim(),
        rxcui: _rxcui,
      );

      final ok = await widget.controller.assign(
        medicationId: med.id,
        familyMemberId: widget.memberId,
        startDate: start,
      );

      if (mounted) {
        setState(() => _saving = false);
        if (ok) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(widget.controller.error ?? 'Failed to assign'),
            backgroundColor: Colors.red,
          ));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e is ApiError ? e.message : 'Failed to save medication'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20,
          MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Expanded(
              child: Text('Add Medication',
                  style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold)),
            ),
            IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context)),
          ]),
          const SizedBox(height: 16),

          TextFormField(
            controller: _nameCtrl,
            onChanged: _onNameChanged,
            textCapitalization: TextCapitalization.words,
            decoration: AppTheme.inputDecoration(
              hintText: 'Medication name *',
              icon: Icons.medication_outlined,
              suffixIcon: _searching
                  ? Padding(padding: const EdgeInsets.all(12),
                      child: SizedBox(width: 16, height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primary)))
                  : null,
            ),
          ),

          if (_suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                children: _suggestions.map((s) => ListTile(
                  dense: true,
                  leading: Icon(Icons.medication_outlined,
                      color: AppTheme.primary, size: 18),
                  title: Text(s.name, style: AppTheme.body),
                  subtitle: Text('RxCUI: ${s.rxcui}',
                      style: AppTheme.body.copyWith(color: Colors.grey, fontSize: 11)),
                  onTap: () => _selectSuggestion(s),
                )).toList(),
              ),
            ),

          if (_rxcui != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(children: [
                const Icon(Icons.check_circle, size: 14, color: Colors.green),
                const SizedBox(width: 6),
                Text('RxNorm verified · RxCUI: $_rxcui',
                    style: AppTheme.body.copyWith(color: Colors.green, fontSize: 12)),
              ]),
            ),

          const SizedBox(height: 14),

          DropdownButtonFormField<String>(
            initialValue: _doseForm,
            decoration: AppTheme.inputDecoration(hintText: 'Dose form'),
            items: _doseForms.map((f) => DropdownMenuItem(
              value: f,
              child: Text(f[0].toUpperCase() + f.substring(1)),
            )).toList(),
            onChanged: (v) => setState(() => _doseForm = v ?? _doseForm),
          ),
          const SizedBox(height: 14),

          TextFormField(
            controller: _dosageCtrl,
            decoration: AppTheme.inputDecoration(
                hintText: 'Dosage (e.g. 500mg)', icon: Icons.scale_outlined),
          ),
          const SizedBox(height: 14),

          GestureDetector(
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime(2020), lastDate: DateTime(2100),
                builder: (ctx, child) => Theme(
                  data: Theme.of(ctx).copyWith(
                      colorScheme: ColorScheme.light(primary: AppTheme.primary)),
                  child: child!,
                ),
              );
              if (d != null) setState(() => _startDate = d);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                  color: AppTheme.inputFill,
                  borderRadius: BorderRadius.circular(18)),
              child: Row(children: [
                Icon(Icons.calendar_today, color: AppTheme.primary, size: 18),
                const SizedBox(width: 10),
                Text(
                  'Start: ${_startDate.year}-${_startDate.month.toString().padLeft(2,'0')}-${_startDate.day.toString().padLeft(2,'0')}',
                  style: AppTheme.body,
                ),
              ]),
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_saving || _nameCtrl.text.trim().isEmpty) ? null : _save,
              style: AppTheme.buttonStyle,
              child: _saving
                  ? const SizedBox(width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Add Medication', style: AppTheme.button),
            ),
          ),
        ]),
      ),
    );
  }
}