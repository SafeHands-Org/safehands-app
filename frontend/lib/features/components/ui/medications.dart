import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/features/components/ui/root_page.dart';
import 'package:frontend/features/dashboard/pages/dashboard_page.dart';

class MedicationsPage extends StatelessWidget {
  const MedicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_UserMedication> allMeds = mockUsers.expand((user) {
      return user.medications.map((med) => _UserMedication(user: user, medication: med));
    }).toList();

    return RootPage(
      title: "Medications",
      actions: [],
      body: allMeds.isEmpty
          ? const Center(child: Text("No medications scheduled"))
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: allMeds.length,
              itemBuilder: (context, index) {
                return _MedicationCard(entry: allMeds[index]);
              },
            ),
    );
  }
}

class _UserMedication {
  final CareUser user;
  final Medication medication;

  _UserMedication({required this.user, required this.medication});
}

class _MedicationCard extends StatelessWidget {
  final _UserMedication entry;

  const _MedicationCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final med = entry.medication;
    final user = entry.user;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppTheme.primary.withOpacity(.7),
              child: const Icon(Icons.medication, size: 25),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    med.name,
                    style: AppTheme.body.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "User: ${user.name}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    "Time: ${med.time}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            _PriorityIndicator(priority: med.priority),
          ],
        ),
      ),
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
        return const Text(
          "!!",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        );
      case 2:
        return const Text(
          "!",
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}