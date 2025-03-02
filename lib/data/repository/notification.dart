import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotification {
  final FlutterLocalNotificationsPlugin fnp = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try{
      const AndroidInitializationSettings isa = AndroidInitializationSettings('@mipmap/ic_launcher');
      final InitializationSettings initializationSettings = InitializationSettings(android: isa);
      await fnp.initialize(initializationSettings);
    } catch(e) {
      print("Bildirimler başlatılamadı: $e");
    }
  }

  Future<void> showNotification(int id, String message) async {
    try {
      AndroidNotificationDetails and = AndroidNotificationDetails('channel_id', 'channel_name', importance: Importance.max, priority: Priority.high);
      NotificationDetails nd = NotificationDetails(android: and);
      await fnp.show(id, 'New Message From', message, nd);
    } catch(e) {
      print("Bildirim gönderilemedi: $e");
    }
  }

}