import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/forgot_password_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/reset_password_screen.dart';

class ForgotPasswordActivity extends StatelessWidget {
  final controller = Get.put(ForgotPasswordController());
  ForgotPasswordActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(30),
        width: size.width,
        height: size.height,
        color: Constants.backgroundColor,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Image.asset(Constants.forgotPasswordImage),
                const SizedBox(height: 50),
                AppText(
                  text: "Forgot Password",
                  isBold: true,
                  textSize: 25,
                ),
                const SizedBox(height: 40),
                AppText(
                  text:
                      "Enter your registered email for the verification process. We will send 4 digit code to your email",
                  isBold: true,
                  textSize: 15,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  focusNode: controller.emailFieldFocus,
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Constants.primaryColor, width: 2.0),
                    ),
                    labelText: "Email",
                    hintText: 'Enter Email Address',
                    labelStyle: const TextStyle(
                        color: Constants.primaryColor, fontSize: 17),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    controller.validateEmail(email);
                    return null;
                  },
                  style: const TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    controller.sendEmailToGetOTP();
                  },
                  child: AppButton(
                    text: 'Continue',
                    textSize: 15,
                    buttonWidth: 230,
                    buttonHeight: 70,
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
