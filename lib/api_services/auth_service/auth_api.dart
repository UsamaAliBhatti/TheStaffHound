import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_staff_hound/api_services/auth_service/responses/branches_model.dart';
import 'package:the_staff_hound/api_services/auth_service/responses/signup_model.dart';
import 'package:the_staff_hound/api_services/auth_service/responses/user_model.dart';
import 'package:the_staff_hound/api_services/exceptions/api_exceptions.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/network_manager/network_state_manager.dart';

class AuthApis {
  static var client = http.Client();

  static final NetworkManager _networkManager = Get.find<NetworkManager>();

  // User Login  Method
  static Future<User?> loginUser(String email, String password) async {
    var url = Uri.parse('${Constants.baseUrl}login');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client
            .post(url, body: {'email': email, 'password': password}).timeout(
          const Duration(seconds: 10),
        );
        switch (response.statusCode) {
          case 200:
            return userFromJson(response.body);

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
