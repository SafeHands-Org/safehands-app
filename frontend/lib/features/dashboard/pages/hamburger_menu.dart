import 'package:flutter/material.dart';
import 'package:frontend/styles/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeHands'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primary.withValues(alpha: 0.55),
                    AppTheme.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'SafeHands',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Welcome, User',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            _MenuTile(icon: Icons.dashboard, label: 'Dashboard'),
            _MenuTile(icon: Icons.group, label: 'Family Members'),
            _MenuTile(icon: Icons.medication, label: 'Medications'),
            _MenuTile(icon: Icons.alarm, label: 'Reminders'),
            _MenuTile(icon: Icons.qr_code, label: 'Invite Family'),

            const Divider(),

            _MenuTile(icon: Icons.settings, label: 'Account'),
            _MenuTile(icon: Icons.logout, label: 'Logout'),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Welcome to SafeHands!',
          style: AppTheme.subtitle,
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MenuTile({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        leading: Icon(icon, color: AppTheme.primary),
        title: Text(label, style: AppTheme.body),
        onTap: () {
          Navigator.pop(context); // closes drawer
        },
      ),
    );
  }
}