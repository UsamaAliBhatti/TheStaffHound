import 'dart:async';

import 'package:get/get.dart';

class EmailOTPController extends GetxController {
  var otpText = ''.obs;
  late Timer timer;
  var enableResend = false.obs;
  var seconds = 30.obs;
  var status = ''.obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    // status.value = Get.arguments[0]['status'];

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds.value != 0) {
        seconds.value--;
        enableResend.value = false;
      } else {
        enableResend.value = true;
      }
    });
  }

  getCode() {
    if (enableResend.isTrue) {
      enableResend.value = false;
      seconds.value = 30;
    }
  }
}
