import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/dashboard_screen.dart';

class SignUpActivity extends StatelessWidget {
  const SignUpActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: size.width,
        height: size.height,
        color: Constants.backgroundColor,
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Constants.primaryColor,
                ),
              ),
              const SizedBox(height: 30),
              AppText(
                text: 'Create Account',
                textSize: 20,
                isBold: true,
              ),
              const SizedBox(height: 30),
              AppText(
                text: 'Welcome',
                textSize: 25,
                isBold: true,
              ),
              const SizedBox(height: 5),
              AppText(
                text: 'its easier to sign up',
                textSize: 18,
              ),
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color: Constants.primaryColor, width: 2.0),
                  ),
                  labelText: "Username",
                  labelStyle: const TextStyle(
                      color: Constants.primaryColor, fontSize: 17),
                  prefixIcon: const Icon(
                    Icons.person_rounded,
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
                    labelText: "Email",
                    labelStyle: const TextStyle(
                        color: Constants.primaryColor, fontSize: 17),
                    prefixIcon:
                        const Icon(Icons.email, color: Constants.primaryColor)),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 18,
                ),
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
                  prefixIcon: Image.asset(Constants.passwordIcon),
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
                    labelText: "Re-Enter Password",
                    labelStyle: const TextStyle(
                        color: Constants.primaryColor, fontSize: 17),
                    prefixIcon: Image.asset(Constants.passwordIcon)),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    isChecked = !isChecked;
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            // color: /*isChecked ? primaryColor : */Colors.grey,
                            border: Border.all(
                                color: isChecked
                                    ? Constants.primaryColor
                                    : Constants.textHintColor),
                            borderRadius: BorderRadius.circular(3.0)),
                        width: 20,
                        height: 20,
                        child: isChecked
                            ? const Icon(Icons.check,
                                color: Constants.primaryColor, size: 20)
                            : null,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15),
                        child: Text(
                          'I have read the',
                          style: TextStyle(
                              color: Constants.primaryColor, fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'privacy policy',
                            style: TextStyle(
                              color: Constants.secondaryColor,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: AppButton(
                  text: "Sign Up",
                  textSize: 20,
                  buttonWidth: 250,
                ),
                onTap: () {
                  Get.to(() => DashboardActivity());
                },
              ),
            ],
          )),
        ),
      )),
    );
  }
}
