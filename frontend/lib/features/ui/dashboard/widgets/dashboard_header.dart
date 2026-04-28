import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:frontend/features/components/shared/stat_chip.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/providers/family_members/family_member_providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/utils/utils.dart';

class MemberDashboardHeader extends ConsumerWidget {
  const MemberDashboardHeader({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    final membershipAsync = ref.watch(memberByIdProvider(currentUser!.id!));
    final memberAsync = ref.watch(aggregateMemberProvider(membershipAsync.value!.id));

    final userName = currentUser.name ?? '';
    final greeting = userName.isNotEmpty ? 'Welcome, ${userName.split(' ').first}!' : 'Welcome!';

    final totalMeds = memberAsync.maybeWhen(
      data: (fc) => fc.assignments.length,
      orElse: () => 0,
    );

    final totalActive = memberAsync.maybeWhen(
      data: (fc) => fc.fmms.where((e) => e.isActive).length,
      orElse: () => 0,
    );

    final completedDoses = memberAsync.maybeWhen(
      data: (fc) => '${fc.todaysTaken}',
      orElse: () => '--',
    );

    final adherencePct = memberAsync.maybeWhen(
      data: (fc) => '${fc.adherencePercentage}%',
      orElse: () => '--',
    );

    return AppGradientHeader(
      leading: HeaderIconButton(
        icon: Icons.menu,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      trailing: Row (
        children: [
          HeaderIconButton(
            icon: Icons.supervisor_account_outlined,
            onPressed: () {},
            badge: false,
          ),
        ]
      ),
      title: greeting,
      statsRow: Row(
        children: [
          if (totalMeds != 0)...[
            Expanded(
              child: StatChip(
                icon: Icons.people_outline,
                value: '$totalActive',
                label: 'Current Assignments',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatChip(
                icon: Icons.medication_outlined,
                value: completedDoses,
                label: 'Taken Today',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatChip(
                icon: Icons.check_circle_outline,
                value: adherencePct,
                label: 'Adherence',
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class CaregiverDashboardHeader extends ConsumerWidget {
  const CaregiverDashboardHeader({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final memberAsync = ref.watch(aggregateFamilyProvider);

    final userName = currentUser?.name ?? '';
    final greeting = userName.isNotEmpty ? 'Welcome, ${userName.split(' ').first}!' : 'Welcome!';

    final memberCount = memberAsync.maybeWhen(
      data: (fc) => '${fc.totalMembers}',
      orElse: () => '--',
    );
    final completedDoses = memberAsync.maybeWhen(
      data: (fc) => '${fc.completedDoses}',
      orElse: () => '--',
    );
    final adherencePct = memberAsync.maybeWhen(
      data: (fc) => '${fc.adherencePercentage}%',
      orElse: () => '--',
    );

    return AppGradientHeader(
      leading: HeaderIconButton(
        icon: Icons.menu,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      trailing: Row (
        children: [
          HeaderIconButton(
            icon: Icons.supervisor_account_outlined,
            onPressed: () {},
            badge: false,
          ),
        ]
      ),
      title: greeting,
      statsRow: Row(
        children: [
          Expanded(
            child: StatChip(
              icon: Icons.people_outline,
              value: memberCount,
              label: 'Members',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatChip(
              icon: Icons.medication_outlined,
              value: completedDoses,
              label: 'Taken Today',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatChip(
              icon: Icons.check_circle_outline,
              value: adherencePct,
              label: 'Adherence',
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyDashboardHeader extends ConsumerWidget {
  const EmptyDashboardHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return AppGradientHeader(
      leading: HeaderIconButton(
        icon: Icons.menu,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      subtitle: headerFormat(DateTime.now()),
      title: 'Welcome, ${currentUser?.name}!',
    );
  }
}