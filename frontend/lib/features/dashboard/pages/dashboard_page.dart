import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/features/components/ui/character_card.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/features/auth/controller/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/components/ui/root_page.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardPage({super.key});
  
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  void _submit() async {
    final controller = context.read<AuthController>();
    try {
      await controller.logout();
      context.go("/auth");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logout failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RootPage(
      title: "Dashboard",
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: _submit,
        )
      ],
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: mockUsers.length,
        itemBuilder: (context, index) {
          final user = mockUsers[index];
          return CaregiverUserCard(user: user);
        },
      ),
    );
  }
}

//user card
class CaregiverUserCard extends StatelessWidget {
  final CareUser user;

  const CaregiverUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterCard(user: user)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              _UserProfile(user: user),
              const SizedBox(width: 15),
              Expanded(child: _MedicationList(user: user)),
              const SizedBox(width: 15),
              _ClockTimeline(user: user),
            ],
          ),
        ),
      ),
    );
  }
}

//left side: user profile
class _UserProfile extends StatelessWidget {
  final CareUser user;
  const _UserProfile({required this.user});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppTheme.primary.withOpacity(.7),
          child: const Icon(Icons.person),
        ),
        const SizedBox(height: 10),
        Text(
          user.name,
          style: AppTheme.body.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

//center: medication list

class _MedicationList extends StatelessWidget {
  final CareUser user;

  const _MedicationList({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: user.medications.map((med) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(child: Text(med.name)),
              _PriorityIndicator(priority: med.priority),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  final int priority;

  const _PriorityIndicator({required this.priority});

  @override
  Widget build(BuildContext context) {
    switch (priority) {
      case 1:
        return const Text("!!",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
      case 2:
        return const Text("!",
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold));
      default:
        return const SizedBox.shrink();
    }
  }
}

//right side: clock/timeline
class _ClockTimeline extends StatelessWidget {
  final CareUser user;

  const _ClockTimeline({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: user.medications.map((med) {
        return Column(
          children: [
            Icon(
              Icons.circle,
              size: 10,
              color: _priorityColor(med.priority),
            ),
            Text(
              med.time,
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(height: 6),
          ],
        );
      }).toList(),
    );
  }

  Color _priorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

//mock models
class CareUser {
  final String name;
  final List<Medication> medications;

  CareUser({required this.name, required this.medications});
}
class Medication {
  final String name;
  final int priority;
  final String time;

  Medication({
    required this.name,
    required this.priority,
    required this.time,
  });
}
//mock data
final mockUsers = [
  CareUser(
    name: "John D.",
    medications: [
      Medication(name: "Insulin", priority: 1, time: "08:00"),
      Medication(name: "Aspirin", priority: 2, time: "12:00"),
      Medication(name: "Vitamin D", priority: 3, time: "20:00"),
    ],
  ),
  CareUser(
    name: "Maria S.",
    medications: [
      Medication(name: "Blood Pressure Med", priority: 1, time: "09:00"),
      Medication(name: "Calcium", priority: 3, time: "18:00"),
      Medication(name: "Insulin", priority: 1, time: "08:00"),
      Medication(name: "Aspirin", priority: 2, time: "12:00"),
      Medication(name: "Vitamin D", priority: 3, time: "20:00"),
      Medication(name: "Iron", priority: 3, time: "12:00"),
      Medication(name: "Vitamin B12", priority: 3, time: "20:00"),
    ],
  ),
];