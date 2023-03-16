import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_staff_hound/api_services/response_models/archive_jobs_response.dart';
import 'package:the_staff_hound/api_services/response_models/forgot_password_email_response.dart';
import 'package:the_staff_hound/api_services/response_models/my_jobs_response.dart';
import 'package:the_staff_hound/api_services/response_models/job_detail_response.dart';
import 'package:the_staff_hound/api_services/response_models/jobs_response.dart';
import 'package:the_staff_hound/api_services/response_models/notifications_response.dart';
import 'package:the_staff_hound/api_services/response_models/profile_response.dart';
import 'package:the_staff_hound/api_services/response_models/resume_response.dart';
import 'package:the_staff_hound/api_services/response_models/user_login_signup_response.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/views/email_otp_screen.dart';
import 'package:the_staff_hound/views/reset_password_screen.dart';

class RestApiServices {
  static const _baseUrl = 'https://api.thestaffhound.com/api/';

  //----------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method for user login--------------------------------------////
  //----------------------------------------------------------------------------------------------------//
  static Future<bool?> userLogin(userEmail, userPassword) async {
    try {
      var token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print(token);
        var client = http.Client();

        var uri = Uri.parse('${_baseUrl}login');

        http.Response response = await client.post(uri, body: {
          'email': userEmail,
          'password': userPassword,
          'password_confirmation': userPassword,
          'device_token': token,
        }).timeout(const Duration(seconds: 15));

        /*  if (response.statusCode == 200) {
    var json = response.body;
    print('Login Successful');
    var userModel = userResponseFromJson(json);
    saveUserMethod(userModel, 'Login', 'Login Successfull');
    return true;
  } else if (response.statusCode == 202) {
    print('Error: Password Mismatch');
    Get.snackbar('Error', 'Password Mismatch');
    return false;
  } else {
    print('Error: User does not exist');
    Get.snackbar('Invalid', 'User Does Not Exist');
    return false;
  } */

        switch (response.statusCode) {
          case 200:
            var json = response.body;
            print('Login Successful');
            var userModel = userResponseFromJson(json);
            // saveUserMethod(userModel, 'Login', 'Login Successfull');
            return true;
          case 202:
            print('Error: Password Mismatch');
            Get.snackbar('Error', 'Password Mismatch');
            return false;

          default:
            print('Error: User does not exist');
            Get.snackbar('Invalid', 'User Does Not Exist');
            return false;
        }
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
    }
    return null;
  }

