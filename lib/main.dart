import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_staff_hound/constants.dart';
// import 'package:the_staff_hound/views/my_jobs_screen.dart';
// import 'package:the_staff_hound/views/profile_screen.dart';
// import 'package:the_staff_hound/views/notification_screen.dart';
// import 'package:the_staff_hound/views/resume_view.dart';

// import 'package:the_staff_hound/views/dashboard_screen.dart';
import 'package:the_staff_hound/views/splash_screen.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: createMaterialColor(Constants.primaryColor),
          primaryColor: Constants.primaryColor,
          backgroundColor: Constants.backgroundColor,
          fontFamily: 'Lato'),
      home: const SplashScreen(),
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
