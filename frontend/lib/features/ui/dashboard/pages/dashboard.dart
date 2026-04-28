import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/shared/side_drawer.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/dashboard/widgets/dashboard_header.dart';
import 'package:frontend/features/ui/dashboard/widgets/family_member_card.dart';
import 'package:frontend/features/ui/dashboard/widgets/medication_card.dart';
import 'package:frontend/features/ui/dashboard/widgets/quick_action.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    if (role == UserRole.caregiver) {
      return CaregiverDashboardView();
    } else {
      return MemberDashboardView();
    }
  }
}

class CaregiverDashboardView extends ConsumerWidget {
  const CaregiverDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      drawer: const SideDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CaregiverDashboardHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Family Overview',
                          actionLabel: Icons.chevron_right,
                          onAction: () => context.go('/family'),
                        ),
                        FamilyMemberList(),
                        const SizedBox(height: 24),
                        const SectionHeader(title: 'Upcoming Doses'),
                        MedicationCardList(),
                        const SizedBox(height: 12),
                        const SectionHeader(title: 'Quick Actions'),
                        QuickActionMenu(),
                      ],
                    ),
                  ),
                ]
              )
            )
          );
        }
      )
    );
  }
}

class MemberDashboardView extends ConsumerWidget {
  const MemberDashboardView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      drawer: const SideDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemberDashboardHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(title: "Today's Progress"),
                        FamilyMemberList(),
                        const SizedBox(height: 20),
                        const SizedBox(height: 24),
                        const SectionHeader(title: 'Upcoming Doses'),
                        MedicationCardList(),
                        const SizedBox(height: 12)
                      ],
                    ),
                  ),
                ]
              )
            )
          );
        }
      )
    );
  }
}