  //-------------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method for user registration/sign up--------------------------------------////
  //-------------------------------------------------------------------------------------------------------------------//
  static Future<String?> userSignUp(Map<String, dynamic> data) async {
    // try {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}new_register');

      http.Response response = await client
          .post(uri, body: data)
          .timeout(const Duration(seconds: 15));

      /*   if (response.statusCode == 200) {
    Get.snackbar('Sign Up', 'Your Account Created Successfully',
        snackPosition: SnackPosition.BOTTOM);
    return true;
  } else if (response.statusCode == 202) {
    print('Error: Password Mismatch');
    Get.snackbar('Error', 'Account already exist.');
    return false;
  } else {
    print('error ${response.body}');
    return false;
  } */
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          /* Get.snackbar('Sign Up', 'Your Account Created Successfully',
          snackPosition: SnackPosition.BOTTOM); */
          showToast('Account Created Successfully');
          // Get.back();
          return response.body;
        case 201:
          showToast('Eamil has already been taken');
          return null;
        case 202:
          showToast('Password Mismatch');
          return null;
        default:
          return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  
  //----------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get dashboard data-------------------------------------////
  //----------------------------------------------------------------------------------------------------------//
  static Future<String?> getDashboardData(String token) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}dashboard');

      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));

      if (response.body.isNotEmpty) {
        return response.body;
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //---------------------------------------------------------------------------------------------------------//
  ////----------------------------------------Method to get all jobs---------------------------------------////
  //---------------------------------------------------------------------------------------------------------//
  static Future<JobsResponse?> getAllJobs(String token) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}get_all_jobs');

      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));

      if (response.body.isNotEmpty) {
        var jsonString = response.body;
        return jobsResponseFromJson(jsonString);
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get all user's jobs--------------------------------------////
  //------------------------------------------------------------------------------------------------------------//
  static Future<MyJobsResponse?> getAppliedJobs(String token) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}applied_jobs');

      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));

      if (response.body.isNotEmpty) {
        var jsonString = response.body;
        return myJobsResponseFromJson(jsonString);
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //--------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to add job to saved jobs--------------------------------------////
  //--------------------------------------------------------------------------------------------------------------//
  static addToArchive(String token, int jobId) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}add_to_archive');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        'job_id': jobId.toString()
      }).timeout(const Duration(seconds: 15));

      showToast(response.body);
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
    }
  }

  //----------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to show no interest in job--------------------------------------////
  //----------------------------------------------------------------------------------------------------------------//
  static addNotInterested(String token, int jobId) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}not_interested');

      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        'job_id': jobId.toString()
      }).timeout(const Duration(seconds: 15));

      showToast(response.body);
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
    }
  }

  //-----------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get jobs by job category--------------------------------------////
  //-----------------------------------------------------------------------------------------------------------------//
  static Future<JobsResponse?> getJobsByCategory(int id, String token) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}jobs_by_category/$id');
      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return jobsResponseFromJson(jsonString);
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //--------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get job details by id--------------------------------------////
  //--------------------------------------------------------------------------------------------------------------//
  static Future<JobDetail?> getJobDetailsById(int id, String token) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}job_details/$id');
      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return jobDetailFromJson(jsonString);
      } else {
        return null;
      }
    } on Exception {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

/*   //---------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get all Branches--------------------------------------////
  //---------------------------------------------------------------------------------------------------------//
  static Future<BranchesModel?> getAllBranches() async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}getbranchesforseeker');
      http.Response response =
          await client.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        print('Branches Loaded Successfully...');
        return branchesFromJson(response.body);
      } else {
        print('Branch Error: ${response.statusCode}');
      }
      return null;
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  } */

  //----------------------------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to check if user CV\Resume is avaible or not--------------------------------------////
  //----------------------------------------------------------------------------------------------------------------------------------//
  static Future<String?> checkResume(String token) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}check_cv');
      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //--------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to create user CV/Resume--------------------------------------////
  //--------------------------------------------------------------------------------------------------------------//
  static Future<bool?> createResume(
      String token, Map<String, String> data) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}add_cv');
      http.Response response = await client.post(uri, body: data, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print(response.body);
        return false;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //-----------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get user CV/Resume--------------------------------------////
  //-----------------------------------------------------------------------------------------------------------//
  static Future<ResumeResponse?> getUserResume(String token) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}get_cv');
      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return resumeResponseFromJson(jsonResponse);
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //---------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get saved jobs----------------------------------------////
  //---------------------------------------------------------------------------------------------------------//
