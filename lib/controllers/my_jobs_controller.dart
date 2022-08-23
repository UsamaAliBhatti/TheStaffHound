import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/my_jobs_response.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class MyJobsController extends GetxController {
  var appliedJobsList = <Job>[].obs;
  var approvedJobsList = <Job>[].obs;
  var completedJobsList = <Job>[].obs;
  var rejectedJobsList = <Job>[].obs;
  // var waitingJobsList = <Job>[].obs;
  var isLoaded = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    token.value = SharedPrefsManager.getUserToken;
    getAppliedJobs(token.value);
    super.onInit();
  }

  getAppliedJobs(String token) async {
    var response = await RestApiServices.getAppliedJobs(token);
    if (response != null) {
      isLoaded.value = true;
      appliedJobsList.value = response.appliedJobs!;
      approvedJobsList.value = response.approvedJobs!;
      // waitingJobsList.value = response.waitingJobs!;
      rejectedJobsList.value = response.rejectedJobs!;
      completedJobsList.value = response.completedJobs!;
    } else {
      isLoaded.value = false;
    }
  }
}
