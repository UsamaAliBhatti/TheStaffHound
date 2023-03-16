import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/auth_service/auth_api.dart';
import 'package:the_staff_hound/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var emailFieldFocus = FocusNode();

  String? validateEmail(String? email) {
    if (!GetUtils.isEmail(email!)) {
      return 'Provide Valid Email';
    }
    if (email.isEmpty) {
      return 'Required';
    }
    return null;
  }

  sendEmailToGetOTP() async {
    if (formKey.currentState!.validate()) {
      var code = await AuthApis.getCode(emailController.text);
      if (code != null) {
        Get.toNamed(Routes.EMAIL_OTP,
            arguments: {'email': emailController.text, 'code': code});
      }
    }
  }
}
