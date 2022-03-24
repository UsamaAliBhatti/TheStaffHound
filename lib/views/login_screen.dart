import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/dashboard_screen.dart';
import 'package:the_staff_hound/views/forgot_password_screen.dart';
import 'package:the_staff_hound/views/signup_screen.dart';

class LoginActivity extends StatelessWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Constants.backgroundColor,
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: <Widget>[
              Image.asset(
                Constants.splashLogo,
                width: 110,
                height: 140,
              ),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color: Constants.primaryColor, width: 2.0),
                  ),
                  labelText: "Email",
                  labelStyle: const TextStyle(
                      color: Constants.primaryColor, fontSize: 17),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Constants.primaryColor,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Constants.primaryColor, fontSize: 18),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Constants.primaryColor, width: 2.0),
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(
                        color: Constants.primaryColor, fontSize: 17),
                    prefixIcon: Image.asset(Constants.passwordIcon)),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: InkWell(
                    onTap: () {
                      Get.to(() => const ForgotPasswordActivity());
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        text: "forgot your password?",
                        textColor: Constants.textHintColor,
                        textSize: 20,
                        isBold: true,
                      ),
                    )),
              ),
              const SizedBox(height: 50),
              InkWell(
                child: AppButton(
                  text: "Sign In",
                  textSize: 20,
                  buttonWidth: 250,
                ),
                onTap: () {
                  Get.to(() => DashboardActivity());
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 2,
                    color: Constants.primaryColor,
                    margin: const EdgeInsets.all(5),
                  ),
                  AppText(
                    text: "Or",
                    textSize: 15,
                    textColor: Constants.textHintColor,
                  ),
                  Container(
                    width: 120,
                    height: 2,
                    color: Constants.primaryColor,
                    margin: const EdgeInsets.all(5),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Constants.googleIcon),
                  const SizedBox(
                    width: 50,
                  ),
                  Image.asset(Constants.facebookIcon)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "New Here?",
                    isBold: true,
                    textColor: Constants.textHintColor,
                    textSize: 20,
                  ),
                  const SizedBox(width: 5),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const SignUpActivity());
                      },
                      child: AppText(
                        text: "Sign Up",
                        isBold: true,
                        textColor: Constants.textHintColor,
                        textSize: 20,
                      ))
                ],
              )
            ],
          )),
        ),
      )),
    );
  }
}
