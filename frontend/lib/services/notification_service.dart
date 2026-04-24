import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    // Required for scheduled notifications
    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    await _plugin.initialize(
      const InitializationSettings(android: androidSettings),
    );

    await _createChannel(
      id: 'med_individual',
      name: 'Medication Reminders',
      description: 'Individual medication dose notifications',
    );

    await _createChannel(
      id: 'med_grouped',
      name: 'Grouped Medication Reminders',
      description: 'Grouped medication dose notifications',
    );

    _initialized = true;
  }

  static Future<void> testNow() async {
    await _plugin.show(
      0,
      'Test Notification',
      'Notification is working 🚀',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> sendNotification({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduleTime,
    required String groupKey,
    String? payload,
  }) async {
    assert(_initialized, 'Call NotificationService.init() first.');

    await _plugin.zonedSchedule(
      notificationId,
      title,
      body,
      tz.TZDateTime.from(scheduleTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'med_individual',
          'Medication Reminders',
          groupKey: groupKey,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  static Future<void> notifyMedicineTaken({
    required int notificationId,
    required String memberName,
    required String medicineName,
    required DateTime scheduleTime,
    required String groupKey,
  }) =>
      sendNotification(
        notificationId: notificationId,
        title: 'Medication Taken',
        body: '$memberName has taken $medicineName.',
        scheduleTime: scheduleTime,
        groupKey: groupKey,
      );

  static Future<void> notifyMedicineMissed({
    required int notificationId,
    required String memberName,
    required String medicineName,
    required DateTime scheduleTime,
    required String groupKey,
  }) =>
      sendNotification(
        notificationId: notificationId,
        title: 'Medication Missed',
        body: '$memberName has missed $medicineName!',
        scheduleTime: scheduleTime,
        groupKey: groupKey,
      );

  static Future<void> notifyScheduleChange({
    required int notificationId,
    required String memberName,
    required String medicineName,
    required DateTime scheduleTime,
    required String groupKey,
  }) =>
      sendNotification(
        notificationId: notificationId,
        title: 'Schedule Change',
        body: '$memberName\'s schedule for $medicineName has changed.',
        scheduleTime: scheduleTime,
        groupKey: groupKey,
      );

  static Future<void> notifyMemberAdded({
    required int notificationId,
    required String memberName,
    required String groupKey,
  }) =>
      sendNotification(
        notificationId: notificationId,
        title: 'Member Added',
        body: '$memberName has been added to the family group!',
        scheduleTime: DateTime.now(),
        groupKey: groupKey,
      );

  static Future<void> _createChannel({
    required String id,
    required String name,
    required String description,
  }) async {
  final channel = AndroidNotificationChannel(
    id,
    name,
    description: description,
    importance: Importance.high,
  );

    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(channel);
  }
}