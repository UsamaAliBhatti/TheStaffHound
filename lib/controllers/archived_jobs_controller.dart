import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/archive_jobs_response.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

import '../api_services/main_api_services.dart';

class ArchivedJobsController extends GetxController {
  var archivedJobsList = <Success>[].obs;
  var isLoaded = false.obs;

  @override
  void onInit() {
    fetchArchivedJobs(SharedPrefsManager.getUserToken);
    super.onInit();
  }

  fetchArchivedJobs(String token) async {
    var response = await ApiServices.getSavedProjects(token);
    if (response != null && response.statusCode == 200) {
      var data = savedJobsResponseFromJson(response.body);
      archivedJobsList.value = data.success;
      isLoaded.value = true;
    } else {
      debugPrint(response!.statusCode.toString());
      isLoaded.value = false;
    }
  }
}
