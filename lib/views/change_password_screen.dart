import 'package:flutter/material.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

import '../constants.dart';

class ChangePasswordActivity extends StatelessWidget {
  const ChangePasswordActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(30),
        width: size.width,
        height: size.height,
        color: Constants.backgroundColor,
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Image.asset(Constants.resetPasswordImage),
              const SizedBox(height: 50),
              AppText(
                text: "Change Password",
                isBold: true,
                textSize: 25,
              ),
              const SizedBox(height: 40),
              AppText(
                text: "Set the new password for your account",
                isBold: true,
                textSize: 15,
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color: Constants.primaryColor, width: 1.0),
                  ),
                  labelText: "Existing Password",
                  labelStyle: const TextStyle(
                      color: Constants.primaryColor, fontSize: 17),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
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
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
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
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {},
                child: AppButton(
                  text: 'Update',
                  textSize: 15,
                  buttonWidth: 230,
                  buttonHeight: 60,
                ),
              )
            ],
          )),
        ),
      )),
    );
  }
}
