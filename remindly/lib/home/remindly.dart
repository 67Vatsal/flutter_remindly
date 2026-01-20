import '../model/reminder.dart';
import '../services/notification_service.dart';
import '../services/permission_service.dart';

class Remindly {
  Remindly._(); // prevent instance creation

  static bool _initialized = false;

  /// Call this ONCE when app starts
  static Future<void> initialize() async {
    if (_initialized) return;

    // Initialize notification system
    await NotificationService.initialize();

    // Request notification permission
    await PermissionService.requestNotificationPermission();

    _initialized = true;
  }

  /// Schedule or reschedule a reminder
  ///
  /// If a reminder with same [id] exists, it will be replaced.
  static Future<void> setReminder(Reminder reminder) async {
    await NotificationService.schedule(
      id: reminder.id,
      title: reminder.title,
      body: reminder.body,
      dateTime: reminder.dateTime,
    );
  }

  /// Cancel a specific reminder by ID
  static Future<void> cancelReminder(int id) async {
    await NotificationService.cancel(id);
  }

  /// Cancel all reminders
  static Future<void> cancelAll() async {
    await NotificationService.cancelAll();
  }
}
