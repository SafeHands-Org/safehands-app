import 'package:flutter/material.dart';
import 'package:frontend/services/notification_service.dart';

class NotificationTestPage extends StatelessWidget {
  const NotificationTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medication Notifications Test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () {
                NotificationService.sendNotification(
                  notificationId: 1,
                  title: 'Instant Test',
                  body: 'Notifications are working!',
                  scheduleTime: DateTime.now(),
                  groupKey: 'test_group',
                );
              },
              child: const Text("Instant Test"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                NotificationService.sendNotification(
                  notificationId: 2,
                  title: "Medication Reminder",
                  body: "Take your prescribed medicine",
                  scheduleTime: DateTime.now().add(
                    const Duration(seconds: 10),
                  ),
                  groupKey: "med_test",
                );
              },
              child: const Text("Schedule in 10 seconds"),
            ),
          ],
        ),
      ),
    );
  }
}