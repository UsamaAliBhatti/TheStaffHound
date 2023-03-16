import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/main_api_services.dart';
import 'package:the_staff_hound/api_services/response_models/single_project_response.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/routes/app_pages.dart';

import '../custom_widgets/app_text.dart';
import '../shared_prefs/shared_prefs.dart';

class JobDetailController extends GetxController
    with GetTickerProviderStateMixin {
  var isDescriptionPressed = false.obs;
  var isDutiesPressed = false.obs;
  var isWorkSchedulePressed = false.obs;
  // var jobDetail = JobDetail().obs;
  var jobId = 0.obs;
  var isLoaded = false.obs;
  var userToken = ''.obs;
  var status = ''.obs;
  var type = ''.obs;

  late TabController tabController;
  late ScrollController scrollController;
  var isApplied = false.obs;
  var offerDetail = SingleProjectResponse().obs;
  // late Timer _timer;

  var seconds = 5.obs;
  @override
  void onInit() {
    super.onInit();

    /*  tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    userToken.value = SharedPrefsManager.getUserToken; */
    jobId.value = Get.arguments[0]['offerID'];
    type.value = Get.arguments[0]['type'];
    // status.value = Get.arguments[0]['status'];

    fetchJobDetails(jobId.value, SharedPrefsManager.getUserToken);
  }

  fetchJobDetails(int id, String token) async {
    var response = await ApiServices.getSingleProjects(token, id);
    if (response!.statusCode == 200) {
      offerDetail.value = singleProjectResponseFromJson(response.body);

      status.value = offerDetail.value.success!.savedJob!.status;

      // jobDetail.value = ;
      // print(offerDetail.toJson());

      // isLoaded.value = true;
    } else {
      Constants.showToast('An error has occured. Please tr again later');
      // isLoaded.value = false;
    }
  }

/*   Future<bool> checkResume() async {
    isApplied.value = true;

    var isChecked =
        await RestApiServices.checkResume(SharedPrefsManager.getUserToken);
    if (isChecked == 'true') {
      return true;
    } else {
      isApplied.value = false;

      return false;
    }
  } */

  saveProject(int id, int status) async {
    var response = await ApiServices.saveProject(
        SharedPrefsManager.getUserToken, id, status);
    if (response!.statusCode == 200) {
      // print('Error Not Given');
      fetchJobDetails(id, SharedPrefsManager.getUserToken);
    } else {
      print(response.body);
    }
  }

  notInterestedInJob() {
    RestApiServices.addNotInterested(userToken.value, jobId.value);
  }

  /* startTimer() {
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
 */
  applyForJob() async {
    var response = await ApiServices.applyJob(
        SharedPrefsManager.getUserToken, jobId.value);

    if (response!.statusCode == 200) {
      showErrorDialog(
          dialogTitle: 'Success',
          type: 0,
          message: 'Applied to this job successfully');
      // var data = appliedJobsResponseFromJson(response.body);
    } else if (response.statusCode == 202) {
      showErrorDialog(
          dialogTitle: 'Failed',
          type: 2,
          message: 'Resume not found. Please create your resume first');
    } else if (response.statusCode == 201) {
      showErrorDialog(
          dialogTitle: 'Failed', type: 1, message: 'Already Applied this Job');
    } else {
      Constants.showToast('ERROR Occured. Please Try Again Later');
    }

    // startTimer();

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

  showErrorDialog({
    String? dialogTitle,
    String? message,
    int? type,
  }) {
    showDialog(
        context: Get.overlayContext!,
        builder: (context) => AlertDialog(
              title: AppText(
                text: dialogTitle!,
                textSize: 20,
                isBold: true,
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Image.asset(
                  type == 0 ? Constants.successImg : Constants.failedImg,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  text: message!,
                  textSize: 16,
                  textColor: Colors.black,
                )
              ]),
              actions: [
                type == 2
                    ? TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: AppText(
                          text: 'Cancel',
                          textColor: Colors.grey,
                        ))
                    : const SizedBox(),
                TextButton(
                    onPressed: () {
                      switch (type) {
                        case 0:
                          Get.back();
                          break;
                        case 1:
                          Get.back();

                          break;
                        case 2:
                          Get.back();
                          Get.toNamed(Routes.CREATE_RESUME);
                          break;
                        default:
                          Get.back();
                          break;
                      }
                    },
                    child: AppText(text: 'OK')),
              ],
            ));
  }
  /* undoForJob() {
    // if (isApplied.isTrue) {
    //   isApplied.value = false;
    //   seconds.value = 5;
    //
    // }
    isApplied.value = false;
  }

  addToArchive(int jobId) {
    RestApiServices.addToArchive(userToken.value, jobId);
  } */
}
