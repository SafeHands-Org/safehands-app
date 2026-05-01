import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class EditMedicationView extends ConsumerStatefulWidget {
  const EditMedicationView({super.key, required this.medication});

  final Medication medication;

  @override
  ConsumerState<EditMedicationView> createState() => _EditMedicationViewState();
}

class _EditMedicationViewState extends ConsumerState<EditMedicationView> {
  late final TextEditingController _doseFormController;
  late final TextEditingController _doseStrengthController;
  late final TextEditingController _instructionsController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _doseFormController = TextEditingController(text: widget.medication.doseForm);
    _doseStrengthController = TextEditingController(text: widget.medication.dosage);
    _instructionsController = TextEditingController(text: widget.medication.instructions);

    ref.listenManual(medicationsProvider, (previous, next) {
      if (previous is! AsyncLoading) return;
      next.whenOrNull(
        data: (_) {
          if (!mounted) return;
          ref.invalidate(aggregateMembershipsProvider);
          ref.invalidate(aggregateMemberProvider);
        },
        error: (error, stackTrace) {
          if (!mounted) return;
          final message = switch (error) {
            ServerException() => 'Request timed out. Try again.',
            _ => 'Something went wrong. Please try again.',
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: const Color(0xFFB62320)),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _doseFormController.dispose();
    _doseStrengthController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _delete() async {
    await ref.read(medicationsProvider.notifier).deleteMedication(widget.medication.id);
    ref.invalidate(aggregateMembershipsProvider);
    ref.invalidate(aggregateMemberProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted Medication'), duration: Duration(milliseconds: 800)),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      context.go('/medications');
    });
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(medicationsProvider.notifier).updateMedication(
        widget.medication.id,
        MedicationUpdate(
          id: widget.medication.id,
          dosage: _doseStrengthController.text.trim(),
          doseForm: _doseFormController.text.trim(),
          instructions: _instructionsController.text.trim(),
        ),
      );
      ref.invalidate(aggregateMembershipsProvider);
      ref.invalidate(aggregateMemberProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Updated Medication'), duration: Duration(milliseconds: 800)),
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        context.go('/medications');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.canPop() ? context.pop() : context.go('/medications'),
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'Update Medication',
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
            child:  Column(
              children: [
                FormSection(
                  title: 'Dose Form',
                  child: OptionalFormField(
                    controller: _doseFormController,
                    hintText: 'Choose or enter a dose form',
                    options: const [
                      'Tablet', 'Capsule', 'Injection', 'Cream',
                      'Ointment', 'Gel', 'Patch', 'Solution',
                      'Suspension', 'Drops',
                    ],
                  ),
                ),
                FormSection(
                  title: 'Dose Strength',
                  child: TextFormField(
                    controller: _doseStrengthController,
                    decoration: formFieldDecoration(context: context, hintText: 'Enter the dose strength'),
                  ),
                ),
                FormSection(
                  title: 'Instructions',
                  child: TextFormField(
                    controller: _instructionsController,
                    maxLines: 4,
                    decoration: formFieldDecoration(context: context, hintText: 'Medication instructions'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter instructions' : null,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: FormButton(
                    label: 'Confirm',
                    weight: FontWeight.w500,
                    radius: AppRadius.borderRadiusXl,
                    onPressed: _update,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: FormButton(
                    label: 'Remove Medication',
                    onPressed: () => _showDialog(context),
                    weight: FontWeight.w500,
                    radius: AppRadius.borderRadiusXl,
                    buttonColor: cs.errorContainer,
                    borderColor: cs.error,
                    textColor: cs.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Are you sure?'),
          actions: [
            CupertinoDialogAction(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            CupertinoDialogAction(onPressed: () => _delete(), child: const Text('Confirm')),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Are you sure?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            TextButton(onPressed: () => _delete(), child: const Text('Confirm')),
          ],
        ),
      );
    }
  }
}