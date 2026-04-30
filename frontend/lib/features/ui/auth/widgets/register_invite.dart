import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/features/ui/auth/widgets/form_progress.dart';
import 'package:pinput/pinput.dart';

class RegisterStepInvite extends StatefulWidget {
  const RegisterStepInvite({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final void Function(String pin) onNext;
  final VoidCallback onBack;

  @override
  State<RegisterStepInvite> createState() => _RegisterStepInviteState();
}

class _RegisterStepInviteState extends State<RegisterStepInvite> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_pinController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an invite code')),
      );
      return;
    }
    widget.onNext(_pinController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final defaultTheme = PinTheme(
      width: 70,
      height: 65,
      textStyle: TextStyle(
        fontSize: 22,
        color: cs.onSurface
      ),
      decoration: BoxDecoration(
        color: cs.outlineVariant.withAlpha(100),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FormBackButton(onPressed: widget.onBack),
                  const FormProgressDots(filled: 3),
                ],
              ),
            ),
            Text('Enter Family Code', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: cs.onSurface)),
            const SizedBox(height: 8),
            Text('Ask your family administrator for the 4-digit invite code', style: TextStyle(color: cs.onSurfaceVariant)),
            SizedBox(
              height: 90,
              child: Pinput(
                length: 6,
                controller: _pinController,
                focusNode: _focusNode,
                defaultPinTheme: defaultTheme,
                focusedPinTheme: defaultTheme.copyWith(
                  width: 70,
                  height: 65,
                  decoration: defaultTheme.decoration!.copyWith(
                    border: Border.all(color: cs.primary),
                  ),
                ),
                errorPinTheme: defaultTheme.copyWith(
                  decoration: BoxDecoration(
                    color: cs.error,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _RoleCard(
              title: 'Joining a Family',
              description:
                "Once verified, you'll be added to your family's medication tracking group. "
                "You can manage your own medications and your caregiver will be able to help monitor your adherence"
            ),
            const SizedBox(height: 32),
            FormButton(
              label: 'Join & Verify',
              buttonColor: cs.primary,
              borderColor: cs.primary,
              trailingIcon: Icons.arrow_forward,
              onPressed: () {
                _focusNode.unfocus();
                _submit();
              },
            ),
          ],
        ),
      )
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: AppRadius.borderRadiusCard,
        border: Border.all(color: cs.outlineVariant, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: AppRadius.borderRadiusXl,
            ),
            child: Icon(Icons.check_circle_outline, size: 24, color: cs.primary),
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
        ],
      ),
    );
  }
}
