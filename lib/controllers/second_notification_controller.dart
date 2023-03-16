import 'package:get/get.dart';

import '../api_services/main_api_services.dart';
import '../api_services/response_models/single_project_response.dart';
import '../constants.dart';
import '../shared_prefs/shared_prefs.dart';

class SecondNotificationController extends GetxController {
  var isDescriptionPressed = false.obs;
  var isDutiesPressed = false.obs;
  var isWorkSchedulePressed = false.obs;
  // var jobDetail = JobDetail().obs;
  var jobId = 0.obs;
  var isLoaded = false.obs;
  var userToken = ''.obs;
  var status = ''.obs;
  var type = ''.obs;
  var id = 0.obs;
  var offerDetail = SingleProjectResponse().obs;

  @override
  void onInit() {
    jobId.value = Get.arguments[0]['offerID'];
    type.value = Get.arguments[0]['type'];
    id.value = Get.arguments[0]['id'];

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

  confirmJob() async {
    print(id.value);
    print(type.value);
    switch (type.value) {
      case 'applied_jobs':
        var response = await ApiServices.acceptDirectApplyConfirmation(
            SharedPrefsManager.getUserToken, id.value);
        if (response!.statusCode == 200) {
          Constants.showToast('This job now has been assigned to you');
          Get.back();
        } else {
          print(response.statusCode);
          Constants.showToast('An error has occured. Please tr again later');
          Get.back();
        }
        break;
      case 'offers':
        var response = await ApiServices.acceptOfferConfirmation(
            SharedPrefsManager.getUserToken, id.value);
        if (response!.statusCode == 200) {
          Constants.showToast('This job now has been assigned to you');
          Get.back(result: 'refresh');
        } else {
          Constants.showToast('An error has occured. Please tr again later');
          Get.back();
        }
        break;
      default:
        // print(response.statusCode);
        Constants.showToast('An error has occured. Please tr again later xyz');
        Get.back();

        break;
    }
  }
}
