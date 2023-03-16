import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/main_api_services.dart';
import 'package:the_staff_hound/api_services/response_models/announcements_response.dart'
    as announcements;

import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

import '../api_services/response_models/notifications_response.dart';

class NotificationController extends GetxController {
  var announcementsList = <announcements.Data>[].obs;
  var notificationsList = <Data>[].obs;
  var isLoaded = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    token.value = SharedPrefsManager.getUserToken;
    fetchAnnouncements(token.value);
    fetchNotifications(token.value);
  }

  fetchNotifications(String token) async {
    var response = await ApiServices.getOffersNotification(token);
    if (response!.statusCode == 200) {
      var data = offerNotificationResponseFromJson(response.body);
      notificationsList.addAll(data.success.offers.data);
      notificationsList.addAll(data.success.approvedRequests.data);
    } else {
      Constants.showToast('ERROR OCCURED. Please try again later');
    }
  }

  fetchAnnouncements(String token) async {
    var response = await ApiServices.getAnnouncements(token);
    if (response!.statusCode == 200) {
      var data = announcements.announcementsResponseFromJson(response.body);
      announcementsList.value = data.success.notify.data;
    } else {
      Constants.showToast('ERROR OCCURED. Please try again later');
    }
  }

  updateAnnouncementsStatus(String token, int id) async {
    var response = await ApiServices.updateNotificationStatus(token, id);
    if (response!.statusCode == 200) {
      fetchAnnouncements(token);
    }
  }

  updateAssignmentsStatus(
    String token,
    String status,
    int id,
  ) async {
    var response = await ApiServices.updateOffer(token, status, id, 1);
    if (response!.statusCode == 200) {
      fetchNotifications(token);
    } else {
      print(response.statusCode);
    }
  }

  showDetailsDialog(String message, int id) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Row(children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade300,
                  child: Image.asset(
                    Constants.splashLogo,
                    width: 23,
                    height: 23,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                AppText(
                  text: 'Branch',
                  isBold: true,
                  textSize: 20,
                ),
              ]),
              content: AppText(
                text: message,
                textSize: 16,
                textColor: Colors.black,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      fetchAnnouncements(SharedPrefsManager.getUserToken);
                      Get.back();
                    },
                    child: AppText(
                      text: 'Okay',
                      isBold: true,
                    ))
              ],
            ));
  }

  /* fetchAllNotifications(String token) async {
    var response = await RestApiServices.getAllNotifications(token);
    if (response != null) {
      isLoaded.value = true;
      notificationsList.value = response.application!;
    } else {
      isLoaded.value = false;
    }
  } */
}
