import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:go_router/go_router.dart';

class QuickActionMenu extends StatelessWidget {
  const QuickActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      children:[
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.medication_outlined,
                label: 'Add Medication',
                gradient: palette.gradientBlue,
                onPressed: () => context.push('/medication/new'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.timer,
                label: 'New Schedule',
                gradient: palette.header,
                onPressed: () => context.push('/medication/schedule'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.medical_services_outlined,
                label: 'Health Summaries',
                gradient: palette.gradientGreen,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.description_outlined,
                label: 'Adherence Logs',
                gradient: palette.gradientOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.gradient,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final Gradient gradient;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: AppRadius.borderRadiusCard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}