import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_staff_hound/models/experience_model.dart';
import 'package:the_staff_hound/network_manager/network_state_manager.dart';

import '../../constants.dart';
import '../../models/education_model.dart';
import '../exceptions/api_exceptions.dart';

class ResumeApis {
  static var client = http.Client();

  static final NetworkManager _networkManager = Get.put(NetworkManager());

  // Create Resume Method
  static createMyResume(String token,
      {List<UserEducation>? educationList,
      List<UserExperienceModel>? experienceList,
      String? aboutMe,
      List<String>? skillsList,
      List<String>? languagesList}) async {
    var url = Uri.parse('${Constants.baseUrl}add-cv');
    var isConnected = await _networkManager.checkInternetConnection();

    Map<String, dynamic> data = {
      "about_me": aboutMe,
      "skills": skillsList.toString(),
      "languages": languagesList.toString(),
      "education": educationList!.map((e) => e.toJson()).toList(),
      "experience": experienceList!.map((e) => e.toJson()).toList(),
    };

    print(jsonEncode(educationList));
    if (isConnected) {
      try {
        var response = await client
            .post(
              url,
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
                "Content-Type": "application/json"
              },
              body: jsonEncode(data),
            )
            .timeout(
              const Duration(seconds: 10),
            );
        switch (response.statusCode) {
          case 200:
            print(response.body);
            return true;
          // return userFromJson(response.body);

          case 400:
            throw BadRequestException(utf8.decode(response.bodyBytes),
                response.request!.url.toString());

          default:
            print(response.body);
          /* throw FetchDataException(
                'Error occured with code : ${response.statusCode}',
                response.request!.url.toString()); */
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

  static Future<String?> getMyResume(String token) async {
    var url = Uri.parse('${Constants.baseUrl}get-cv');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ).timeout(
          const Duration(seconds: 10),
        );
        switch (response.statusCode) {
          case 200:
            return response.body;

          // return userFromJson(response.body);

          case 400:
            throw BadRequestException(utf8.decode(response.bodyBytes),
                response.request!.url.toString());

          default:
            // print(response.body);
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
