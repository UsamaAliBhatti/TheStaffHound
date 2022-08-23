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

    otpText.value = Get.arguments[0]['token'].toString();
    print(otpText.value);
    verIdText.value = Get.arguments[0]['verId'];
    print(verIdText.value);
    phone.value = Get.arguments[0]['phone'];

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
    otpTextController.clear();
  }

  getCode() {
    if (enableResend.isTrue) {
      enableResend.value = false;
      seconds.value = 30;
      verifyPhone(phone.value);
    }
  }

  Future<void> verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 10),
        verificationCompleted: (credential) {},
        verificationFailed: (e) {},
        codeSent: (verId, code) {
          verIdText.value = verId;
          otpText.value = code.toString();
          print(otpText.value);
          print(verIdText.value);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          // showToast('Request Timeout!. Try Again Later');
        });
  }

  Future<void> verifyOTP(String verId, String code) async {
    // PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: code);
        
    // credential.
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}
