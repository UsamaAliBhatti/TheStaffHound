import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/archive_jobs_response.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class ArchivedJobsController extends GetxController {
  var archivedJobsList = <ArchivedJobsResponse>[].obs;
  var isLoaded = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    token.value = SharedPrefsManager.getUserToken;
    fetchArchivedJobs(token.value);
    super.onInit();
  }

  fetchArchivedJobs(String token) async {
    var response = await RestApiServices.getArchivedJobs(token);
    if (response != null) {
      isLoaded.value = true;
      archivedJobsList.value = response;
    } else {
      isLoaded.value = false;
    }
  }
}
