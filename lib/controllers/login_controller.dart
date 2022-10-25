import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/auth_service/auth_api.dart';
import 'package:the_staff_hound/api_services/auth_service/responses/user_model.dart';
import 'package:the_staff_hound/api_services/controllers/base_controller.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/routes/app_pages.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

import '../network_manager/network_state_manager.dart';

class LoginController extends GetxController with BaseController {
  final loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;

  var showPassword = false.obs;

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
    showPassword.value = true;
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
    if (password!.length < 6) {
      return 'Password must be of 6 characters';
    }
    return null;
  }

  void checkLogin() async {
    final isValid = loginFormKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      loginFormKey.currentState!.save();
      var userData = await AuthApis.loginUser(email.value, password.value)
          .catchError(handleError);
      if (userData != null) {
        saveUserMethod(userData, 'Logged in successfully...');
        loginFormKey.currentState!.reset();

        email.value = '';
        password.value = '';
        emailController.clear();
        passwordController.clear();
        Get.offNamed(Routes.DASHBOARD);
        print(SharedPrefsManager.getUserName);
      }
      /*        var isLoggedIn =
            await RestApiServices.userLogin(email.value, password.value);
        if (isLoggedIn!) {
          
        } */
    }

    /*   var isConnected = await _networkManager.checkInternetConnection();
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
  } */
  }

  void saveUserMethod(User userModel, String message) async {
    var isDataSaved = await SharedPrefsManager.saveUserData(
        userModel.token!,
        userModel.data!.id!,
        userModel.data!.name!,
        userModel.data!.email!,
        userModel.data!.type!,
        userModel.phone!,
        userModel.address!);
    if (isDataSaved) {
      Fluttertoast.showToast(
          msg: message,
          textColor: Colors.white,
          backgroundColor: Constants.secondaryColor);
      print('data saved');
    } else {
      print('data not saved');
    }
  }
}
