import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:frontend/features/components/shared/stat_chip.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:intl/intl.dart';

String formattedDate = DateFormat('EEEE, MMMM d, y').format(DateTime.now());

class DashboardHeader extends ConsumerWidget {
   const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final familyAsync = ref.watch(aggregateFamilyProvider);

    final userName = currentUser?.name ?? '';
    final greeting = userName.isNotEmpty ? 'Welcome, ${userName.split(' ').first}!' : 'Welcome!';

    final memberCount = familyAsync.maybeWhen(
      data: (fc) => '${fc.totalMembers}',
      orElse: () => '--',
    );
    final completedDoses = familyAsync.maybeWhen(
      data: (fc) => '${fc.completedDoses}',
      orElse: () => '--',
    );
    final adherencePct = familyAsync.maybeWhen(
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
      subtitle: formattedDate,
      title: 'Welcome, ${currentUser?.name}!',
    );
  }
}