import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/reset_password_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

class ResetPasswordActivity extends StatelessWidget {
  final controller = Get.put(ResetPasswordController());
  ResetPasswordActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: const EdgeInsets.all(30),
            width: size.width,
            height: size.height,
            color: Constants.backgroundColor,
            child: SingleChildScrollView(
              child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(Constants.resetPasswordImage),
                      const SizedBox(height: 50),
                      AppText(
                        text: "Reset Your Password",
                        isBold: true,
                        textSize: 25,
                      ),
                      const SizedBox(height: 40),
                      AppText(
                        text:
                            "Set the new password for your account so you can login and access all the features",
                        isBold: true,
                        textSize: 15,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                color: Constants.primaryColor, width: 1.0),
                          ),
                          labelText: "New Password",
                          labelStyle: const TextStyle(
                              color: Constants.primaryColor, fontSize: 17),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 18,
                        ),
                        validator: (value) {
                          return controller.validatePassword(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.reEnterPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                color: Constants.primaryColor, width: 1.0),
                          ),
                          labelText: "Confirm Password",
                          labelStyle: const TextStyle(
                              color: Constants.primaryColor, fontSize: 17),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 18,
                        ),
                        validator: (value) {
                          return controller.validateReEnterPassword(value);
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          controller.changePassword();
                        },
                        child: AppButton(
                          text: 'Update',
                          textSize: 15,
                          buttonWidth: 230,
                          buttonHeight: 70,
                        ),
                      )
                    ],
                  )),
            ),
          ),
      ),
    );
  }
}
