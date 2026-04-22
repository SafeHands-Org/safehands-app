import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/stat_chip.dart';
import 'package:frontend/features/components/styles/app_dim.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:go_router/go_router.dart';

class FamilyOverviewHeaderWrapper extends ConsumerWidget {
  const FamilyOverviewHeaderWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(aggregateFamilyProvider);

    final familyName = familyAsync.maybeWhen(
      data: (fc) => fc.family.name,
      orElse: () => 'Your Family',
    );
    final memberCount = familyAsync.maybeWhen(
      data: (fc) => '${fc.totalMembers}',
      orElse: () => '--',
    );
    final activeMeds = familyAsync.maybeWhen(
      data: (fc) => '${fc.activeMeds}',
      orElse: () => '--',
    );
    final adherencePct = familyAsync.maybeWhen(
      data: (fc) => '${fc.adherencePercentage}%',
      orElse: () => '--',
    );

    return AppGradientHeader(
      leading: HeaderIconButton(
        icon: Icons.arrow_back,
        onPressed: () => context.go('/'),
      ),
      trailing: HeaderIconButton(
        icon: Icons.settings_outlined,
        onPressed: () => context.go('/settings'),
      ),
      title: 'Family Overview',
      subtitle: familyName,
      statsRow: Row(
        children: [
          Expanded(child: StatChip(value: memberCount, label: 'Total Members')),
          const SizedBox(width: 12),
          Expanded(child: StatChip(value: activeMeds, label: 'Active Meds')),
          const SizedBox(width: 12),
          Expanded(child: StatChip(value: adherencePct, label: 'Adherence')),
        ],
      ),
    );
  }
}

class EmptyHeader extends ConsumerWidget {
  const EmptyHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppGradientHeader(
      leading: HeaderIconButton(
        icon: Icons.arrow_back,
        onPressed: () => context.pop(),
      ),
      title: 'Family Overview',
    );
  }
}

class ProfileHeaderSection extends StatelessWidget {
  final String name, relationship, age;
  final int medCount;

  const ProfileHeaderSection({super.key,
    required this.name, required this.relationship,
    required this.age, required this.medCount,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return AppGradientHeader(
      leading: HeaderIconButton(icon: Icons.arrow_back, onPressed: () => context.go('/')),
      trailing: HeaderIconButton(icon: Icons.edit_outlined, onPressed: () {}),
      profileRow: Row(
        children: [
          UserAvatar(name: name, radius: 40),
          const SizedBox(width: AppSpacing.base),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: cs.onPrimary)),
                Text(relationship, style: tt.bodyMedium?.copyWith(color: cs.onPrimary.withValues(alpha: 0.8))),
              ],
            ),
          ),
        ],
      ),
      statsRow: Row(
        children: [
          Expanded(child: StatChip(value: age, label: 'Age')),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: StatChip(value: '$medCount Active', label: 'Medications')),
        ],
      ),
    );
  }
}