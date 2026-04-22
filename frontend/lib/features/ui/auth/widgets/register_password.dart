import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/features/ui/auth/widgets/form_field.dart';
import 'package:frontend/features/ui/auth/widgets/form_progress.dart';

class RegisterStepPassword extends ConsumerStatefulWidget {
  const RegisterStepPassword({
    super.key,
    required this.email,
    required this.onNext,
    required this.onBack,
  });

  final String email;
  final void Function(String password) onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<RegisterStepPassword> createState() => _RegisterStepPasswordState();
}

class _RegisterStepPasswordState extends ConsumerState<RegisterStepPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordCtrl.text != _confirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords don't match")),
      );
      return;
    }
    widget.onNext(_passwordCtrl.text);
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
                const FormProgressDots(filled: 1),
              ],
            ),
          ),
          Text('Create Password', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: cs.onSurface)),
          const SizedBox(height: 8),
          Text('Choose a secure password for your account', style: TextStyle(color: cs.onSurfaceVariant)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.mail_outline, size: 16, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Text(widget.email, style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 32),
          FormTextField(
            label: 'Password',
            controller: _passwordCtrl,
            hint: 'Create a password',
            prefixIcon: Icons.lock_outline,
            obscure: true,
            helper: 'Must be at least 8 characters',
            validator: (v) => (v == null || v.length < 8) ? 'Minimum 8 characters' : null,
          ),
          const SizedBox(height: 20),
          FormTextField(
            label: 'Confirm Password',
            controller: _confirmCtrl,
            hint: 'Confirm your password',
            prefixIcon: Icons.lock_outline,
            obscure: true,
            validator: (v) => (v == null || v.isEmpty) ? 'Please confirm your password' : null,
          ),
          const SizedBox(height: 32),
          FormButton(
            label: 'Continue',
            trailingIcon: Icons.arrow_forward,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}