import 'dart:async';

import 'package:get/get.dart';

import '../api_services/rest_api_services.dart';

class EmailOTPController extends GetxController {
  var otpText = ''.obs;
  late Timer timer;
  var enableResend = false.obs;
  var seconds = 30.obs;
  // var status = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    email.value = Get.arguments['email'];
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds.value != 0) {
        seconds.value--;
        enableResend.value = false;
      } else {
        enableResend.value = true;
      }
    });
  }

  verifyOTP(String otp) async {
    if (otp.isNotEmpty) {
      await RestApiServices.verifyEmailOTP(email.value, otp);
    }
  }

  getCode() async {
    if (enableResend.isTrue) {
      enableResend.value = false;
      seconds.value = 30;
      await RestApiServices.sendEmailForOTP(email.value);
    }
  }
}
