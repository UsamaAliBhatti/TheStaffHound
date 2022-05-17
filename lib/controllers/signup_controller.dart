import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';

class SignUpController extends GetxController {
  var branch = ''.obs;
  var branchModel;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  late TextEditingController emailController,
      passwordController,
      nameController,
      reEnterPasswordController;

  var email = ''.obs;
  var password = ''.obs;
  var reEnterPassword = ''.obs;
  var name = ''.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    reEnterPasswordController = TextEditingController();
    branchModel = RestApiServices.getAllBranches();
    print(branchModel);
    super.onInit();
  }

  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    reEnterPasswordController.dispose();
  }
}
