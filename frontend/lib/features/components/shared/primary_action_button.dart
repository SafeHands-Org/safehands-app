import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.buttonIcon,
  });

  static const TextStyle buttonTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);

  final VoidCallback onPressed;
  final String buttonText;
  final Widget buttonIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        label: Text(buttonText, style: buttonTextStyle),
        icon: buttonIcon,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusPill)
        ),
      ),
    );
  }
}

class SecondaryActionButton extends StatelessWidget {
  const SecondaryActionButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonIcon,
  });

  static const TextStyle buttonTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);

  final VoidCallback onPressed;
  final String buttonText;
  final Widget? buttonIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.0,
      child: ElevatedButton.icon(
        label: Text(buttonText, style: buttonTextStyle),
        icon: buttonIcon,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusPill),
        ),
      ),
    );
  }
}