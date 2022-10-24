import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/job_detail_response.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';

import '../shared_prefs/shared_prefs.dart';

class JobDetailController extends GetxController
    with GetTickerProviderStateMixin {
  var isDescriptionPressed = false.obs;
  var isDutiesPressed = false.obs;
  var isWorkSchedulePressed = false.obs;
  var jobDetail = JobDetail().obs;
  var jobId = 0.obs;
  var isLoaded = false.obs;
  var userToken = ''.obs;
  var status = ''.obs;

  late TabController tabController;
  late ScrollController scrollController;
  var isApplied = false.obs;
  late Timer _timer;

  var seconds = 5.obs;
  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    userToken.value = SharedPrefsManager.getUserToken;
    // jobId.value = Get.arguments[0]['jobId'];
    // status.value = Get.arguments[0]['status'];
    print(jobId.value);
    fetchJobDetails(jobId.value, SharedPrefsManager.getUserToken);
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
    scrollController.dispose();
    _timer.cancel();
  }

  fetchJobDetails(int id, String token) async {
    var response = await RestApiServices.getJobDetailsById(id, token);
    if (response != null) {
      jobDetail.value = response;
      print(jobDetail.toJson());
      isLoaded.value = true;
    } else {
      isLoaded.value = false;
    }
  }

  Future<bool> checkResume() async {
    isApplied.value = true;

    var isChecked =
        await RestApiServices.checkResume(SharedPrefsManager.getUserToken);
    if (isChecked == 'true') {
      return true;
    } else {
      isApplied.value = false;

      return false;
    }
  }

  notInterestedInJob() {
    RestApiServices.addNotInterested(userToken.value, jobId.value);
  }

  startTimer() {
    isApplied.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value != 0) {
        seconds.value--;
        isApplied.value = true;
      } else {
        isApplied.value = false;
        timer.cancel();
      }
    });
  }

  applyForJob() async {
    // startTimer();

    isApplied.value = true;

    /*  var response =
          await RestApiServices.applyForJob(userToken.value, jobId.value);
      print(response);
      switch (response) {
        case 'success':
          Get.snackbar('Job', 'You applied to this job successfully',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 3));
          isApplied.value = true;
          break;
        case 'already exist':
          Get.snackbar('Job', 'You already applied to this job',
              snackPosition: SnackPosition.BOTTOM);
          isApplied.value = false;

          break;
        case 'resume not exist':
          Get.snackbar('Resume', 'Please create your resume first',
              snackPosition: SnackPosition.BOTTOM);
          isApplied.value = false;

          break;
        default:
          Get.snackbar('Error', 'Internal Server Error. Please try again later',
              snackPosition: SnackPosition.BOTTOM);
          isApplied.value = false;
      } */
  }

  undoForJob() {
    // if (isApplied.isTrue) {
    //   isApplied.value = false;
    //   seconds.value = 5;
    //
    // }
    isApplied.value = false;
  }

  addToArchive(int jobId) {
    RestApiServices.addToArchive(userToken.value, jobId);
  }
}
