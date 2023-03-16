import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/offer_response.dart';

import '../api_services/main_api_services.dart';
import '../api_services/response_models/job_detail_response.dart';
import '../api_services/response_models/single_project_response.dart';
import '../constants.dart';
import '../shared_prefs/shared_prefs.dart';

class NotificationDetailController extends GetxController {
  var isDescriptionPressed = false.obs;
  var isDutiesPressed = false.obs;
  var isWorkSchedulePressed = false.obs;
  var jobDetail = JobDetail().obs;
  var jobId = 0.obs;
  var isLoaded = false.obs;
  var userToken = ''.obs;
  var status = ''.obs;
  var type = ''.obs;
  var offerDetail = SingleProjectResponse().obs;
  var isAccepted = 'Nope'.obs;

  @override
  void onInit() {
    jobId.value = Get.arguments[0]['offerID'];
    type.value = Get.arguments[0]['type'];
    fetchJobDetails(jobId.value, SharedPrefsManager.getUserToken);
    super.onInit();
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

  saveProject(int id, int status) async {
    var response = await ApiServices.saveProject(
        SharedPrefsManager.getUserToken, id, status);
    if (response!.statusCode == 200) {
      // print('Error Not Given');
      fetchJobDetails(id, SharedPrefsManager.getUserToken);
    } else {
      Constants.showToast('Error Occured. Please Try again later');
      //print(response.body);
    }
  }

  respondToOffer(int projectID, String status) async {
    var response = await ApiServices.respondToOffer(
        SharedPrefsManager.getUserToken, projectID, status);
    if (response!.statusCode == 200) {
      var data = offerResponseFromJson(response.body);
      if (data.success!.status == 'declined') {
        isAccepted.value = 'declined';
      } else if (data.success!.status == 'accepted') {
        isAccepted.value = 'accepted';
      }
    } else if (response.statusCode == 201) {
      Constants.showToast('Invalid Offer');
      isAccepted.value = 'nope';
    } else {
      Constants.showToast('ERROR OCCURED. Please try again later');
    }
  }
}
