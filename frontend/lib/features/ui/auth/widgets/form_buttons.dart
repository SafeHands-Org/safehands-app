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
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.weight,
    this.radius
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? trailingIcon;
  final bool enabled;
  final bool isLoading;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final FontWeight? weight;
  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bt = Theme.of(context).elevatedButtonTheme;
    final tt = Theme.of(context).textTheme;

    final active = enabled && !isLoading;
    return ElevatedButton(
      onPressed: active ? onPressed : null,
      style: bt.style?.copyWith(
        backgroundColor: WidgetStatePropertyAll(active ? buttonColor ?? cs.primary : cs.primaryContainer),
        side: WidgetStatePropertyAll(BorderSide(color: active ? borderColor ?? cs.primary : cs.primaryContainer)),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
        splashFactory: InkSplash.splashFactory,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: radius ?? AppRadius.borderRadiusPill)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: cs.onInverseSurface, strokeWidth: 2))
            else...[
              Text(
                label,
                style: tt.bodyLarge?.copyWith(
                  fontWeight: weight ?? FontWeight.bold,
                  color: active ? textColor ?? cs.onInverseSurface: cs.onSurface.withValues(alpha: 0.38)
                )
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(trailingIcon, color: active ? Colors.white : cs.onSurface.withValues(alpha: 0.38), size: 20),
              ],
            ],
          ],
        )
      )
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