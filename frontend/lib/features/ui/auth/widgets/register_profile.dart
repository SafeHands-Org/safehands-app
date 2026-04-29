import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/features/ui/auth/widgets/form_field.dart';
import 'package:frontend/features/ui/auth/widgets/form_progress.dart';

class RegisterStepProfile extends StatefulWidget {
  const RegisterStepProfile({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final void Function(String name, String role) onNext;
  final VoidCallback onBack;

  @override
  State<RegisterStepProfile> createState() => _RegisterStepProfileState();
}

class _RegisterStepProfileState extends State<RegisterStepProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  String? _role;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role')),
      );
      return;
    }
    widget.onNext(_nameCtrl.text.trim(), _role!);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FormBackButton(onPressed: widget.onBack),
                const FormProgressDots(filled: 2),
              ],
            ),
          ),
          Text('Your Profile', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: cs.onSurface)),
          const SizedBox(height: 8),
          Text('Tell us a bit about yourself', style: TextStyle(color: cs.onSurfaceVariant)),
          const SizedBox(height: 32),
          FormTextField(
            label: 'Full Name',
            controller: _nameCtrl,
            hint: 'Enter your full name',
            prefixIcon: Icons.person_outline,
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 24),
          Text('Select Your Role', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: cs.onSurface)),
          const SizedBox(height: 12),
          _RoleCard(
            selected: _role == 'caregiver',
            icon: Icons.shield_outlined,
            title: 'Caregiver',
            description:
              'Manage medications for family members, create and manage '
              'family groups, and oversee all health tracking',
            onTap: () => setState(() => _role = 'caregiver'),
          ),
          const SizedBox(height: 12),
          _RoleCard(
            selected: _role == 'family_member',
            icon: Icons.group_outlined,
            title: 'Family Member',
            description:
              'Join an existing family group to track your own medications '
              'and share with your caregiver',
            onTap: () => setState(() => _role = 'family_member'),
          ),
          const SizedBox(height: 32),
          FormButton(
            label: 'Continue',
            trailingIcon: Icons.arrow_forward,
            enabled: _role != null,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.selected,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: AppRadius.borderRadiusCard,
          border: Border.all(color: selected ? cs.primary : cs.outlineVariant, width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: selected ? cs.primaryContainer : cs.surfaceContainerHigh,
                borderRadius: AppRadius.borderRadiusXl,
              ),
              child: Icon(icon, size: 24, color: selected ? cs.primary : cs.onSurfaceVariant),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: cs.onSurface)),
                  const SizedBox(height: 4),
                  Text(description, style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant, height: 1.4)),
                ],
              ),
            ),
            if (selected)
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                child: const Center(child: Icon(Icons.circle, color: Colors.white, size: 8)),
              ),
          ],
        ),
      ),
    );
  }
}
