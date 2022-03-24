import 'package:flutter/material.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

class ResetPasswordSuccessScreen extends StatelessWidget {
  const ResetPasswordSuccessScreen({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Constants.successPasswordImage,
            ),
            const SizedBox(
              height: 20,
            ),
            AppText(
              text: 'Success',
              isBold: true,
              textSize: 25,
            ),
            const SizedBox(
              height: 40,
            ),
            AppText(
              text: 'Your password has been reset successfully',
              isBold: true,
              textSize: 15,
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {},
              child: AppButton(
                text: 'Continue',
                isBold: false,
                textSize: 18,
                buttonHeight: 60,
                buttonWidth: 230,
              ),
            )
          ],
        ),
      )),
    );
  }
}
