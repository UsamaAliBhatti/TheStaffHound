import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/notifications_response.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class NotificationController extends GetxController {
  var notificationsList = <Application>[].obs;

  var isLoaded = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    token.value = SharedPrefsManager.getUserToken;
    fetchAllNotifications(token.value);
  }

  fetchAllNotifications(String token) async {
    var response = await RestApiServices.getAllNotifications(token);
    if (response != null) {
      isLoaded.value = true;
      notificationsList.value = response.application!;
    } else {
      isLoaded.value = false;
    }
  }
}
