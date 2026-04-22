import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.trailingIcon,
    this.enabled = true,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? trailingIcon;
  final bool enabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final active = enabled && !isLoading;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.borderRadiusXl,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderRadiusXl,
            color: active ? cs.primary : cs.primaryContainer,
          ),
          child: InkWell(
            borderRadius: AppRadius.borderRadiusXl,
            onTap: active ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  else...[
                    Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: active ? Colors.white : cs.onSurface.withValues(alpha: 0.38))),
                    if (trailingIcon != null) ...[
                      const SizedBox(width: 8),
                      Icon(trailingIcon, color: active ? Colors.white : cs.onSurface.withValues(alpha: 0.38), size: 20),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormBackButton extends StatelessWidget {
  const FormBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressed,
      borderRadius: AppRadius.borderRadiusPill,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(Icons.arrow_back, color: cs.onSurfaceVariant, size: 24),
      ),
    );
  }
}