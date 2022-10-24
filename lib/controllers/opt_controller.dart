import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class OTPController extends GetxController {
  var otpText = ''.obs;
  late Timer timer;
  var enableResend = false.obs;
  var seconds = 30.obs;
  var status = ''.obs;
  final otpTextController = OtpFieldController();
  var verIdText = ''.obs;
  var phone = ''.obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    // status.value = Get.arguments[0]['status'];

    /*   if (Get.arguments[0]['token'] != null) {
      otpText.value = Get.arguments[0]['token'].toString();
      print(otpText.value);

      verIdText.value = Get.arguments[0]['verId'];
      print(verIdText.value);
      phone.value = Get.arguments[0]['phone'];
    } */
    verifyPhone();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds.value != 0) {
        seconds.value--;
        enableResend.value = false;
      } else {
        enableResend.value = true;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
    otpTextController.clear();
  }

  getCode() {
    if (enableResend.isTrue) {
      enableResend.value = false;
      seconds.value = 30;
      verifyPhone();
    }
  }

  Future<void> verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+923104241301',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) {},
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (verId, code) {
        // Get.to(() => PhoneOTPActivity(), arguments: [{'verId', verId}]);
        /*    print(otpText.value);
        print(verIdText.value); */
      },
      codeAutoRetrievalTimeout: (e) {
        // showToast('Request Timeout!. Try Again Later');
      },
    );
  }

  // Future<void> verifyOTP(String verId, String code) async {
  //   // PhoneAuthCredential credential =
  //   PhoneAuthProvider.credential(verificationId: verId, smsCode: code);

  //   // credential.
  // }

  void showToast(String msg) {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}
