import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:the_staff_hound/api_services/response_models/branches_model.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/views/phone_otp_screen.dart';


class SignUpController extends GetxController {

  late BranchesModel branchModel = BranchesModel();

  var dropdownItemsList = <MultiSelectItem>[].obs;
  var selectedBranchesList = <int>[].obs;

  var formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];
  // final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  late TextEditingController emailController,
      passwordController,
      nameController,
      reEnterPasswordController,
      phoneContoller;

  var emailText = ''.obs;
  var password = ''.obs;
  var reEnterPassword = ''.obs;
  var name = ''.obs;
  var phoneNumber = ''.obs;
  // var isLoaded = false.obs;
  // var selectedItem = ''.obs;

  var branchId = 0.obs;

  var isPrivacyPolicyChecked = false.obs;

  var currentStep = 0.obs;

  var currentAddress = ''.obs;
  late TextEditingController streetTextController,
      zipcodeTextController,
      countryTextController,
      stateTextController,
      cityTextController;

  var streetText = ''.obs;
  var zipcodeText = ''.obs;
  var stateText = ''.obs;
  var countryText = ''.obs;

  var isCurrentLocationSelected = false.obs;
  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    reEnterPasswordController = TextEditingController();

    phoneContoller = TextEditingController();

    streetTextController = TextEditingController();
    zipcodeTextController = TextEditingController();
    countryTextController = TextEditingController();
    stateTextController = TextEditingController();
    cityTextController = TextEditingController();
    getBranchesList();

    super.onInit();
  }

  clearAddress() {
    streetTextController.clear();
    zipcodeTextController.clear();
    countryTextController.clear();
    stateTextController.clear();
    cityTextController.clear();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getCurrentLocation() async {
    var position = await _getGeoLocationPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);

    Placemark place = placemarks[0];
    streetTextController.text = place.street!;
    zipcodeTextController.text = place.postalCode!;
    countryTextController.text = place.country!;
    stateTextController.text = place.locality!;
    cityTextController.text = place.subAdministrativeArea!;

    /* Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}'; */
  }

//method to get branches
  getBranchesList() async {
    branchModel = (await RestApiServices.getAllBranches())!;
    dropdownItemsList.value = branchModel.data!.map((branch) {
      return MultiSelectItem(branch, branch.name);
    }).toList();
    update();
  }

  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    reEnterPasswordController.dispose();

    phoneContoller.dispose();

    streetTextController.dispose();
    zipcodeTextController.dispose();
    countryTextController.dispose();
    stateTextController.dispose();
    cityTextController.dispose();
  }

  String? validateEmail(String? email) {
    if (!GetUtils.isEmail(email!)) {
      return 'Provide Valid Email';
    }
    return null;
  }

  String? validatePhone(String? phone) {
    if (phone!.isEmpty) {
      return 'Provide Your Phone Number';
    }
    return null;
  }

  /*  String? validateAddress(String? address) {
    if (address!.isEmpty) {
      return 'Provide Your Address';
    }
    return null;
  } */

  String? validateName(String? name) {
    if (name!.isEmpty) {
      return 'Provide Valid Name';
    }
    return null;
  }

  String? validateState(String? name) {
    if (name!.isEmpty) {
      return 'Provide Valid state';
    }
    return null;
  }

  String? validateZipCode(String? name) {
    if (name!.isEmpty) {
      return 'Provide Valid zip code';
    }
    return null;
  }

  String? validateCity(String? name) {
    if (name!.isEmpty) {
      return 'Provide Valid City';
    }
    return null;
  }

  String? validateCountry(String? name) {
    if (name!.isEmpty) {
      return 'Provide Valid Country';
    }
    return null;
  }

  String? validateStreet(String? name) {
    if (name!.isEmpty) {
      return 'Provide Valid Street';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password!.length < 8) {
      return 'Password must be of 8 characters';
    }
    return null;
  }

  String? validateReEnterPassword(String? reEnterPassword) {
    if (reEnterPassword != passwordController.text) {
      return 'password not matched';
    }
    return null;
  }

/* validateSteps(int index){
  if( )

} */
  userSignUpMethod() async {
    // final isValid = signupFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    /*   var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      if (!formKeys[0].currentState!.validate() &&
          !formKeys[1].currentState!.validate()) {
        print('Error:  Please Complete Both Forms');
        Fluttertoast.showToast(
            msg: 'Please Complete Both Forms',
            backgroundColor: Colors.red,
            textColor: Colors.white);
        return;
      } else {
        formKeys[0].currentState!.save();
        formKeys[1].currentState!.save();

        Map<String, dynamic> data = {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': passwordController.text,
          'type': '5',
          'branch_id': selectedBranchesList.toString(),
          'phone': phoneContoller.text,
          'street1': stateTextController.text,
          'country': countryTextController.text,
          'zip_code': zipcodeTextController.text,
          'state': stateTextController.text,
          'city': cityTextController.text
        };
        print(data.toString());
        var response = await RestApiServices.userSignUp(data);
        if (response != null) {
          // Get.back();
          formKeys[0].currentState!.reset();
          formKeys[1].currentState!.reset();
          /*    emailText.value = '';
          password.value = '';
          reEnterPassword.value = '';
          name.value = '';
          streetText.value = '';
          stateText.value = '';
          zipcodeText.value = '';
          countryText.value = ''; */
          branchId.value = 0;
          emailController.clear();
          passwordController.clear();
          nameController.clear();
          phoneContoller.clear();
          reEnterPasswordController.clear();
          stateTextController.clear();
          zipcodeTextController.clear();
          countryTextController.clear();
          streetTextController.clear();

          var userResponse = userResponseFromJson(response);
          verifyPhone(userResponse.phone!);
          /* Get.off(() => PhoneOTPActivity(), arguments: [
            {'status': 'signup'}
          ]); */
          // Get.to(() => const ForgotPasswordActivity());
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please Check Your Internet Connection',
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } */
    verifyPhone('+923104241301');
  }

//
  Future<void> verifyPhone(String phone) async {
    print('called');
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 10),
        verificationCompleted: (credential) {},
        verificationFailed: (e) {
          print(e);
        },
        codeSent: (verId, resendToken) {
          Get.off(() => PhoneOTPActivity(), arguments: [
            {'verId': verId, 'token': resendToken, 'phone': phone}
          ]);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          //showToast('Request Timeout!. Try Again Later');
        });
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
