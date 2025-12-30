import 'package:awesome_notifications/awesome_notifications.dart';

class PermissionService {
  PermissionService._();

  /// Requests notification permission if not already granted
  ///
  /// Returns `true` if permission is granted, otherwise `false`
  static Future<bool> requestNotificationPermission() async {
    final isAllowed =
    await AwesomeNotifications().isNotificationAllowed();

    if (isAllowed) return true;

    return await AwesomeNotifications()
        .requestPermissionToSendNotifications();
  }
}
