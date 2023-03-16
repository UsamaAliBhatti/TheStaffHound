import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/auth_service/auth_api.dart';
import 'package:the_staff_hound/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  var email = ''.obs;
  var code = ''.obs;

  var passwordController = TextEditingController();
  var reEnterPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.value = Get.arguments['email'];
    code.value = Get.arguments['code'];
    super.onInit();
  }

  @override
  void onClose() {
    passwordController.dispose();
    reEnterPasswordController.dispose();
    super.onClose();
  }

  String? validatePassword(String? password) {
    if (password!.length < 8) {
      return 'Password must be of 8 characters';
    }
    return null;
  }

  String? validateReEnterPassword(String? reEnterPassword) {
    if (reEnterPassword != passwordController.text) {
      return 'password not matched';
    }
    return null;
  }

  changePassword() async {
    if (formKey.currentState!.validate()) {
      var data = {
        'password': passwordController.text,
        'passcode': code.value,
        'email': email.value,
        'confirm_password': reEnterPasswordController.text
      };
      if (await AuthApis.changeUserPassword(data)) {
        Get.offAllNamed(
          Routes.LOGIN,
        );
      }
    }
  }
}
