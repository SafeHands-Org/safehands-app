import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/features/ui/auth/widgets/form_field.dart';
import 'package:go_router/go_router.dart';

class RegisterStepEmail extends ConsumerStatefulWidget {
  const RegisterStepEmail({super.key, required this.onNext});

  final void Function(String email) onNext;

  @override
  ConsumerState<RegisterStepEmail> createState() => _RegisterStepEmailState();
}

class _RegisterStepEmailState extends ConsumerState<RegisterStepEmail> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onNext(_emailCtrl.text.trim());
    }
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
            child: FormBackButton(onPressed: () => context.go('/auth/startup')),
          ),
          Text('Create Account', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: cs.onSurface)),
          const SizedBox(height: 8),
          Text('Enter your email to get started', style: TextStyle(color: cs.onSurfaceVariant)),
          const SizedBox(height: 32),
          FormTextField(
            label: 'Email Address',
            controller: _emailCtrl,
            hint: 'Enter your email',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your email';
              if (!v.contains('@')) return 'Enter a valid email address';
              return null;
            },
          ),
          const SizedBox(height: 32),
          FormButton(label: 'Create An Account', onPressed: _submit),
          const SizedBox(height: 24),
          Center(
            child: RichText(
              text: TextSpan(style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
                children: [
                  const TextSpan(text: 'Already have an account?  '),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => context.go('/auth/login'),
                      child: Text('Log In',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: cs.primary
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}