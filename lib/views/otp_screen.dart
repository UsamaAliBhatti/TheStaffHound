import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/reset_password_screen.dart';

class OTPActivity extends StatelessWidget {
  const OTPActivity({Key? key}) : super(key: key);

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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(Constants.otpScreenImage),
                  const SizedBox(
                    height: 50,
                  ),
                  AppText(
                    text: "OTP Verification",
                    isBold: true,
                    textSize: 25,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 250,
                    child: AppText(
                      text:
                          "Enter the OTP code just sent to your email address",
                      isBold: true,
                      textSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 40,
                    width: 250,
                    child: OTPTextField(
                      obscureText: true,
                      length: 4,
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                        borderColor: Constants.primaryColor,
                      ),
                      outlineBorderRadius: 8,
                      style: const TextStyle(fontSize: 17),
                      fieldWidth: 40,
                      onChanged: (pin) {
                        // print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        // print("Completed: " + pin);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell( 
                    onTap: () {
                      Get.to(() => const ResetPasswordActivity());
                    },
                    child: AppButton(
                      text: 'Continue',
                      textSize: 15,
                      buttonWidth: 230,
                      buttonHeight: 70,
                    ),
                  )
                ]),
          ),
        ),
      )),
    );
  }
}
