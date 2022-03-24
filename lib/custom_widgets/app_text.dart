import 'package:flutter/material.dart';
import 'package:the_staff_hound/constants.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  double textSize;
  Color textColor;
  String text;
  bool isBold;
  bool isStart;

  AppText(
      {Key? key,
      required this.text,
      this.textSize = 15,
      this.textColor = Constants.primaryColor,
      this.isBold = false,
      this.isStart = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isStart ? TextAlign.start : TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
