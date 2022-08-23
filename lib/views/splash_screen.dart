import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';
import 'package:the_staff_hound/views/dashboard_screen.dart';
import 'package:the_staff_hound/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final _networkManager = Get.put(NetworkManager());
  @override
  void initState() {
    super.initState();

    // if (_networkManager.isConnected.value) {
    Timer(const Duration(seconds: 3), () {
      if (!SharedPrefsManager.prefs
          .containsKey(SharedPrefsManager.userTokenKey)) {
        Get.off(() => LoginActivity());
      } else {
        Get.off(() => DashboardActivity());
      }
      //Get.off(() => LoginActivity());
    });
    /*   } else {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: AppText(text:  'Network Problem', textColor: Colors.black, textSize: 18, isBold: true,),

            );
          });
    } */
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: Constants.backgroundColor,
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(Constants.splashLogo),
          const SizedBox(
            height: 50,
          ),
          AppText(
            text: 'The Staff Hound',
            isBold: true,
            textSize: 30,
          )
        ],
      ),
    )));
  }
}
