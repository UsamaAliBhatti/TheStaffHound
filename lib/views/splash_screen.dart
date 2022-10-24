import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/network_manager/network_state_manager.dart';
import 'package:the_staff_hound/routes/app_pages.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _networkManager = Get.put(NetworkManager());
  // final NetworkManager _networkManager = Get.find<NetworkManager>();

  @override
  void initState() {
    super.initState();

    initTimer();
  }

  initTimer() async {
    if (await _networkManager.checkInternetConnection()) {
      if (!SharedPrefsManager.prefs
          .containsKey(SharedPrefsManager.userTokenKey)) {
        Future.delayed(const Duration(milliseconds: 3000), () {
          Get.offAllNamed(Routes.LOGIN);
        });
      } else {
        Future.delayed(const Duration(milliseconds: 3000), () {
          Get.offAllNamed(Routes.DASHBOARD);
        });
      }
    
    } else {
      showExitDialog();
      // DialogHelper.showDialog();
      /* showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: AppText(text:  'Network Problem', textColor: Colors.black, textSize: 18, isBold: true,),

            );
          }); */
    }
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

  showExitDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Network Error',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'Seems Like you aren\'t connected to internet. Please connect to internet before try again.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text('Okay'))
                ]),
              ),
            )));
  }
}
