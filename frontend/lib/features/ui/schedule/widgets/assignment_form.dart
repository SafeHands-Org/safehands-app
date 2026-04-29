import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/models/families/family_member.dart';
import 'package:frontend/models/medications/medication.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class AssignmentFormView extends ConsumerStatefulWidget {
  const AssignmentFormView({super.key});

  @override
  ConsumerState<AssignmentFormView> createState() => _AssignmentFormViewState();
}

class _AssignmentFormViewState extends ConsumerState<AssignmentFormView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityCtrl = TextEditingController();

  String? _selectedMedicationId;
  String? _selectedMemberId;
  String? _selectedPriority;
  String? _active;

  @override
  void initState() {
    super.initState();
    ref.listenManual(assignmentsProvider, (previous, next) {
      if (previous is! AsyncLoading) return;
      next.whenOrNull(
        data: (_) {
          if (mounted) {
            ref.invalidate(assignmentsProvider);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Assignment created'),
                backgroundColor: Color(0xFF17821E),
              ),
            );
            context.canPop() ? context.pop() : context.go('/family');
          }
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
    _quantityCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dropdownDecoration(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      filled: true,
      fillColor: cs.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusXl,
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusXl,
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusXl,
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusXl,
        borderSide: BorderSide(color: cs.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusXl,
        borderSide: BorderSide(color: cs.error, width: 2),
      ),
    );
  }

  void _create() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(assignmentsProvider.notifier).createFamilyMedication(
        MemberMedicationRequest(
          medicationId: _selectedMedicationId!,
          familyMemberId: _selectedMemberId!,
          priority: _selectedPriority!.toLowerCase(),
          quantity: int.parse(_quantityCtrl.text.trim()),
          active: _active == 'Yes',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final medicationsAsync = ref.watch(medicationsProvider);
    final membersAsync = ref.watch(familyMembersProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.canPop() ? context.pop() : context.go('/family'),
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'Assignment Form',
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.palette.page),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 448),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(title: 'Create a new assignment'),
                        Card(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 16, 5, 16),
                            child: Column(
                              children: [
                                medicationsAsync.when(
                                  data: (medications) {
                                    final entries = medications.entries.toList();
                                    return FormSection(
                                      title: 'Medication',
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          DropdownButtonFormField<String>(
                                            isExpanded: true,
                                            value: _selectedMedicationId,
                                            hint: const Text('Select a medication'),
                                            decoration: _dropdownDecoration(context),
                                            validator: (v) => v == null ? 'Please select a medication' : null,
                                            onChanged: (v) => setState(() => _selectedMedicationId = v),
                                            items: entries.map((e) {
                                              final Medication med = e.value;
                                              final label = med.names.isNotEmpty ? med.names.first : e.key;
                                              return DropdownMenuItem<String>(
                                                value: e.key,
                                                child: Text(label, overflow: TextOverflow.ellipsis),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  loading: () => const FormSection(
                                    title: 'Medication',
                                    child: LinearProgressIndicator(),
                                  ),
                                  error: (_, __) => const FormSection(
                                    title: 'Medication',
                                    child: Text('Failed to load medications'),
                                  ),
                                ),
                                membersAsync.when(
                                  data: (members) {
                                    final entries = members.entries.toList();
                                    return FormSection(
                                      title: 'Family Member',
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          DropdownButtonFormField<String>(
                                            isExpanded: true,
                                            value: _selectedMemberId,
                                            hint: const Text('Select a family member'),
                                            decoration: _dropdownDecoration(context),
                                            validator: (v) => v == null ? 'Please select a family member' : null,
                                            onChanged: (v) => setState(() => _selectedMemberId = v),
                                            items: entries.map((e) {
                                              final FamilyMember member = e.value;
                                              return DropdownMenuItem<String>(
                                                value: e.key,
                                                child: Text(member.name, overflow: TextOverflow.ellipsis),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  loading: () => const FormSection(
                                    title: 'Family Member',
                                    child: LinearProgressIndicator(),
                                  ),
                                  error: (_, __) => const FormSection(
                                    title: 'Family Member',
                                    child: Text('Failed to load family members'),
                                  ),
                                ),
                                FormSection(
                                  title: 'Priority',
                                  child: EditableDropdownField(
                                    value: _selectedPriority,
                                    hintText: 'Select priority',
                                    items: const ['Low', 'Medium', 'High'],
                                    validator: (v) => v == null ? 'Please select a priority' : null,
                                    onChanged: (v) => setState(() => _selectedPriority = v),
                                  ),
                                ),
                                FormSection(
                                  title: 'Quantity',
                                  child: EditableFormField(
                                    ctrl: _quantityCtrl,
                                    hintText: 'Enter a quantity',
                                    validators: (v) {
                                      if (v == null || v.trim().isEmpty) return 'Please enter a quantity';
                                      if (int.tryParse(v.trim()) == null) return 'Must be a whole number';
                                      return null;
                                    },
                                  ),
                                ),
                                FormSection(
                                  title: 'Active',
                                  child: EditableDropdownField(
                                    value: _active,
                                    hintText: 'Make this assignment active?',
                                    items: const ['Yes', 'No'],
                                    validator: (v) => v == null ? 'Please select an option' : null,
                                    onChanged: (v) => setState(() => _active = v),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: FormButton(
                                    label: 'Create Assignment',
                                    onPressed: _create,
                                    weight: FontWeight.w400,
                                    radius: AppRadius.borderRadiusXl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
