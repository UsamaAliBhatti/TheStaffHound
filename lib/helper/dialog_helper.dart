import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/helper_widgets/TableCalenderHelper.dart';

import '../api_services/auth_service/auth_api.dart';
import '../constants.dart';
import '../custom_widgets/app_text.dart';
import '../shared_prefs/shared_prefs.dart';

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

  static void showConfirmationDialog(Map<String, String> data) {
    Get.dialog(
        Dialog(
          insetPadding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                'Confirmation',
                style: Get.textTheme.headline4,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Once the password is changed, you need to login again to continue.',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 17.0),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () async {
                      bool isChanged = await AuthApis.updateUserPassword(
                          SharedPrefsManager.getUserToken, data);
                      if (isChanged) {
                        SharedPrefsManager.userLogout();
                      }
                    },
                    child: const Text('Okay')),
              )
            ]),
          ),
        ),
        barrierDismissible: false);
  }

  // Toast Method
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Constants.secondaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static DateTime? rangeEnd = DateTime.now();
  static DateTime? rangeStart = DateTime.now();
  static openDurationDialog() {
    showDialog(
        context: Get.overlayContext!,
        builder: (context) {
          return AlertDialog(
            title: AppText(
              text: 'Select Duration',
              isBold: true,
              textSize: 18,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalenderHelper(
                      getRangeDates: (startDate, endDate) {
                        rangeEnd = endDate;
                        rangeStart = startDate;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Note: ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            children: [
                          TextSpan(
                              text:
                                  'You will not receive any notification while you will be away',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal)),
                        ])),
                  ],
                )),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actionsPadding: const EdgeInsets.all(20),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    backgroundColor: Constants.buttonBackgroundColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: AppText(
                  text: 'Cancel',
                  isBold: true,
                  textSize: 15,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (rangeStart != null && rangeEnd != null) {
                    AuthApis.setUserAvailability(
                        SharedPrefsManager.getUserToken, 1,
                        from: rangeStart.toString(), to: rangeEnd.toString());
                    Get.back();
                  } else {
                    showToast('Please Select Your Range First');
                  }
                },
                style: TextButton.styleFrom(
                    // padding: const EdgeInsets.symmetric(horizontal: 30),
                    backgroundColor: Constants.primaryColor.withOpacity(0.5),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: AppText(
                  text: 'Confirm',
                  isBold: true,
                  textSize: 15,
                  textColor: Constants.buttonBackgroundColor,
                ),
              )
            ],
            insetPadding: const EdgeInsets.all(10),
          );
        });
  }
}
