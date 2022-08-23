import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class ProfileController extends GetxController {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final streetTextController = TextEditingController();
  final zipCodeTextController = TextEditingController();
  final stateTextController = TextEditingController();
  final countryTextController = TextEditingController();
  final cityTextController = TextEditingController();

  var nameText = ''.obs;
  var emailText = ''.obs;
  var phoneNumberText = ''.obs;
  var streetText = ''.obs;
  var zipcodeText = ''.obs;
  var stateText = ''.obs;
  var countryText = ''.obs;
  var addressText = ''.obs;
  var cityText = ''.obs;
  var isLoaded = false.obs;
  var token = ''.obs;

  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final reenterPasswordTextController = TextEditingController();

  @override
  void onInit() {
    token.value = SharedPrefsManager.getUserToken;
    getMyProfile(token.value);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    nameTextController.dispose();
    emailTextController.dispose();
    phoneNumberTextController.dispose();
    streetTextController.dispose();
    zipCodeTextController.dispose();
    stateTextController.dispose();
    countryTextController.dispose();
    cityTextController.dispose();
    newPasswordController.dispose();
    oldPasswordController.dispose();
    reenterPasswordTextController.dispose();
  }

  void getMyProfile(String token) async {
    var response = await RestApiServices.getMyProfile(token);
    if (response != null) {
      isLoaded.value = true;
      nameText.value = response.profile!.name!;
      emailText.value = response.profile!.email!;

      phoneNumberText.value = response.profile!.phone!;
      addressText.value = response.address!;
      streetText.value = response.profile!.street1!;
      zipcodeText.value = response.profile!.zipCode!;
      stateText.value = response.profile!.state!;
      countryText.value = response.profile!.country!;
      cityText.value = response.profile!.city ?? '';
      nameTextController.text = nameText.value;
      emailTextController.text = emailText.value;
      phoneNumberTextController.text = phoneNumberText.value;
      stateTextController.text = stateText.value;
      streetTextController.text = streetText.value;
      zipCodeTextController.text = zipcodeText.value;
      countryTextController.text = countryText.value;
      cityTextController.text = cityText.value;
    } else {
      isLoaded.value = false;
    }
  }

  //validate Designation Text
  String? validateNameTextField(String value) {
    if (value.isEmpty) {
      return "please provide your name";
    }

    return null;
  }

//validate Designation Text
  String? validatePhoneTextField(String value) {
    if (value.isEmpty) {
      return "please provide your phone number";
    }

    return null;
  }

//validate street Text
  String? validateStreetTextField(String value) {
    if (value.isEmpty) {
      return "please provide street";
    }

    return null;
  }

  //validate zipcode Text
  String? validateZipCodeTextField(String value) {
    if (value.isEmpty) {
      return "please provide zipcode";
    }

    return null;
  }

//validate City Text
  String? validateCityTextField(String value) {
    if (value.isEmpty) {
      return "please provide city";
    }

    return null;
  }

  //validate street Text
  String? validateCountryTextField(String value) {
    if (value.isEmpty) {
      return "please provide your country name";
    }

    return null;
  } //validate street Text

  String? validateStateTextField(String value) {
    if (value.isEmpty) {
      return "please provide your state name";
    }
    return null;
  }

  void updateMyProfile() async {
    bool isValid = profileFormKey.currentState!.validate();

    if (!isValid) {
      showToast('Please Fill Complete Form First');
    } else {
      profileFormKey.currentState!.save();
      nameText.value = nameTextController.text;
      phoneNumberText.value = phoneNumberTextController.text;
      stateText.value = stateTextController.text;
      streetText.value = streetTextController.text;
      countryText.value = countryTextController.text;
      zipcodeText.value = zipCodeTextController.text;
      cityText.value = cityTextController.text;
      /*  if (nameText.isEmpty) {
      showToast('Please Enter your name');
    }
    if (phoneNumberText.isEmpty) {
      showToast('Please enter your phone number');
    }
    if (stateText.isEmpty) {
      showToast('Please enter state');
    }
    if (streetText.isEmpty) {
      showToast('Please enter street');
    }
    if (zipcodeText.isEmpty) {
      showToast('Please enter zipcode');
    }
    if (countryText.isEmpty) {
      showToast('Please enter country');
    } */
      isLoaded.value = false;

      Map<String, String> data = {
        'name': nameText.value,
        'phone': phoneNumberText.value,
        'street1': streetText.value,
        'state': stateText.value,
        'zip_code': zipcodeText.value,
        'country': countryText.value,
        'city': cityText.value
      };
      var response = await RestApiServices.updateMyProfile(token.value, data);
      if (response != null) {
        isLoaded.value = true;

        nameText.value = response.profile!.name!;
        emailText.value = response.profile!.email!;
        phoneNumberText.value = response.profile!.phone!;
        addressText.value = response.address!;
        streetText.value = response.profile!.street1!;
        zipcodeText.value = response.profile!.zipCode!;
        stateText.value = response.profile!.state!;
        countryText.value = response.profile!.country!;
        cityText.value = response.profile!.city!;
        var isSaved = await SharedPrefsManager.update(
            nameText.value, phoneNumberText.value, addressText.value);
        if (isSaved) {
          debugPrint('Data saved');
          // print('Data saved');
          Get.back();
        }
      } else {
        isLoaded.value = false;
      }
    }
  }

  String? validateNewPassword(String? password) {
    if (password!.length < 8) {
      return 'Password must be of 8 characters';
    }
    return null;
  }

  String? validateOldPassword(String? password) {
    if (password!.length < 8) {
      return 'Please enter your old password correctly';
    }
    return null;
  }

  String? validateReEnterPassword(String? reEnterPassword) {
    if (reEnterPassword!.isEmpty) {
      return 'this field is required';
    }
    if (reEnterPassword != newPasswordController.text) {
      return 'password not matched';
    }
    return null;
  }

  updatePasswordMethod() async {
    if (resetPasswordFormKey.currentState!.validate()) {
      var data = {
        'current_password': oldPasswordController.text,
        'new_password': newPasswordController.text,
        'confirm_password': reenterPasswordTextController.text
      };

      bool? isChanged = await RestApiServices.changePassword(token.value, data);
      if (isChanged!) {
        Get.back();
        oldPasswordController.clear();
        newPasswordController.clear();
        reenterPasswordTextController.clear();
      }
    }
  }

  // Toast Method
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
