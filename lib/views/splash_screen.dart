import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Get.off(() => const LoginActivity());
    });
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
