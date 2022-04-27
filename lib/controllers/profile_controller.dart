

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final addressTextController = TextEditingController();
  var nameText = ''.obs;
  var emailText = ''.obs;
  var phoneNumberText = ''.obs;
  var addressText = ''.obs;
}