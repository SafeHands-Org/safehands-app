import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/models/collections/collections.dart';
import 'package:frontend/models/medications/family_member_medication.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class ScheduleFormView extends ConsumerStatefulWidget {
  const ScheduleFormView({super.key, required this.members});

  final List<Member> members;

  @override
  ConsumerState<ScheduleFormView> createState() => _ScheduleFormViewState();
}

class _ScheduleFormViewState extends ConsumerState<ScheduleFormView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _frequencyCtrl = TextEditingController();

  Member? _selectedMember;
  FamilyMemberMedication? _selectedAssignment;
  final List<TimeOfDay> _selectedTimes = [];
  final List<String> _selectedDays = [];

  static const List<String> _dayOptions = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String _formatTimeApi(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _formatTimeDisplay(TimeOfDay t) => t.format(context);

  Future<void> _addTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _selectedTimes.add(picked));
    }
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(schedulesProvider, (previous, next) {
      if (previous is! AsyncLoading) return;
      next.whenOrNull(
        data: (_) {
          if (mounted) {
            ref.invalidate(schedulesProvider);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Schedule created'),
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
    _frequencyCtrl.dispose();
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
      await ref.read(schedulesProvider.notifier).createSchedule(
        ScheduleRequest(
          familyMemberMedicationId: _selectedAssignment!.id,
          timesOfDay: _selectedTimes.map(_formatTimeApi).toList(),
          daysOfWeek: _selectedDays.isEmpty ? null : _selectedDays.map((d) => d.toLowerCase()).toList(),
          frequency: int.parse(_frequencyCtrl.text.trim()),
        ),
        _selectedMember!.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final memberAssignments = _selectedMember?.fmms ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.canPop() ? context.pop() : context.go('/family'),
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'Schedule Form',
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
                        SectionHeader(title: 'Create a new schedule'),
                        Card(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 16, 5, 16),
                            child: Column(
                              children: [
                                FormSection(
                                  title: 'Family Member',
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<Member>(
                                        isExpanded: true,
                                        initialValue: _selectedMember,
                                        hint: const Text('Select a family member'),
                                        decoration: _dropdownDecoration(context),
                                        validator: (v) => v == null ? 'Please select a family member' : null,
                                        onChanged: (v) => setState(() {
                                          _selectedMember = v;
                                          _selectedAssignment = null;
                                        }),
                                        items: widget.members.map((m) {
                                          return DropdownMenuItem<Member>(
                                            value: m,
                                            child: Text(m.name, overflow: TextOverflow.ellipsis),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                FormSection(
                                  title: 'Assignment',
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<FamilyMemberMedication>(
                                        isExpanded: true,
                                        value: _selectedAssignment,
                                        hint: Text(
                                          _selectedMember == null
                                              ? 'Select a family member first'
                                              : 'Select an assignment',
                                        ),
                                        decoration: _dropdownDecoration(context),
                                        validator: (v) => v == null ? 'Please select an assignment' : null,
                                        onChanged: _selectedMember == null
                                            ? null
                                            : (v) => setState(() => _selectedAssignment = v),
                                        items: memberAssignments.map((a) {
                                          final med = _selectedMember!.medications
                                              .where((m) => m.id == a.medicationId)
                                              .firstOrNull;
                                          final name = (med != null && med.names.isNotEmpty)
                                              ? med.names.first
                                              : a.medicationId;
                                          final label = '$name — ${a.priority}, qty ${a.quantity}';
                                          return DropdownMenuItem<FamilyMemberMedication>(
                                            value: a,
                                            child: Text(label, overflow: TextOverflow.ellipsis),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                FormSection(
                                  title: 'Times of Day',
                                  child: FormField<List<TimeOfDay>>(
                                    validator: (_) => _selectedTimes.isEmpty
                                        ? 'Please add at least one time'
                                        : null,
                                    builder: (field) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 4,
                                          children: [
                                            ..._selectedTimes.asMap().entries.map((entry) {
                                              return Chip(
                                                label: Text(_formatTimeDisplay(entry.value)),
                                                deleteIcon: const Icon(Icons.close, size: 16),
                                                onDeleted: () {
                                                  setState(() => _selectedTimes.removeAt(entry.key));
                                                  field.didChange(_selectedTimes);
                                                },
                                              );
                                            }),
                                            ActionChip(
                                              avatar: const Icon(Icons.add, size: 16),
                                              label: const Text('Add Time'),
                                              onPressed: () async {
                                                await _addTime();
                                                field.didChange(_selectedTimes);
                                              },
                                            ),
                                          ],
                                        ),
                                        if (field.hasError)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6),
                                            child: Text(
                                              field.errorText!,
                                              style: TextStyle(color: cs.error, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                FormSection(
                                  title: 'Days of Week (optional)',
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    children: _dayOptions.map((day) {
                                      final selected = _selectedDays.contains(day);
                                      return FilterChip(
                                        label: Text(day),
                                        selected: selected,
                                        onSelected: (on) => setState(() {
                                          on ? _selectedDays.add(day) : _selectedDays.remove(day);
                                        }),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                FormSection(
                                  title: 'Frequency',
                                  child: EditableFormField(
                                    ctrl: _frequencyCtrl,
                                    hintText: 'Enter frequency (e.g. 1)',
                                    validators: (v) {
                                      if (v == null || v.trim().isEmpty) return 'Please enter a frequency';
                                      if (int.tryParse(v.trim()) == null) return 'Must be a whole number';
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: FormButton(
                                    label: 'Create Schedule',
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
