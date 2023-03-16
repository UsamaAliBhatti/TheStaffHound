import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications_plus/flutter_local_notifications_plus.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/routes/app_pages.dart';

class NotificationManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

/*   static const  IOSInitializationSettings _initializationSettingsIOS =  IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true); */

  static void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      Get.toNamed(Routes.NOTIFICATIONS);
    });
  }

  static showNotification(RemoteMessage message) async {
    try {
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'notification_channel', 'notificationChannel', 'notification_channel',
          importance: Importance.max, priority: Priority.high);
      //var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, platformChannelSpecifics,
          payload: message.data['job_id'].toString());
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
