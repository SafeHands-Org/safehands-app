import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/providers/medication/medication_providers.dart';

class ScheduleFormView extends ConsumerStatefulWidget {
  const ScheduleFormView({super.key});

  @override
  ConsumerState<ScheduleFormView> createState() => _ScheduleFormState();
}

class _ScheduleFormState extends ConsumerState<ScheduleFormView> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedMedication;
  final List<TimeOfDay> _times = [];
  final Set<String> _selectedDays = {'M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su'};
  int _repeatInterval = 1;

  static const _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  Future<void> _addTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: _timePickerTheme,
    );
    if (picked != null) {
      setState(() => _times.add(picked));
    }
  }

  void _removeTime(int index) => setState(() => _times.removeAt(index));

  void _toggleDay(String day, bool selected) {
    setState(() {
      if (selected) {
        _selectedDays.add(day);
      } else {
        _selectedDays.remove(day);
      }
    });
  }

  Widget _timePickerTheme(BuildContext context, Widget? child) {
    final cs = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: cs.copyWith(
          primary: cs.primary,
          onPrimary: cs.onPrimary,
          onSurface: cs.onSurface,
        ),
      ),
      child: child!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final provider = ref.watch(medicationsProvider);

    final medications = provider.value?.values.toSet();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormSection(
            title: 'Medication',
            child: DropdownButtonFormField<String>(
              initialValue: _selectedMedication,
              decoration: formFieldDecoration(
                hintText: 'Select medication',
                prefixIcon: Icon(Icons.medication_outlined, color: cs.onSurfaceVariant, size: 20),
                context: context
              ),
              items: medications?.map((med) {
                return DropdownMenuItem(
                  value: med.names.first,
                  child: Text('${med.names.first} ${med.dosage}'),
                );
              }).toList(),
              onChanged: (v) => setState(() => _selectedMedication = v),
              validator: (v) => v == null ? 'Please select a medication' : null,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 16),

          FormSection(
            title: 'Times of Day',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._times.asMap().entries.map(
                  (entry) => Chip(
                    label: Text(
                      entry.value.format(context),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: cs.primary,
                      ),
                    ),
                    backgroundColor: cs.secondaryContainer,
                    side: BorderSide(color: cs.primary.withValues(alpha: 0.3)),
                    deleteIcon: Icon(Icons.close, size: 16, color: cs.primary),
                    onDeleted: () => _removeTime(entry.key),
                  ),
                ),
                ActionChip(
                  avatar: Icon(Icons.add, size: 16, color: cs.primary),
                  label: Text(
                    'Add Time',
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.primary,
                    ),
                  ),
                  backgroundColor: cs.surface,
                  side: BorderSide(color: cs.primary),
                  onPressed: _addTime,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          FormSection(
            title: 'Days of Week',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _days.map((day) {
                final isSelected = _selectedDays.contains(day);
                return FilterChip(
                  label: Text(day),
                  selected: isSelected,
                  onSelected: (v) => _toggleDay(day, v),
                  labelStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? cs.primary
                        : cs.onSurfaceVariant,
                  ),
                  selectedColor: cs.secondaryContainer,
                  checkmarkColor: cs.primary,
                  side: BorderSide(
                    color: isSelected
                        ? cs.primary.withValues(alpha: 0.3)
                        : cs.outlineVariant,
                  ),
                  backgroundColor: cs.surface,
                  showCheckmark: false,
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          FormSection(
            title: 'Quantity',
            child: DropdownButtonFormField<int>(
              initialValue: _repeatInterval,
              decoration: formFieldDecoration(prefixIcon: Icon(Icons.repeat, color: cs.onSurfaceVariant, size: 20), context: context),
              items: List.generate(
                12,
                (i) => DropdownMenuItem(
                  value: i + 1,
                  child: Text('${i + 1}'),
                ),
              ),
              onChanged: (v) => setState(() => _repeatInterval = v!),
              icon: Icon(Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}