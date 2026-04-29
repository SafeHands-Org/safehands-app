import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:frontend/features/components/shared/stat_chip.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/utils/utils.dart';

class MemberDashboardHeader extends ConsumerWidget {
  const MemberDashboardHeader({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
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

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
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
          )
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