import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';

class AppGradientHeader extends StatelessWidget {
  const AppGradientHeader({
    super.key,
    required this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.profileRow,
    this.statsRow,
  });

  final Widget leading;
  final Widget? trailing;
  final String? title;
  final String? subtitle;
  final Widget? profileRow;
  final Widget? statsRow;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      decoration: BoxDecoration(gradient: palette.header),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [leading, ?trailing],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (profileRow != null) ...[profileRow!, const SizedBox(height: 12)],
                    if (title != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (subtitle != null) ...[
                          Text(subtitle!, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.9))),
                          const SizedBox(height: 2),
                        ],
                        Text(title!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
                      ],
                    ),
                    if (statsRow != null) ...[const SizedBox(height: 16), statsRow!],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.badge = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white, size: 24),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        if (badge) Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              color: cs.error,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
