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

class LoadingMetricCard extends StatelessWidget {
  const LoadingMetricCard({
    super.key,
    required this.loadingWidget
  });

  final Widget loadingWidget;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Color secondary = cs.surface.withValues(red: 0.96, green: 0.96, blue: 0.96);
    return SizedBox(
      height: 144,
      child: Card(
        elevation: 5.0,
        shadowColor: cs.shadow,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: secondary, borderRadius: BorderRadius.circular(12)),
                        child: const SizedBox(height: 20.0, width: 20.0,)
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 20.0,
                    width: 120.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: const BorderRadius.only(topLeft: AppRadius.sm, topRight: AppRadius.sm, bottomRight: AppRadius.sm
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 36.0,
                    width: 40.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: BorderRadius.only(topLeft: AppRadius.sm, topRight: AppRadius.sm, bottomRight: AppRadius.sm
                        )
                      )
                    )
                  ),
                ],
              ),
             loadingWidget
            ],
          )
        ),
      ),
    );
  }
}
