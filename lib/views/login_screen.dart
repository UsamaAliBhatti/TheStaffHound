import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/login_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
// import 'package:the_staff_hound/network_manager/network_state_manager.dart';
import 'package:the_staff_hound/views/phone_otp_screen.dart';
import 'package:the_staff_hound/views/signup_screen.dart';

class LoginActivity extends StatelessWidget {
  LoginActivity({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());
  // var _networkManager = Get.find<NetworkManager>();

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
              key: controller.loginFormKey,
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
                    controller: controller.emailController,
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
                    onSaved: (value) {
                      controller.email.value = value!;
                    },
                    validator: (value) {
                      return controller.validateEmail(value);
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                        color: Constants.primaryColor, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.passwordController,
                    onSaved: (value) {
                      controller.password.value = value!;
                    },
                    validator: (value) {
                      return controller.validatePassword(value);
                    },
                    obscureText: true,
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
                          Get.to(() => PhoneOTPActivity(), arguments: [{
                            'status': 'forgotpassword'
                          }]);
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
                      // Get.to(() => DashboardActivity());
                      controller.checkLogin();
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
                            Get.to(() => SignUpActivity());
                          },
                          child: AppText(
                            text: "Sign Up",
                            isBold: true,
                            textColor: Constants.primaryColor,
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
