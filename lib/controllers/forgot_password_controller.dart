import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';

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
      await RestApiServices.sendEmailForOTP(emailController.text);
    }
  }
}
