import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/views/dashboard_screen.dart';

import '../network_manager/network_state_manager.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;

  final _networkManager = Get.put(NetworkManager());

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

  void checkLogin() async {
    var isConnected = await _networkManager.checkInternetConnection();
    if (isConnected) {
      final isValid = loginFormKey.currentState!.validate();

      if (!isValid) {
        return;
      } else {
        loginFormKey.currentState!.save();
        var isLoggedIn =
            await RestApiServices.userLogin(email.value, password.value);
        if (isLoggedIn!) {
          loginFormKey.currentState!.reset();
          email.value = '';
          password.value = '';
          emailController.clear();
          passwordController.clear();
          Get.off(() => DashboardActivity());
        }
      }
    } else {
      Get.snackbar('Connection Error', 'Please Check Your Internet Connection');
    }
  }
}
