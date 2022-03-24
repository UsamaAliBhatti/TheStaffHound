// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

class AppButton extends StatelessWidget {
  String text;
  Color buttonBackgroundColor;
  Color textColor;
  double buttonHeight;
  double buttonWidth;
  double textSize;
  bool isBold;

  AppButton(
      {Key? key,
      required this.text,
      this.buttonBackgroundColor = Constants.buttonBackgroundColor,
      this.textColor = Constants.primaryColor,
      this.buttonHeight = 80,
      this.buttonWidth = 150,
      this.textSize = 20,
      this.isBold = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(10, 15),
                blurRadius: 20)
          ]),
      child: Center(
        child: AppText(
          text: text,
          textSize: textSize,
          isBold: isBold ? true : false,
          textColor: textColor,
        ),
      ),
    );
  }
}
