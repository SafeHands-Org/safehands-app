import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBg,
    required this.iconColor,
    this.onTap,
    this.isDestructive = false,
    this.tileBg
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback? onTap;
  final bool isDestructive;
  final Color? tileBg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDestructive ? cs.errorContainer : tileBg ?? cs.surface,
          borderRadius: AppRadius.borderRadiusXl,
          border: Border.all(
            color: isDestructive ? cs.error.withValues(alpha: 0.4) : cs.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDestructive ? cs.errorContainer : iconBg,
                borderRadius: AppRadius.borderRadiusMd,
              ),
              child: Icon(
                icon,
                color: isDestructive ? cs.error : iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600,
                      color: isDestructive ? cs.onErrorContainer : cs.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDestructive ? cs.error : cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}