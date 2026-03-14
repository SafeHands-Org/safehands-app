import 'package:flutter/material.dart';
import 'package:frontend/controllers/medication_controller.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/services/medication_service.dart';
import 'package:provider/provider.dart';

const _doseForms = [
  'tablet', 'capsule', 'liquid', 'inhaler', 'injection',
  'topical', 'drops', 'patch', 'suppository', 'other',
];

class MedicationForm extends StatefulWidget {
  final Medication? medication;
  const MedicationForm({super.key, this.medication});

  @override
  State<MedicationForm> createState() => _MedicationFormState();
}

class _MedicationFormState extends State<MedicationForm> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _dosage;
  late final TextEditingController _instructions;
  late String _doseForm;
  bool _saving = false;

  bool get _isEdit => widget.medication != null;

  @override
  void initState() {
    super.initState();
    _name         = TextEditingController(text: widget.medication?.nameEntered ?? '');
    _dosage       = TextEditingController(text: widget.medication?.dosage ?? '');
    _instructions = TextEditingController(text: widget.medication?.instructions ?? '');
    _doseForm     = widget.medication?.doseForm ?? 'tablet';
  }

  @override
  void dispose() {
    _name.dispose(); _dosage.dispose(); _instructions.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_key.currentState!.validate()) return;
    setState(() => _saving = true);
    final p = context.read<MedicationController>();

    final ok = _isEdit
        ? await p.updateMed(widget.medication!.id,
            nameEntered:  _name.text.trim(),
            doseForm:     _doseForm,
            dosage:       _dosage.text.trim().isEmpty ? null : _dosage.text.trim(),
            instructions: _instructions.text.trim().isEmpty ? null : _instructions.text.trim(),
          )
        : await p.createMed(
            nameEntered:  _name.text.trim(),
            doseForm:     _doseForm,
            dosage:       _dosage.text.trim().isEmpty ? null : _dosage.text.trim(),
            instructions: _instructions.text.trim().isEmpty ? null : _instructions.text.trim(),
          );

    if (mounted) {
      setState(() => _saving = false);
      if (ok) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(p.error ?? 'Failed to save'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Medication' : 'Add Medication',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: AppTheme.inputDecoration(hintText: 'Medication name *', icon: Icons.medication_outlined),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _doseForm,
              decoration: AppTheme.inputDecoration(hintText: 'Dose form'),
              items: _doseForms.map((f) => DropdownMenuItem(
                value: f,
                child: Text(f[0].toUpperCase() + f.substring(1)),
              )).toList(),
              onChanged: (v) => setState(() => _doseForm = v ?? _doseForm),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dosage,
              decoration: AppTheme.inputDecoration(hintText: 'Dosage (e.g. 500mg)', icon: Icons.scale_outlined),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _instructions,
              maxLines: 3,
              decoration: AppTheme.inputDecoration(hintText: 'Instructions (optional)', icon: Icons.info_outline),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: AppTheme.buttonStyle,
                child: _saving
                    ? const SizedBox(width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(_isEdit ? 'Save Changes' : 'Add Medication', style: AppTheme.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}