import 'dart:developer' as developer;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:frontend/routes/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void _onBackgroundNotificationTap(NotificationResponse response) {
  developer.log(
    'Background notification tapped — id: ${response.id}, payload: ${response.payload}',
    name: 'NotificationService',
  );
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    tz.initializeTimeZones();
    final TimezoneInfo timeZoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneInfo.identifier));

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        developer.log(
          'Foreground notification tapped — id: ${response.id}, payload: ${response.payload}',
          name: 'NotificationService',
        );
        final payload = response.payload;
        if (payload == null) return;

        final params = Uri.splitQueryString(payload);
        final fmId = params['fmId'];
        final fmmId = params['fmmId'];

        if (fmId != null && fmmId != null) {
          rootNavigatorKey.currentContext?.go('/assignment/$fmId/logs/$fmmId');
        }
      },
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationTap,
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
      id: id,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
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
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      notificationDetails: const NotificationDetails(
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
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
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local, now.year, now.month, now.day, hour, minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,  // this is what makes it repeat daily
      payload: payload,
    );
  }

  static Future<void> cancelScheduled(int id) async {
    await _plugin.cancel(id: id);
  }

  static Future<void> cancelAll() async {
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
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduleTime, tz.local);
    await _plugin.zonedSchedule(
      id: notificationId,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
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