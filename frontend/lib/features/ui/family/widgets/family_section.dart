import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class FamilyMembersDetailSection extends ConsumerWidget {
  const FamilyMembersDetailSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fidAsync = ref.watch(currentFamilyProvider);
    final fid = fidAsync.value ?? '';
    final membersAsync = ref.watch(aggregateMembershipsProvider(fid));

    return switch (membersAsync) {
      AsyncLoading() => const LoadingCard(),
      AsyncError(:final error) => ErrorCard(message: error.toString()),
      AsyncData(:final value) when value.isEmpty => const EmptyCard(
        message: 'No family members found.', icon: Icons.people_outline),
      AsyncData(:final value) => Column(
        children: value.map(
          (member) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FamilyMemberDetailCard(member: member),
          ),
        ).toList(),
      ),
    };
  }
}

class _FamilyMemberDetailCard extends StatelessWidget {
  const _FamilyMemberDetailCard({required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final palette = context.palette;

    return InkWell(
      onTap: () {
        context.push('/family/members/${member.id}');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserAvatar(name: member.name, radius: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          member.name,
                          style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700)
                        ),
                        if (member.isAdmin) Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: palette.categoryBlueContainer,
                            borderRadius: AppRadius.borderRadiusPill
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                size: 12, color: palette.categoryBlue
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Admin',
                                style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w600,
                                  color: palette.categoryBlue
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _ContactRow(icon: Icons.calendar_today_outlined, text: 'Joined ${member.joinDate}'),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: palette.categoryBlueContainer, borderRadius: AppRadius.borderRadiusMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Medications',
                            style: TextStyle(
                              fontSize: 11,
                              color: cs.outline
                            ),
                          ),
                          Text(
                            '${member.activeMedCount}',
                            style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700,
                              color: palette.categoryBlue
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: palette.categoryGreenContainer, borderRadius: AppRadius.borderRadiusMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status',
                            style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                          ),
                          Text(
                            'Active',
                            style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.go('/profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.tertiary,
                        foregroundColor: cs.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        elevation: 0,
                      ),
                      child: const Text('View Profile'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(borderRadius: AppRadius.borderRadiusCard),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_outlined, color: cs.onSurfaceVariant, size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 16, color: cs.outline),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
