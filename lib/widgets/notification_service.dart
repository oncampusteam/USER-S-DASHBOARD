import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future init() async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: android);

    await _notifications.initialize(settings);
  }

  static Future show({
  required String title,
  required String body,
    }) async {
      const AndroidNotificationDetails android = AndroidNotificationDetails(
        'main_channel',
        'Main Channel',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails details =
          NotificationDetails(android: android);

      await _notifications.show(
        0,
        title,
        body,
        details,
      );
    }

}
