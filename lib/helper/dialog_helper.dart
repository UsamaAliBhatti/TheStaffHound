import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showErrorDialog(
      {String title = 'Error',
      String description = 'Something went wrong. Please try again later.'}) {
    Get.dialog(Dialog(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          title,
          style: Get.textTheme.headline4,
        ),
        Text(
          description,
          style: Get.textTheme.headline4,
        ),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Okay'))
      ]),
    ));
  }

  static void showDialog() {}
}
