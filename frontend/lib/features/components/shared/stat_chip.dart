import 'package:flutter/material.dart';

class StatChip extends StatelessWidget {
  const StatChip({
    super.key,
    this.value,
    this.label,
    this.icon,
    this.color
  });

  final String? value;
  final String? label;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color == null ? Colors.white.withValues(alpha: 0.1) : color!.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
          ],
          if (value != null) ...[
            Text(
              value!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white, height: 1.1),
            ),
          ],
          if (label != null)...[
            const SizedBox(height: 2),
            Text(
              label!,
              style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.8), height: 1.2),
            ),
          ]
        ],
      ),
    );
  }
}
