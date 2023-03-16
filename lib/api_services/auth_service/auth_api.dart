import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_staff_hound/api_services/auth_service/responses/branches_model.dart';
import 'package:the_staff_hound/api_services/auth_service/responses/profile_model.dart';
import 'package:the_staff_hound/api_services/auth_service/responses/signup_model.dart';
import 'package:the_staff_hound/api_services/auth_service/responses/update_profile_model.dart';
import 'package:the_staff_hound/api_services/auth_service/responses/user_model.dart';
import 'package:the_staff_hound/api_services/exceptions/api_exceptions.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/helper/dialog_helper.dart';
import 'package:the_staff_hound/network_manager/network_state_manager.dart';

class AuthApis {
  static var client = http.Client();

  static final NetworkManager _networkManager = Get.find<NetworkManager>();

  // User Login  Method
  static Future<UserModel?> loginUser(String email, String password) async {
    var url = Uri.parse('${Constants.baseUrl}login');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      var token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        try {
          var response = await client
              .post(url, body: {'email': email, 'password': password, 'device_token': token}).timeout(
            const Duration(seconds: 30),
          );
          switch (response.statusCode) {
            case 200:
              return userModelFromJson(response.body);

            case 400:
              throw BadRequestException(utf8.decode(response.bodyBytes),
                  response.request!.url.toString());
            default:
              throw FetchDataException(
                  'Error occured with code : ${response.statusCode}',
                  response.request!.url.toString());
          }
        } on SocketException {
          throw FetchDataException('No Internet Connection', url.toString());
        } on TimeoutException {
          throw ApiNotRespondingException('Request Timed out', url.toString());
        }
      } else {
        Fluttertoast.showToast(msg: 'Error occoured. Please try again later');
        return null;
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
      return null;
    }
  }

  // User Sign up  Method
  static Future<SignUpResponse?> registerUser(
      Map<String, dynamic> userData) async {
    var url = Uri.parse('${Constants.baseUrl}register');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client.post(url, body: userData).timeout(
              const Duration(seconds: 10),
            );
        switch (response.statusCode) {
          case 200:
            return signUpResponseFromJson(response.body);
          case 201:
            Fluttertoast.showToast(msg: 'Email has already been taken');
            return null;
          case 202:
            return null;
          case 400:
            throw BadRequestException(utf8.decode(response.bodyBytes),
                response.request!.url.toString());
          default:
            throw FetchDataException(
                'Error occured with code : ${response.statusCode}',
                response.request!.url.toString());
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection', url.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Request Timed out', url.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
      return null;
    }
  }

  // Update User Profile  Method
  static Future<UpdateProfileModel?> updateUserProfile(
      String token, Map<String, dynamic> data) async {
    var url = Uri.parse('${Constants.baseUrl}update-profile');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client
            .post(url, headers: {'Authorization': 'Bearer $token'}, body: data)
            .timeout(
              const Duration(seconds: 10),
            );
        switch (response.statusCode) {
          case 200:
            return updateProfileModelFromJson(response.body);
          case 201:
            Fluttertoast.showToast(msg: 'Email has already been taken');
            return null;
          case 202:
            return null;
          case 400:
            throw BadRequestException(utf8.decode(response.bodyBytes),
                response.request!.url.toString());
          default:
            throw FetchDataException(
                'Error occured with code : ${response.statusCode}',
                response.request!.url.toString());
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection', url.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Request Timed out', url.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
      return null;
    }
  }

  //Method to get User Profile
  static Future<ProfileModel?> getUserProfile(String token) async {
    var url = Uri.parse('${Constants.baseUrl}get-profile');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client.post(url, body: {
          'type': '5'
        }, headers: {
          'Authorization': 'Bearer $token',
        }).timeout(
          const Duration(seconds: 10),
        );
        switch (response.statusCode) {
          case 200:
            return profileModelFromJson(response.body);
          case 201:
            Fluttertoast.showToast(
                msg: 'Something went wrong. Try again later...');
            return null;
          case 202:
            return null;
          case 400:
            throw BadRequestException(utf8.decode(response.bodyBytes),
                response.request!.url.toString());
          default:
            throw FetchDataException(
                'Error occured with code : ${response.statusCode}',
                response.request!.url.toString());
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection', url.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Request Timed out', url.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
      return null;
    }
  }

  //Method to get User Profile
  static setUserAvailability(String token, int unavailability,
      {String? from, String? to}) async {
    var url = Uri.parse('${Constants.baseUrl}user-unavailability');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client.post(url,
            body: (from != null && to != null)
                ? {
                    'type': '5',
                    'unavailability': unavailability.toString(),
                    'unavailability_from': from,
                    'unavailability_to': to
                  }
                : {
                    'type': '5',
                    'unavailability': unavailability.toString(),
                  },
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json'
            }).timeout(
          const Duration(seconds: 10),
        );
        switch (response.statusCode) {
          case 200:
            print(response.body.toString());
            break;
          case 201:
            Fluttertoast.showToast(
                msg: 'Something went wrong. Try again later...');
            break;

          case 400:
            throw BadRequestException(utf8.decode(response.bodyBytes),
                response.request!.url.toString());
          default:
            print(response.statusCode);
            throw FetchDataException(
                'Error occured with code : ${response.statusCode}',
                response.request!.url.toString());
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection', url.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Request Timed out', url.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
    }
  }

  // Update User Password Method
  static Future<bool> updateUserPassword(
      String token, Map<String, dynamic> data) async {
    var url = Uri.parse('${Constants.baseUrl}update-password');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client
            .post(url, headers: {'Authorization': 'Bearer $token'}, body: data)
            .timeout(
              const Duration(seconds: 10),
            );
        var msgResponse = jsonDecode(response.body);

        switch (msgResponse['message']) {
          case 'password changed':
            DialogHelper.showToast('Password changed successfully');
            return true;

          case 'Old Password mismatch':
            DialogHelper.showToast('Password not matched');
            return false;
          default:
            print(response.statusCode);
            DialogHelper.showToast('Error occured. Try again later!');
            return false;
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection', url.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Request Timed out', url.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
      return false;
    }
  }

