import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:go_router/go_router.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  static const _menuItems = <({IconData icon, String label, String path})>[
    (icon: Icons.home_outlined,             label: 'Dashboard',   path: '/'),
    (icon: Icons.medical_services_outlined, label: 'Medications', path: '/medications'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final palette = context.palette;
    final user = ref.watch(currentUserProvider);

    return Drawer(
      width: 320,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: palette.header,
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white, size: 24),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        UserAvatar(
                          name: user?.name ?? '',
                          radius: 32,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? '',
                                style: TextStyle(
                                  color: Colors.white, fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                user?.email ?? '',
                                style: TextStyle(
                                  color: Colors.white70, fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            )
          ),
          Expanded(
            child:
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: _menuItems
                .map((item) => _MenuItem(item: item))
                .toList(),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () async {
                  final auth = ref.read(authProvider.notifier);
                  final container = ProviderScope.containerOf(context);
                  final familyRepo = ref.read(familyRepositoryProvider);
                  final invitationRepo = ref.read(invitationRepositoryProvider);
                  final familyMemberRepo = ref.read(familyMemberRepositoryProvider);
                  final assignmentRepo = ref.read(assignmentRepositoryProvider);
                  final medicationRepo = ref.read(medicationRepositoryProvider);
                  final scheduleRepo = ref.read(scheduleRepositoryProvider);
                  final adherenceRepo = ref.read(adherenceRepositoryProvider);

                  await auth.logout();

                  familyRepo.clearCurrentFamily();
                  familyRepo.clearCache();
                  invitationRepo.clearInviteToken();
                  invitationRepo.clearCache();
                  familyMemberRepo.clearCache();
                  assignmentRepo.clearCache();
                  medicationRepo.clearCache();
                  scheduleRepo.clearCache();
                  adherenceRepo.clearCache();

                  container.invalidate(familiesProvider);
                  container.invalidate(invitationsProvider);
                  container.invalidate(familyMembersProvider);
                  container.invalidate(assignmentsProvider);
                  container.invalidate(medicationsProvider);
                  container.invalidate(schedulesProvider);
                  container.invalidate(adherencesProvider);

                  if (context.mounted) context.go('/login');
                },
                icon: Icon(Icons.logout, color: cs.error),
                label: Text(
                  'Log Out',
                  style: TextStyle(color: cs.error, fontWeight: FontWeight.w600),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: cs.errorContainer,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: cs.error)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.item});
  final ({IconData icon, String label, String path}) item;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(item.icon, color: cs.onSurfaceVariant, size: 22),
      title: Text(
        item.label,
        style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: cs.onSurface,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (item.path.isNotEmpty) context.push(item.path);
      },
      hoverColor: cs.primaryContainer,
    );
  }
}