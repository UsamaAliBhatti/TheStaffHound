import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_staff_hound/network_manager/network_state_manager.dart';

import '../../constants.dart';
import '../exceptions/api_exceptions.dart';

class ResumeApis{
  static var client = http.Client();

  static final NetworkManager _networkManager = Get.find<NetworkManager>();

   // Create Resume Method
  static Future<String?> createMyResume(String token, Map<String, dynamic> resumeData) async {
    var url = Uri.parse('${Constants.baseUrl}add_cv');
    var isConnected = await _networkManager.checkInternetConnection();

    if (isConnected) {
      try {
        var response = await client
            .post(url, body: resumeData, headers: {
              'Authorization': 'Bearer $token'
            }).timeout(
          const Duration(seconds: 10),
        );
        switch (response.statusCode) {
          case 200:
            // return userFromJson(response.body);
         
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