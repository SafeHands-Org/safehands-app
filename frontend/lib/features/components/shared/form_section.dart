import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.borderRadiusCard,
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8, offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600,
              color: cs.onSurface, letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

InputDecoration formFieldDecoration({String? hintText, Widget? prefixIcon, Widget? suffixIcon, required BuildContext context}) {
  final cs = Theme.of(context).colorScheme;

  final border = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.outlineVariant),
  );
  final focusedBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.outlineVariant, width: 2),
  );
  final errorBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.error),
  );

  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: cs.onSurface, fontSize: 14),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: cs.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: border,
    enabledBorder: border,
    focusedBorder: focusedBorder,
    errorBorder: errorBorder,
    focusedErrorBorder: errorBorder,
  );
}