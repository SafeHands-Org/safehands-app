import 'package:flutter/material.dart';

class FormProgressDots extends StatelessWidget {
  const FormProgressDots({super.key, required this.filled});

  final int filled;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i < filled ? cs.primary : cs.outlineVariant,
          ),
        ),
      )),
    );
  }
}