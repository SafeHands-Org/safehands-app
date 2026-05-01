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
import 'package:frontend/services/notification_service.dart';
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
  String? _selectedMemberName;
  String? _selectedMedicationName;
  String? _selectedPriority;
  String? _active;

  final List<TimeOfDay> _times = [];
  final List<String> _selectedDays = [];
  bool _saving = false;

  static const _allDays = [
    'monday', 'tuesday', 'wednesday', 'thursday',
    'friday', 'saturday', 'sunday',
  ];
  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

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

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(ctx).colorScheme,
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _times.add(picked));
    }
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _displayTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final min = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$min $period';
  }

  Future<void> _create() async {
    if (!_formKey.currentState!.validate()) return;
    if (_times.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one dose time'),
          backgroundColor: Color(0xFFB62320),
        ),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      final assignment = await ref
        .read(assignmentRepositoryProvider)
        .createFamilyMedicationAndReturn(
          MemberMedicationRequest(
            medicationId: _selectedMedicationId!,
            familyMemberId: _selectedMemberId!,
            priority: _selectedPriority!.toLowerCase(),
            quantity: int.parse(_quantityCtrl.text.trim()),
            active: _active == 'Yes',
          ),
        );

      final timeStrings = _times.map(_formatTime).toList();
      await ref.read(scheduleRepositoryProvider).createSchedule(
        ScheduleRequest(
          familyMemberMedicationId: assignment.id,
          timesOfDay: timeStrings,
          daysOfWeek: _selectedDays.isEmpty ? null : _selectedDays,
          frequency: _selectedDays.isEmpty ? 1 : _selectedDays.length,
        ),
        _selectedMemberId!,
      );

      final medName = _selectedMedicationName ?? 'Medication';
      final memberName = _selectedMemberName ?? 'Family member';
      for (int i = 0; i < _times.length; i++) {
        final t = _times[i];
        await NotificationService.scheduleDaily(
          id: '${assignment.id}_$i'.hashCode,
          title: '💊 Medication Reminder',
          body: '$memberName needs to take $medName',
          hour: t.hour,
          minute: t.minute,
        );
      }

      ref.read(assignmentRepositoryProvider).clearCache();
      ref.read(scheduleRepositoryProvider).clearCache();

      ref.invalidate(assignmentsProvider);
      ref.invalidate(schedulesProvider);
      ref.invalidate(aggregateMembershipsProvider);
      ref.invalidate(aggregateMemberProvider);
      ref.invalidate(adherencesProvider);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Assignment & schedule created'),
        ),
      );
      context.canPop() ? context.pop() : context.go('/family');
    } catch (e) {
      if (!mounted) return;
      final message = switch (e) {
        ServerException() => 'Request timed out. Try again.',
        DuplicateException() => 'This assignment already exists.',
        _ => 'Something went wrong: $e',
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message),
            backgroundColor: const Color(0xFFB62320)),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
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
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/family'),
        ),
        flexibleSpace: Container(
            decoration:
                BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'Assign Medication',
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
                        SectionHeader(title: 'Assignment Details'),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 16, 5, 16),
                            child: Column(
                              children: [
                                medicationsAsync.when(
                                  data: (medications) {
                                    final entries = medications.entries.toList();
                                    return FormSection(
                                      title: 'Medication',
                                      child: Column(children: [
                                        const SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          isExpanded: true,
                                          initialValue: _selectedMedicationId,
                                          hint: const Text('Select a medication'),
                                          decoration: _dropdownDecoration(context),
                                          validator: (v) => v == null
                                              ? 'Please select a medication'
                                              : null,
                                          onChanged: (v) => setState(() {
                                            _selectedMedicationId = v;
                                            _selectedMedicationName = medications[v]?.names.firstOrNull;
                                          }),
                                          items: entries.map((e) {
                                            final Medication med = e.value;
                                            final label = med.names.isNotEmpty ? med.names.first : e.key;
                                            return DropdownMenuItem<String>(
                                              value: e.key,
                                              child: Text(label, overflow: TextOverflow.ellipsis),
                                            );
                                          }).toList(),
                                        ),
                                      ]),
                                    );
                                  },
                                  loading: () => const FormSection(
                                      title: 'Medication',
                                      child: LinearProgressIndicator()),
                                  error: (_, _) => const FormSection(
                                      title: 'Medication',
                                      child: Text('Failed to load medications')),
                                ),
                                membersAsync.when(
                                  data: (members) {
                                    final entries = members.entries.toList();
                                    return FormSection(
                                      title: 'Family Member',
                                      child: Column(children: [
                                        const SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          isExpanded: true,
                                          initialValue: _selectedMemberId,
                                          hint: const Text(
                                              'Select a family member'),
                                          decoration:
                                              _dropdownDecoration(context),
                                          validator: (v) => v == null
                                              ? 'Please select a family member'
                                              : null,
                                          onChanged: (v) => setState(() {
                                            _selectedMemberId = v;
                                            _selectedMemberName = members[v]?.name;
                                          }),
                                          items: entries.map((e) {
                                            final FamilyMember member = e.value;
                                            return DropdownMenuItem<String>(
                                              value: e.key,
                                              child: Text(member.name, overflow: TextOverflow.ellipsis),
                                            );
                                          }).toList(),
                                        ),
                                      ]),
                                    );
                                  },
                                  loading: () => const FormSection(
                                      title: 'Family Member',
                                      child: LinearProgressIndicator()),
                                  error: (_, _) => const FormSection(
                                      title: 'Family Member',
                                      child: Text('Failed to load family members')),
                                ),
                                FormSection(
                                  title: 'Priority',
                                  child: EditableDropdownField(
                                    value: _selectedPriority,
                                    hintText: 'Select priority',
                                    items: const ['Low', 'Medium', 'High'],
                                    validator: (v) => v == null
                                        ? 'Please select a priority'
                                        : null,
                                    onChanged: (v) =>
                                        setState(() => _selectedPriority = v),
                                  ),
                                ),
                                FormSection(
                                  title: 'Quantity',
                                  child: EditableFormField(
                                    ctrl: _quantityCtrl,
                                    hintText: 'Enter a quantity',
                                    validators: (v) {
                                      if (v == null || v.trim().isEmpty) {
                                        return 'Please enter a quantity';
                                      }
                                      if (int.tryParse(v.trim()) == null) {
                                        return 'Must be a whole number';
                                      }
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
                                    validator: (v) => v == null
                                        ? 'Please select an option'
                                        : null,
                                    onChanged: (v) =>
                                        setState(() => _active = v),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        SectionHeader(title: 'Dose Schedule'),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_times.isNotEmpty) ...[
                                  Text('Dose times',
                                      style: tt.bodySmall?.copyWith(
                                          color: cs.onSurfaceVariant,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 6,
                                    children: _times
                                        .asMap()
                                        .entries
                                        .map((e) => Chip(
                                              label: Text(_displayTime(e.value)),
                                              deleteIcon: const Icon(
                                                  Icons.close,
                                                  size: 16),
                                              onDeleted: () => setState(
                                                  () => _times.removeAt(e.key)),
                                              backgroundColor: cs
                                                  .primaryContainer
                                                  .withValues(alpha: 0.5),
                                              labelStyle: TextStyle(
                                                  color: cs.primary,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                        .toList(),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                OutlinedButton.icon(
                                  onPressed: _pickTime,
                                  icon: const Icon(Icons.add_alarm_outlined),
                                  label: Text(_times.isEmpty
                                      ? 'Add dose time'
                                      : 'Add another time'),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusXl),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                Text('Repeat on',
                                    style: tt.bodySmall?.copyWith(
                                        color: cs.onSurfaceVariant,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(7, (i) {
                                    final day = _allDays[i];
                                    final selected =
                                        _selectedDays.contains(day);
                                    return GestureDetector(
                                      onTap: () => setState(() {
                                        selected ? _selectedDays.remove(day) : _selectedDays.add(day);
                                      }),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 150),
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selected ? cs.primary : cs.surfaceContainerHighest,
                                          border: Border.all(color: selected ? cs.primary : cs.outlineVariant),
                                        ),
                                        child: Center(
                                          child: Text(
                                            _dayLabels[i],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: selected ? cs.onPrimary : cs.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          child: FormButton(
                            label: _saving
                                ? 'Creating...'
                                : 'Create Assignment',
                            onPressed: _saving ? () {} : () { _create(); },
                            weight: FontWeight.w500,
                            radius: AppRadius.borderRadiusXl,
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