import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  NotificationService._();

  static const String _channelKey = 'remindly_channel';

  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: _channelKey,
          channelName: 'Reminders',
          channelDescription: 'Reminder notifications',
          importance: NotificationImportance.High,
          channelShowBadge: true,
          defaultColor: Color(0xFF2196F3),
          ledColor: Color(0xFF2196F3),
          playSound: true,
          enableVibration: true,
        ),
      ],
      debug: false,
    );
  }

  /// Schedule or replace a notification
  static Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    // ❗ Do not schedule past reminders
    if (dateTime.isBefore(DateTime.now())) return;

    // Cancel existing notification with same ID (edit safety)
    await AwesomeNotifications().cancel(id);

    final isAllowed =
    await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: _channelKey,
        title: title,
        body: body.isEmpty ? 'Reminder' : body,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar.fromDate(
        date: dateTime,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );
  }

  static Future<void> cancel(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> cancelAll() async {
    await AwesomeNotifications().cancelAll();
  }
}
