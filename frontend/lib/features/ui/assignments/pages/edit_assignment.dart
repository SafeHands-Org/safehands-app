import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/models/medications/family_member_medication.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class EditAssignmentView extends ConsumerStatefulWidget {
  const EditAssignmentView({super.key, required this.assignment});

  final FamilyMemberMedication assignment;

  @override
  ConsumerState<EditAssignmentView> createState() => _EditAssignmentViewState();
}

class _EditAssignmentViewState extends ConsumerState<EditAssignmentView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _quantityCtrl;
  String? _active;
  String? _selectedPriority;

  @override
  void initState() {
    super.initState();

    _quantityCtrl = TextEditingController(
      text: widget.assignment.quantity.toString(),
    );
    _active = widget.assignment.active ? 'Yes' : 'No';
    _selectedPriority = widget.assignment.priority;

    ref.listenManual(familiesProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (mounted) context.canPop() ? context.pop() : context.go('/family/members/${widget.assignment.familyMemberId}');
        },
        error: (error, stackTrace) {
          if (!mounted) return;
          final message = switch (error) {
            NotFoundException() => 'Assignment not found.',
            ServerException() => 'Request timed out. Try again.',
            _ => 'Something went wrong. Please try again.',
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Color(0xFFB62320),
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _quantityCtrl.dispose();
    super.dispose();
  }

  void _delete() async {
    await ref.read(assignmentsProvider.notifier)
    .deleteFamilyMedication(
      widget.assignment.familyMemberId,
      widget.assignment.medicationId,
    );
    context.go('/family/members/${widget.assignment.familyMemberId}');
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final quantity = _quantityCtrl.text.trim();
      final active = _active == 'Yes' ? true : false;
      await ref.read(assignmentsProvider.notifier)
      .updateFamilyMedication(
        widget.assignment.familyMemberId,
        MemberMedicationUpdate(
          id: widget.assignment.id,
          priority: _selectedPriority!.toLowerCase(),
          quantity: int.tryParse(quantity),
          active: active,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => {
            context.canPop() ? context.pop() : context.go('/family'),
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: context.palette.header),
        ),
        title: Text(
          'Assignment Details',
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      FormSection(
                        title: 'Priority',
                        child: EditableDropdownField(
                          value: _selectedPriority,
                          hintText: 'Select priority',
                          items: const ['Low', 'Medium', 'High'],
                          validator: (v) =>
                              v == null ? 'Please select a priority' : null,
                          onChanged: (v) {
                            setState(() => _selectedPriority = v);
                          },
                        ),
                      ),
                      FormSection(
                        title: 'Quantity',
                        child: EditableFormField(
                          ctrl: _quantityCtrl,
                          validators: (v) => v == null ? 'Please select a quantity' : null,
                          hintText: 'Enter a quantity'
                        )
                      ),
                      FormSection(
                        title: 'Active',
                        child: EditableDropdownField(
                          value: _active,
                          hintText: 'Make this medication active?',
                          items: const ['Yes', 'No'],
                          validator: (v) =>
                              v == null ? 'Please select an option' : null,
                          onChanged: (v) {
                            setState(() => _active = v);
                          },
                        ),
                      ),
                      const SizedBox(height: 50),
                      FormButton(
                        label: 'Update',
                        weight: FontWeight.w400,
                        radius: AppRadius.borderRadiusXl,
                        onPressed: _update,
                      ),
                      const SizedBox(height: 18),
                      FormButton(
                        label: 'Remove',
                        onPressed: () => {
                          if (isIOS)
                            {
                              if (isIOS)
                                CupertinoAlertDialog(
                                  title: const Text('Are you sure?'),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () => {},
                                      child: const Text('Cancel'),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        _delete();
                                      },
                                      child: const Text('Confirm'),
                                    ),
                                  ],
                                ),
                            }
                          else
                            {
                              AlertDialog(
                                title: const Text('Are you sure?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _delete();
                                    },
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              ),
                            },
                        },
                        weight: FontWeight.w400,
                        radius: AppRadius.borderRadiusXl,
                        buttonColor: cs.errorContainer,
                        borderColor: cs.error,
                        textColor: cs.error,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
