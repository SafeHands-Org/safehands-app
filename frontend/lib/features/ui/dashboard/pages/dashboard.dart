import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/shared/side_drawer.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/dashboard/widgets/dashboard_header.dart';
import 'package:frontend/features/ui/dashboard/widgets/family_member_card.dart';
import 'package:frontend/features/ui/dashboard/widgets/medication_card.dart';
import 'package:frontend/features/ui/dashboard/widgets/overview_section.dart';
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
      return UserDashboardView();
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
                  DashboardHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Family Overview',
                          actionLabel: 'View All',
                          onAction: () => context.go('/family'),
                        ),
                        FamilyMemberList(),
                        const SizedBox(),

                        SectionHeader(title: 'Overview', actionLabel: 'Details', onAction: () => context.go('/family')),
                        OverviewSection(),
                        const SizedBox(height: 24),
                        const SectionHeader(title: 'Upcoming Doses', actionLabel: 'Schedule'),

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



class UserDashboardView extends ConsumerWidget {
  const UserDashboardView({super.key});

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
                  DashboardHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Family Overview',
                          actionLabel: 'View All',
                          onAction: () => context.go('/family'),
                        ),
                        FamilyMemberList(),
                        const SizedBox(),

                        const SectionHeader(title: 'Overview', actionLabel: 'Details'),
                        OverviewSection(),
                        const SizedBox(height: 24),
                        const SectionHeader(title: 'Upcoming Doses', actionLabel: 'Schedule'),

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
