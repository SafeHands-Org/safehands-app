import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/medication/medication_providers.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:go_router/go_router.dart';

class MedicationFormView extends ConsumerStatefulWidget {
  const MedicationFormView({super.key});

  @override
  ConsumerState<MedicationFormView> createState() => _MedicationFormState();
}

class _MedicationFormState extends ConsumerState<MedicationFormView> {
  final _formKey = GlobalKey<FormState>();
  final _rxcuiController = TextEditingController();
  final _instructionsController = TextEditingController();

  List<String>? _names;
  String? _selectedDosage;
  String? _selectedDoseForm;

  static const _dosageOptions = [
    '2.5 mg', '5 mg', '10 mg', '20 mg', '25 mg', '50 mg',
    '75 mg', '100 mg', '150 mg', '200 mg', '250 mg', '500 mg',
    '750 mg', '1000 mg', '2000 IU', '5000 IU', '1 ml', '5 ml', '10 ml',
  ];

  static const _doseFormOptions = [
    'tablet', 'capsule', 'liquid', 'inhaler', 'injection',
    'topical', 'drops', 'patch', 'suppository', 'other',
  ];

  @override
  void dispose() {
    _rxcuiController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDosage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Select a role')),
        );
        return;
      }

      if (_selectedDoseForm == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Select a role')),
        );
        return;
      }

      try {
        await ref.read(medicationsProvider.notifier).createMedication(
          MedicationRequest(
            names: _names!,
            rxcui: _rxcuiController.text.trim(),
            dosage: _selectedDosage!,
            doseForm: _selectedDoseForm!.trim(),
            instructions: _instructionsController.text.trim()
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Medication "$_names" saved',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            backgroundColor: context.palette.statusUpToDate,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        context.pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormSection(
                title: 'Medication Name',
                child: TextFormField(
                  controller: _rxcuiController,
                  textCapitalization: TextCapitalization.words,
                  decoration: formFieldDecoration(
                    context: context,
                    hintText: 'Search medication name…',
                    prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
                    suffixIcon: _rxcuiController.text.isNotEmpty ? IconButton(icon: Icon(Icons.close, color: cs.onSurfaceVariant, size: 18),
                    onPressed: () => setState(() => _rxcuiController.clear())) : null,
                  ),
                  onChanged: (_) => setState(() {}),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Medication name is required' : null,
                ),
              ),
              const SizedBox(height: 16),

              FormSection(
                title: 'Dosage',
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedDosage,
                  decoration: formFieldDecoration(
                    hintText: 'Select dosage',
                    prefixIcon: Icon(Icons.scale_outlined, color: cs.onSurfaceVariant, size: 20),
                    context: context
                  ),
                  items: _dosageOptions.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                  onChanged: (v) => setState(() => _selectedDosage = v),
                  validator: (v) => v == null ? 'Please select a dosage' : null,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: 16),

              FormSection(
                title: 'Dose Form',
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedDoseForm,
                  decoration: formFieldDecoration(
                    hintText: 'Select dose form',
                    prefixIcon: Icon(
                      Icons.medication_outlined,
                      color: cs.onSurfaceVariant, size: 20,
                    ),
                    context: context
                  ),
                  items: _doseFormOptions.map((f) {
                    final icon = _doseFormIcon(f);
                    return DropdownMenuItem(
                      value: f,
                      child: Row(
                        children: [
                          Icon(icon, size: 18, color: cs.onSurfaceVariant),
                          const SizedBox(width: 10),
                          Text(_capitalize(f)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedDoseForm = v),
                  validator: (v) => v == null ? 'Please select a dose form' : null,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: 16),

              FormSection(
                title: 'Instructions (optional)',
                child: TextFormField(
                  controller: _instructionsController,
                  decoration: formFieldDecoration(
                    hintText: 'e.g. Take with food, avoid alcohol…',
                    context: context
                  ),
                  maxLines: 4,
                  minLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              const SizedBox(height: 32),

              _GradientButton(
                label: 'Save Medication',
                icon: Icons.check,
                onPressed: _save,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(color: cs.onSurfaceVariant)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _doseFormIcon(String form) => switch (form) {
    'tablet'       => Icons.circle_outlined,
    'capsule'      => Icons.medication_outlined,
    'liquid'       => Icons.water_drop_outlined,
    'inhaler'      => Icons.air,
    'injection'    => Icons.vaccines_outlined,
    'topical'      => Icons.back_hand_outlined,
    'drops'        => Icons.opacity,
    'patch'        => Icons.square_outlined,
    'suppository'  => Icons.fiber_manual_record_outlined,
    _              => Icons.more_horiz,
  };

  static String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

}


class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: palette.header,
          borderRadius: AppRadius.borderRadiusCard,
          boxShadow: [
            BoxShadow(
              color: cs.primary.withValues(alpha: 0.3),
              blurRadius: 12, offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white, fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}