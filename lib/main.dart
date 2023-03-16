import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/network_manager/network_binding.dart';
import 'package:the_staff_hound/notification_handler/notification_manager.dart';
import 'package:the_staff_hound/routes/app_pages.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print(message.notification!.title);
    print(message.notification!.body);
/*     final title = message.notification!.title;
    final body = message.notification!.body; */

    Get.toNamed(Routes.NOTIFICATIONS);
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalize).join(" ");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationManager.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification != null) {
      /*  final title = message.notification!.title;
      final body = message.notification!.body; */
      /*  if (message.data['notify_type'] == 'new_job') {
        Get.to(() => JobDetailsActivity(), arguments: [
          {"jobId": message.data['job_id']}
        ]);
      } */
      NotificationManager.showNotification(message);
    }
  });
  FirebaseMessaging.instance.getInitialMessage().then((message) {});
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    Get.toNamed(Routes.NOTIFICATIONS);
  });

  await SharedPrefsManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: NetworkBinding(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
          primaryColor: Constants.primaryColor,
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: createMaterialColor(Constants.primaryColor))
              .copyWith(background: Constants.backgroundColor)),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
