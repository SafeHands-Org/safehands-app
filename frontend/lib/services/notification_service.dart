import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;
  static final Map<String, List<_PendingNotification>> _queue = {};
  static final Set<String> _flushTimers = {};

  static Future<void> init() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);

    await _plugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

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

  static Future<void> sendNotification({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduleTime,
    required String groupKey,
    String? payload,
  }) async {
    assert(_initialized, 'Call NotificationService.init() first.');

    _enqueue(
      notificationId: notificationId,
      title: title,
      body: body,
      scheduleTime: scheduleTime,
      groupKey: groupKey,
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

  static void _enqueue({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduleTime,
    required String groupKey,
    String? payload,
  }) {
    final bucketKey =
        '${groupKey}_${scheduleTime.year}${scheduleTime.month}${scheduleTime.day}'
        '${scheduleTime.hour}${scheduleTime.minute}';

    _queue.putIfAbsent(bucketKey, () => []).add(
          _PendingNotification(
            notificationId: notificationId,
            title: title,
            body: body,
            groupKey: groupKey,
            payload: payload,
          ),
        );

    if (!_flushTimers.contains(bucketKey)) {
      _flushTimers.add(bucketKey);
      Future.delayed(const Duration(seconds: 2), () => _flush(bucketKey));
    }
  }

  static Future<void> _flush(String bucketKey) async {
    final pending = _queue.remove(bucketKey);
    _flushTimers.remove(bucketKey);

    if (pending == null || pending.isEmpty) return;

    if (pending.length == 1) {
      await _showNotification(
        notificationId: pending.first.notificationId,
        title: pending.first.title,
        body: pending.first.body,
        channelId: 'med_individual',
        groupKey: pending.first.groupKey,
        payload: pending.first.payload,
      );
    } else {
      final lines = pending.map((n) => n.body).toList();

      for (final n in pending) {
        await _showNotification(
          notificationId: n.notificationId,
          title: n.title,
          body: n.body,
          channelId: 'med_grouped',
          groupKey: n.groupKey,
        );
      }

      await _showInboxNotification(
        notificationId: bucketKey.hashCode,
        title: '${pending.length} Medications',
        lines: lines,
        groupKey: pending.first.groupKey,
      );
    }
  }

  static Future<void> _showNotification({
    required int notificationId,
    required String title,
    required String body,
    required String channelId,
    required String groupKey,
    String? payload,
  }) async {
    await _plugin.show(
      notificationId,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelId == 'med_individual'
              ? 'Medication Reminders'
              : 'Grouped Medication Reminders',
          groupKey: groupKey,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }

  static Future<void> _showInboxNotification({
    required int notificationId,
    required String title,
    required List<String> lines,
    required String groupKey,
  }) async {
    await _plugin.show(
      notificationId,
      title,
      lines.join(', '),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'med_grouped',
          'Grouped Medication Reminders',
          styleInformation: InboxStyleInformation(
            lines,
            summaryText: '${lines.length} medications',
          ),
          groupKey: groupKey,
          setAsGroupSummary: true,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
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
      importance: Importance.high,
    );
    await _plugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  }
}

class _PendingNotification {
  final int notificationId;
  final String title;
  final String body;
  final String groupKey;
  final String? payload;

  _PendingNotification({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.groupKey,
    this.payload,
  });
}