import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/settings_tile.dart';
import 'package:frontend/features/components/styles/app_color.dart';

class FamilyOverviewSettings extends StatelessWidget {
  const FamilyOverviewSettings({super.key});
  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: SettingsTile(
            icon: Icons.shield_outlined,
            title: 'Manage Permissions',
            subtitle: 'Control access and roles',
            iconBg: palette.categoryBlue,
            iconColor: palette.categoryBlueContainer
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: SettingsTile(
            icon: Icons.calendar_month_outlined,
            title: 'Shared Calendar',
            subtitle: 'View all schedules',
            iconBg: palette.categoryGreen,
            iconColor: palette.categoryGreenContainer
          ),
        ),
      ],
    );
  }
}

