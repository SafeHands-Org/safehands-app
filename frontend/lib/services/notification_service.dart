import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static final Map<int, Timer> _timers = {};

  static Future<void> init() async {
    if (_initialized) return;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(
          android: androidSettings, iOS: iosSettings),
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _createChannel(
      id: 'med_reminders',
      name: 'Medication Reminders',
      description: 'Medication dose reminder notifications',
    );

    _initialized = true;
  }


  static Future<void> _show({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'med_reminders',
          'Medication Reminders',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  static Future<void> scheduleOnce({
    required int id,
    required String title,
    required String body,
    int seconds = 10,
    String? payload,
  }) async {
    assert(_initialized, 'Call NotificationService.init() first.');

    _timers[id]?.cancel();

    _timers[id] = Timer(Duration(seconds: seconds), () async {
      await _show(id: id, title: title, body: body, payload: payload);
      _timers.remove(id);
    });
  }

  static Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? payload,
  }) async {
    assert(_initialized, 'Call NotificationService.init() first.');

    _timers[id]?.cancel();

    final now = DateTime.now();
    var next = DateTime(now.year, now.month, now.day, hour, minute);
    if (next.isBefore(now)) {
      next = next.add(const Duration(days: 1));
    }

    final delay = next.difference(now);

    _timers[id] = Timer(delay, () async {
      await _show(id: id, title: title, body: body, payload: payload);
      _timers.remove(id);
      scheduleDaily(
          id: id, title: title, body: body,
          hour: hour, minute: minute, payload: payload);
    });
  }

  static Future<void> cancelScheduled(int id) async {
    _timers[id]?.cancel();
    _timers.remove(id);
    await _plugin.cancel(id);
  }

  static Future<void> cancelAll() async {
    for (final t in _timers.values) {
      t.cancel();
    }
    _timers.clear();
    await _plugin.cancelAll();
  }


  static Future<void> notifyMedicineTaken({
    required int notificationId,
    required String memberName,
    required String medicineName,
    required String groupKey,
  }) =>
      _show(
        id: notificationId,
        title: 'Medication Taken ✓',
        body: '$memberName has taken $medicineName.',
      );

  static Future<void> notifyMedicineMissed({
    required int notificationId,
    required String memberName,
    required String medicineName,
    required String groupKey,
  }) =>
      _show(
        id: notificationId,
        title: 'Medication Missed ⚠️',
        body: '$memberName has missed $medicineName!',
      );

  static Future<void> notifyScheduleChange({
    required int notificationId,
    required String memberName,
    required String medicineName,
    required String groupKey,
  }) =>
      _show(
        id: notificationId,
        title: 'Schedule Changed',
        body: "$memberName's schedule for $medicineName has changed.",
      );

  static Future<void> notifyMemberAdded({
    required int notificationId,
    required String memberName,
    required String groupKey,
  }) =>
      _show(
        id: notificationId,
        title: 'Member Added',
        body: '$memberName has been added to the family group!',
      );

  static Future<void> sendNotification({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduleTime,
    required String groupKey,
    String? payload,
  }) async {
    assert(_initialized, 'Call NotificationService.init() first.');
    final delay = scheduleTime.difference(DateTime.now());
    if (delay.isNegative) {
      await _show(id: notificationId, title: title, body: body, payload: payload);
    } else {
      _timers[notificationId]?.cancel();
      _timers[notificationId] = Timer(delay, () async {
        await _show(id: notificationId, title: title, body: body, payload: payload);
        _timers.remove(notificationId);
      });
    }
  }


  static Future<void> _createChannel({
    required String id,
    required String name,
    required String description,
  }) async {
    final channel = AndroidNotificationChannel(
      id,
      name,
      description: description,
      importance: Importance.max,
      playSound: true,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}