import 'dart:async';

import 'package:get/get.dart';
import 'package:the_staff_hound/helper/dialog_helper.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';
import 'package:the_staff_hound/views/dashboard_screen.dart';

import '../network_manager/network_state_manager.dart';
import '../views/login_screen.dart';

class SplashController extends GetxController {
  final NetworkManager _networkManager = Get.put(NetworkManager());

  @override
  void onInit() async {
    if (await _networkManager.checkInternetConnection()) {
      Timer(const Duration(seconds: 3), () {
        if (!SharedPrefsManager.prefs
            .containsKey(SharedPrefsManager.userTokenKey)) {
          Get.off(() => LoginActivity());
        } else {
          Get.off(() => DashboardActivity());
        }
      });
    } else {
      // Fluttertoast.showToast(
      //     msg: 'Seems like you aren\'t connected to internet');
      DialogHelper.showDialog();
      /* showDialog(
          context: Get.context!,
          builder: (_) {
            return AlertDialog(
              title: AppText(
                text: 'Network Problem',
                textColor: Colors.black,
                textSize: 18,
                isBold: true,
              ),
            );
          }); */

      super.onInit();
    }
  }

  @override
  void dispose() {
    _networkManager.dispose();
    super.dispose();
  }
}