// Get Code For Forgot Password Method
  static Future<String?> getCode(String email) async {
    var url = Uri.parse('${Constants.baseUrl}forget-password');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client.post(url, body: {'email': email}).timeout(
          const Duration(seconds: 10),
        );
        switch (response.statusCode) {
          case 200:
            var data = jsonDecode(response.body);
            if (data['status'] == 'True') {
              return data['data'].toString();
            } else {
              return null;
            }

          case 201:
            Fluttertoast.showToast(
                msg: 'Something went wrong. Try again later...');
            return null;
          case 400:
            throw BadRequestException(utf8.decode(response.bodyBytes),
                response.request!.url.toString());
          default:
            throw FetchDataException(
                'Error occured with code : ${response.statusCode}',
                response.request!.url.toString());
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection', url.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Request Timed out', url.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
      return null;
    }
  }

  // Change User Password Method
  static Future<bool> changeUserPassword(Map<String, String> data) async {
    var url = Uri.parse('${Constants.baseUrl}update-forget-password');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client.post(url, body: data).timeout(
              const Duration(seconds: 10),
            );
        var msgResponse = jsonDecode(response.body);

        switch (msgResponse['message']) {
          case 'password changed':
            DialogHelper.showToast('Password changed successfully');
            return true;

          case 'passcode not matched':
            DialogHelper.showToast('Password not matched');
            return false;
          default:
            print(response.statusCode);
            DialogHelper.showToast('Error occured. Try again later!');
            return false;
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection', url.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Request Timed out', url.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
      return false;
    }
  }

//get Branches api
  static Future<BranchesResponse?> getAllBranches() async {
    var url = Uri.parse('${Constants.baseUrl}getBranches');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client.get(url).timeout(
              const Duration(seconds: 10),
            );
        switch (response.statusCode) {
          case 200:
            return branchesResponseFromJson(response.body);
          case 400:
            throw BadRequestException(utf8.decode(response.bodyBytes),
                response.request!.url.toString());
          default:
            throw FetchDataException(
                'Error occured with code : ${response.statusCode}',
                response.request!.url.toString());
        }
      } on SocketException {
        throw FetchDataException('No Internet Connection', url.toString());
      } on TimeoutException {
        throw ApiNotRespondingException('Request Timed out', url.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have an active internet connection');
      return null;
    }
  }
}
