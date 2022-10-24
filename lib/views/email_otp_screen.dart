import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/email_otp_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/reset_password_screen.dart';

class EmailOTPActivity extends StatelessWidget {
  final controller = Get.put(EmailOTPController());
  EmailOTPActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Constants.primaryColor,
            size: 28,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(child: Obx(() {
        return Container(
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
                        text: "Enter the OTP code just sent to your Email",
                        isBold: true,
                        textSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: size.width,
                      child: OTPTextField(
                        obscureText: true,
                        length: 6,
                        textFieldAlignment: MainAxisAlignment.spaceBetween,
                        fieldStyle: FieldStyle.box,
                        otpFieldStyle: OtpFieldStyle(
                          borderColor: Constants.primaryColor,
                        ),
                        outlineBorderRadius: 8,
                        style: const TextStyle(fontSize: 17),
                        fieldWidth: 40,
                        onChanged: (pin) {
                          print("Changed: $pin");
                        },
                        onCompleted: (pin) {
                          controller.otpText.value = pin;
                          controller.verifyOTP(controller.otpText.value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        controller.verifyOTP(controller.otpText.value);
                      },
                      child: AppButton(
                        text: 'Continue',
                        textSize: 15,
                        buttonWidth: 230,
                        buttonHeight: 70,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Haven\'t received code. ',
                            style: const TextStyle(
                                color: Constants.primaryColor, fontSize: 15),
                            children: [
                              TextSpan(
                                text: 'Resend Code ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: controller.enableResend.isTrue
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (() {
                                    controller.getCode();
                                  }),
                              ),
                              TextSpan(
                                text: 'after ${controller.seconds} seconds',
                                style: const TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 15),
                              )
                            ]),
                      ),
                    ),
                    /*  Row(
                      children: [
                        Expanded(child: A),
                        InkWell(
                          onTap: () {
                            controller.enableResend.value =
                                !controller.enableResend.value;
                          },
                          child: AppText(
                            text: 'Resend Code',
                            isBold: controller.enableResend.value,
                            textSize: controller.enableResend.isTrue ? 18 : 16,
                            textColor: Colors.black,
                          ),
                        ),
                      ],
                    ) */
                  ]),
            ),
          ),
        );
      })),
    );
  }
}
