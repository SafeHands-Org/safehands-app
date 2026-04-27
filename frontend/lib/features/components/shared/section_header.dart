import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.isUppercase = false,
  });

  final String title;
  final IconData? actionLabel;
  final VoidCallback? onAction;
  final bool isUppercase;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isUppercase ? title.toUpperCase() : title,
            style: isUppercase ? TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant, letterSpacing: 0.5,
            )
            : TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
          ),
          if (actionLabel != null) GestureDetector(
            onTap: onAction,
            child: Icon(
              actionLabel
            )
          ),
        ],
      ),
    );
  }
}
