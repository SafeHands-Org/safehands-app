import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:go_router/go_router.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  static const _menuItems = <({IconData icon, String label, String path})>[
    (icon: Icons.home_outlined,            label: 'Dashboard',           path: '/'),
    (icon: Icons.people_outline,           label: 'Medications',         path: '/medications'),
    (icon: Icons.description_outlined,     label: 'Health Summaries',    path: ''),
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
                                user!.email!,
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
            child: ListView(
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
                onPressed: () => (ref.read(authProvider.notifier).logout, ref.refresh(authProvider)),
                icon: Icon(Icons.logout, color: cs.error),
                label: Text(
                  'Log Out',
                  style: TextStyle(color: cs.error, fontWeight: FontWeight.w600),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: cs.errorContainer,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        if (item.path.isNotEmpty) context.go(item.path);
      },
      hoverColor: cs.primaryContainer,
    );
  }
}