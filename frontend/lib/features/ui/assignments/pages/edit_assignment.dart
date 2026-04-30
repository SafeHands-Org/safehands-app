import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/models/medications/family_member_medication.dart';
import 'package:frontend/models/medications/medication_schedule.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/services/notification_service.dart';
import 'package:go_router/go_router.dart';

class EditAssignmentView extends ConsumerStatefulWidget {
  const EditAssignmentView({super.key, required this.assignment});
  final FamilyMemberMedication assignment;

  @override
  ConsumerState<EditAssignmentView> createState() =>
      _EditAssignmentViewState();
}

class _EditAssignmentViewState extends ConsumerState<EditAssignmentView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _quantityCtrl;

  String? _active;
  String? _selectedPriority;

  List<TimeOfDay> _times = [];
  List<String> _selectedDays = [];
  MedicationSchedule? _existingSchedule;
  bool _scheduleLoaded = false;
  bool _saving = false;

  static const _allDays = [
    'monday', 'tuesday', 'wednesday', 'thursday',
    'friday', 'saturday', 'sunday',
  ];
  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  void initState() {
    super.initState();
    _quantityCtrl = TextEditingController(text: widget.assignment.quantity.toString());
    _active = widget.assignment.active ? 'Yes' : 'No';
    final p = widget.assignment.priority;
    _selectedPriority = p.isNotEmpty ? p[0]
      .toUpperCase() + p.substring(1)
      .toLowerCase() : null;

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadSchedule());
  }

  @override
  void dispose() {
    _quantityCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadSchedule() async {
    final repo = ref.read(scheduleRepositoryProvider);
    final found = await repo.getScheduleForAssignment(widget.assignment.id);
    if (!mounted) return;
    setState(() {
      _existingSchedule = found;
      _scheduleLoaded = true;
      if (found != null && found.isNotEmpty) {
        _times = found.timesOfDay.map((t) {
          final parts = t.split(':');
          if (parts.length < 2) return null;
          return TimeOfDay(
            hour: int.tryParse(parts[0]) ?? 0,
            minute: int.tryParse(parts[1]) ?? 0,
          );
        }).whereType<TimeOfDay>().toList();
        _selectedDays = List<String>.from(found.daysOfWeek);
      }
    });
  }

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  String _displayTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final min = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$min $period';
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _times.isNotEmpty ? _times.last : TimeOfDay.now(),
    );
    if (picked != null) setState(() => _times.add(picked));
  }

  Future<void> _delete() async {
    try {
      final scheduleRepo = ref.read(scheduleRepositoryProvider);
      final assignmentRepo = ref.read(assignmentRepositoryProvider);

      if (_existingSchedule != null) {
        await scheduleRepo.deleteSchedule(
          _existingSchedule!.id,
          widget.assignment.familyMemberId,
        );
        for (int i = 0; i < 10; i++) {
          await NotificationService.cancelScheduled(
              '${widget.assignment.id}_$i'.hashCode);
        }
      }
      await assignmentRepo.deleteFamilyMedication(
        widget.assignment.familyMemberId,
        widget.assignment.id,
      );

      if (!mounted) return;
      ref.invalidate(assignmentsProvider);
      ref.invalidate(schedulesProvider);
      ref.invalidate(aggregateMembershipsProvider);
      ref.invalidate(aggregateMemberProvider);
      context.go('/family/members/${widget.assignment.familyMemberId}');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to remove: $e'),
        backgroundColor: const Color(0xFFB62320),
      ));
    }
  }

  Future<void> _update() async {
    if (!_formKey.currentState!.validate()) return;
    if (_times.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please add at least one dose time'),
        backgroundColor: Color(0xFFB62320),
      ));
      return;
    }

    setState(() => _saving = true);

    try {
      final assignmentRepo = ref.read(assignmentRepositoryProvider);
      final scheduleRepo = ref.read(scheduleRepositoryProvider);

      await assignmentRepo.updateFamilyMedication(
        widget.assignment.id,
        MemberMedicationUpdate(
          id: widget.assignment.id,
          priority: _selectedPriority!.toLowerCase(),
          quantity: int.tryParse(_quantityCtrl.text.trim()),
          active: _active == 'Yes',
        ),
      );

      final timeStrings = _times.map(_formatTime).toList();
      if (_existingSchedule != null) {
        await scheduleRepo.deleteSchedule(
          _existingSchedule!.id,
          widget.assignment.familyMemberId,
        );
      }
      await scheduleRepo.createSchedule(
        ScheduleRequest(
          familyMemberMedicationId: widget.assignment.id,
          timesOfDay: timeStrings,
          daysOfWeek: _selectedDays.isEmpty ? null : _selectedDays,
          frequency: _selectedDays.isEmpty ? 1 : _selectedDays.length,
        ),
        widget.assignment.familyMemberId,
      );

      for (int i = 0; i < 10; i++) {
        await NotificationService.cancelScheduled(
            '${widget.assignment.id}_$i'.hashCode);
      }
      for (int i = 0; i < _times.length; i++) {
        await NotificationService.scheduleDaily(
          id: '${widget.assignment.id}_$i'.hashCode,
          title: '💊 Medication Reminder',
          body: 'Time to take your medication',
          hour: _times[i].hour,
          minute: _times[i].minute,
        );
      }

      ref.invalidate(assignmentsProvider);
      ref.invalidate(schedulesProvider);
      ref.invalidate(aggregateMembershipsProvider);
      ref.invalidate(aggregateMemberProvider);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Updated Information'),
      ));
      context.canPop()
          ? context.pop()
          : context.go('/family/members/${widget.assignment.familyMemberId}');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update: $e'),
        backgroundColor: const Color(0xFFB62320),
      ));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showDeleteDialog() {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Remove medication?'),
          content: const Text(
              'This removes the assignment and schedule from this member.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                _delete();
              },
              child: const Text('Remove'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: const Text('Remove medication?'),
          content: const Text(
              'This removes the assignment and schedule from this member.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _delete();
              },
              child: Text('Remove',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/family'),
        ),
        flexibleSpace: Container(
            decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text('Edit Assignment',
            style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
            textAlign: TextAlign.center),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.base),
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
                          validators: (v) =>
                              v == null || v.trim().isEmpty
                                  ? 'Please enter a quantity'
                                  : null,
                          hintText: 'Enter a quantity',
                        ),
                      ),
                      FormSection(
                        title: 'Active',
                        child: EditableDropdownField(
                          value: _active,
                          hintText: 'Make this medication active?',
                          items: const ['Yes', 'No'],
                          validator: (v) =>
                              v == null ? 'Please select an option' : null,
                          onChanged: (v) => setState(() => _active = v),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text('Dose Schedule',
                          style: tt.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),

                      if (!_scheduleLoaded)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: LinearProgressIndicator(),
                        )
                      else ...[
                        if (_times.isNotEmpty) ...[
                          Text('Dose times',
                              style: tt.bodySmall?.copyWith(
                                  color: cs.onSurfaceVariant,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: _times.asMap().entries.map((e) {
                              return Chip(
                                label: Text(_displayTime(e.value)),
                                deleteIcon:
                                    const Icon(Icons.close, size: 16),
                                onDeleted: () => setState(
                                    () => _times.removeAt(e.key)),
                                backgroundColor: cs.primaryContainer
                                    .withValues(alpha: 0.5),
                                labelStyle: TextStyle(
                                    color: cs.primary,
                                    fontWeight: FontWeight.w500),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                        ],
                        OutlinedButton.icon(
                          onPressed: _pickTime,
                          icon: const Icon(Icons.add_alarm_outlined),
                          label: Text(_times.isEmpty
                              ? 'Add dose time'
                              : 'Add another time'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                                borderRadius: AppRadius.borderRadiusXl),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('Repeat on',
                            style: tt.bodySmall?.copyWith(
                                color: cs.onSurfaceVariant,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: List.generate(7, (i) {
                            final day = _allDays[i];
                            final selected = _selectedDays.contains(day);
                            return GestureDetector(
                              onTap: () => setState(() => selected
                                  ? _selectedDays.remove(day)
                                  : _selectedDays.add(day)),
                              child: AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 150),
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selected
                                      ? cs.primary
                                      : cs.surfaceContainerHighest,
                                  border: Border.all(
                                      color: selected
                                          ? cs.primary
                                          : cs.outlineVariant),
                                ),
                                child: Center(
                                  child: Text(_dayLabels[i],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: selected
                                              ? cs.onPrimary
                                              : cs.onSurfaceVariant)),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],

                      const SizedBox(height: 32),

                      FormButton(
                        label: _saving ? 'Saving...' : 'Update',
                        weight: FontWeight.w400,
                        radius: AppRadius.borderRadiusXl,
                        onPressed: _saving ? () {} : () { _update(); },
                      ),
                      const SizedBox(height: 18),
                      FormButton(
                        label: 'Remove',
                        onPressed: () => _showDeleteDialog(),
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