import 'dart:async';

import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/auth_service/auth_api.dart';
import 'package:the_staff_hound/routes/app_pages.dart';



class EmailOTPController extends GetxController {
  var otpText = ''.obs;
  late Timer timer;
  var enableResend = false.obs;
  var seconds = 30.obs;
  // var status = ''.obs;
  var email = ''.obs;
  var code = ''.obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    email.value = Get.arguments['email'];
    code.value = Get.arguments['code'];
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
    if (otp.isNotEmpty && otp == code.value) {
      Get.toNamed(Routes.RESET_PASSWORD,
          arguments: {'email': email.value, 'code': code.value});
    }
  }

  getCode() async {
    if (enableResend.isTrue) {
      enableResend.value = false;
      seconds.value = 30;
      code.value = (await AuthApis.getCode(email.value))!;
    }
  }
}
