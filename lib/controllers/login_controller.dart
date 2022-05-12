import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/services/rest_api_services.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;

  var email = ''.obs;
  var password = ''.obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String? email) {
    if (!GetUtils.isEmail(email!)) {
      return 'Provide Valid Email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password!.length < 8) {
      return 'Password must be of 8 characters';
    }
    return null;
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
    RestApiServices.userLogin(email.value, password.value);
  }
}