/*   static Future<List<ArchivedJobsResponse>?> getArchivedJobs(
      String token) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}get_archived_jobs');
      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return archivedJobsResponseFromJson(jsonResponse);
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }
 */
  //----------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get all notifications----------------------------------------////
  //---------------------------------------------------------------------------------------------------------------//
 /*  static Future<NotificationsResponse?> getAllNotifications(
      String token) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}getAllnotification');
      http.Response response = await client.get(uri, headers: {
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return notificationsResponseFromJson(jsonResponse);
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  } */

  //------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to apply for job--------------------------------------////
  //------------------------------------------------------------------------------------------------------//
  static Future<String?> applyForJob(String token, int jobId) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}apply_job');
      http.Response response = await client.post(uri, headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        'job_id': jobId.toString()
      }).timeout(const Duration(seconds: 15));

      switch (response.statusCode) {
        case 200:
          return 'success';
        case 201:
          return 'already exist';
        case 400:
          return 'resume not exist';
        default:
          return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //---------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to get User Profile--------------------------------------////
  //---------------------------------------------------------------------------------------------------------//
  static Future<ProfileResponse?> getMyProfile(String token) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}get_profile');
      http.Response response = await client.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return profileResponseFromJson(jsonResponse);
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to update User Profile--------------------------------------////
  //------------------------------------------------------------------------------------------------------------//
  static Future<ProfileResponse?> updateMyProfile(
      String token, Map<String, String> data) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}update_profile');
      http.Response response = await client
          .post(uri, headers: {'Authorization': 'Bearer $token'}, body: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        return profileResponseFromJson(jsonResponse);
      } else {
        return null;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return null;
    }
  }

  //--------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to change password--------------------------------------////
  //--------------------------------------------------------------------------------------------------------//
  static Future<bool?> changePassword(
      String token, Map<String, String> data) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}change_password');
      http.Response response = await client
          .post(uri, headers: {'Authorization': 'Bearer $token'}, body: data)
          .timeout(const Duration(seconds: 15));

      var msgResponse = jsonDecode(response.body);

      switch (msgResponse['message']) {
        case 'password changed':
          showToast('Password changed successfully');
          return true;
        case 'password not matched':
          showToast('Password not matched');
          return false;
        default:
          showToast('Error occured. Try again later!');
          return false;
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
      return false;
    }
  }

  //-------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to Undo Apply Job--------------------------------------////
  //-------------------------------------------------------------------------------------------------------//
  static undoApplyJob(String token, String jobId) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}remove_applicant');
      http.Response response = await client.post(uri,
          headers: {'Authorization': 'Bearer $token'},
          body: {'job_Id': jobId}).timeout(const Duration(seconds: 15));

      var msgResponse = jsonDecode(response.body);
      if (msgResponse == 'success') {
        showToast('Undo successfully');
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
    }
  }

  //----------------------------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method To Send Email To Get OTP For Forgot Password--------------------------------------////
  //----------------------------------------------------------------------------------------------------------------------------------//
  static sendEmailForOTP(String email) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}forget_password');
      http.Response response = await client.post(uri,
          body: {'email': email}).timeout(const Duration(seconds: 15));

      var data = forgotPasswordEmailResponseFromJson(response.body);
      if (data.status == 'True') {
        Get.off(() => EmailOTPActivity(), arguments: {'email': data.data});
      } else {
        showToast('Email Not Matched');
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
    }
  }

  //--------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method To Verify OTP From Email--------------------------------------////
  //--------------------------------------------------------------------------------------------------------------//
  static verifyEmailOTP(String email, String code) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}check_code');
      http.Response response = await client.post(uri, body: {
        'email': email,
        'code': code
      }).timeout(const Duration(seconds: 15));

      var data = forgotPasswordEmailResponseFromJson(response.body);
      if (data.status == 'True') {
        Get.off(() =>  ResetPasswordActivity(), arguments: {
          'email': email
        });
      } else {
        showToast('Code Not Matched');
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
    }
  }

 //-------------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method To Reset User Password--------------------------------------////
  //------------------------------------------------------------------------------------------------------------//
  static resetUserPassword(String email, String code) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}change_forget_password');
      http.Response response = await client.post(uri, body: {
        'email': email,
        'code': code
      }).timeout(const Duration(seconds: 15));

      var data = forgotPasswordEmailResponseFromJson(response.body);
      if (data.status == 'True') {
        Get.off(() =>  ResetPasswordActivity(), arguments: {
          'email': email
        });
      } else {
        showToast('Code Not Matched');
      }
    } on TimeoutException {
      showToast('Request timeout. Please try again later.');
    }
  }


  //-------------------------------------------------------------------------------------------------------//
  ////-------------------------------------Method to Save User Data--------------------------------------////
  //-------------------------------------------------------------------------------------------------------//
  

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
}
