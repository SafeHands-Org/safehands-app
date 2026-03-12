import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/features/dashboard/pages/dashboard_page.dart';

void main() => runApp(const TestPage());

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'SafeHands', 
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white
            )
          ), 
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          shadowColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_alert_rounded),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 4),
                        Text('Changes saved.'),
                      ],
                    ),
                    backgroundColor: Colors.purple,
                    duration: const Duration(milliseconds: 1000),
                    width: 350.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
              }
            )
          ],
      ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary.withValues(alpha: 0.55), AppTheme.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      'Welcome, Guest',
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
        body: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: 10,
          itemBuilder: (context, index) {
            final user = mockUsers[0];
            return CaregiverUserCard(user: user);
          },
        ),
        bottomNavigationBar: NavigationBar(
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
              label: 'Messages',
            ),
          ],
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


void showSnackBar(BuildContext context, String text, int msgType) {

  switch (msgType) {
    case 1:

    case 2:

    case 3:
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        
      ),
    ),
  );
}