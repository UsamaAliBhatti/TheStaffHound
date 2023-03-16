import 'package:get/get.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

import '../api_services/main_api_services.dart';
import '../api_services/response_models/save_project_response.dart';

class JobItemController extends GetxController {
  saveProject(int id, int status) async {
    var response = await ApiServices.saveProject(
        SharedPrefsManager.getUserToken, id, status);
    if (response!.statusCode == 200) {
      saveProjectResponseFromJson(response.body);
     
    }
  }
}
