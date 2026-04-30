import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';

class HealthMetricCard extends StatelessWidget {
  const HealthMetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
    required this.change,
    required this.iconBg,
    required this.iconColor,
  });

  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final int change;
  final Color iconBg;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final isPositive = change > 0;
    final palette = context.palette;

    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBg, borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                if (change != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPositive ? palette.categoryGreen : cs.onErrorContainer,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '${isPositive ? '+' : ''}$change%',
                      style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w600,
                        color: isPositive ? palette.categoryGreen : cs.onError,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: tt.bodyMedium),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children:
                [
                  Text(
                    value,
                    style: tt.headlineLarge
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit,
                    style: tt.bodyMedium,
                  ),
                ]

            ),
          ]
        ),
      )
    );
  }
}
