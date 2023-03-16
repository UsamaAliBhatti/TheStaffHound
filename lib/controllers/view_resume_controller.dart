import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_staff_hound/api_services/resume_service/resume_apis.dart';
import 'package:the_staff_hound/api_services/resume_service/resume_model.dart';
import 'package:the_staff_hound/models/education_model.dart';
import 'package:the_staff_hound/models/experience_model.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class ResumeViewController extends GetxController {
  var userToken = ''.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhone = ''.obs;
  var userAddress = ''.obs;
  var aboutMe = ''.obs;
  var skillsList = [].obs;
  var languagesList = [].obs;
  var educationList = <UserEducation>[].obs;
  var experienceList = <UserExperienceModel>[].obs;

  var isLoaded = false.obs;
  var isEmpty = false.obs;
  @override
  void onInit() {
    userToken.value = SharedPrefsManager.getUserToken;
    getResume(userToken.value);
    userName.value = SharedPrefsManager.getUserName;
    userEmail.value = SharedPrefsManager.getUserEmail;
    userAddress.value = SharedPrefsManager.getUserAddress ?? '';
    userPhone.value = SharedPrefsManager.getUserPhoneNumber ?? '';
    super.onInit();
  }

  final DateFormat format = DateFormat('yyyy-MM-dd');
  getResume(String token) async {
    isLoaded.value = false;
    var response = await ResumeApis.getMyResume(token);
    if (response != null) {
      isEmpty.value = false;
      isLoaded.value = true;
      var resumeResponse = resumeModelFromJson(response);
      aboutMe.value = resumeResponse.data[0].aboutMe;
      skillsList.value = getStringList(resumeResponse.data[0].skills);
      languagesList.value = getStringList(resumeResponse.data[0].languages);

      experienceList.value = List<UserExperienceModel>.from(
          resumeResponse.data[0].experience.map((e) => UserExperienceModel(
              e.designation,
              e.company,
              format.format(e.startDate),
              e.endDate != null ? format.format(e.endDate) : null)));
      educationList.value = List<UserEducation>.from(
          resumeResponse.data[0].education.map((e) => UserEducation(
              e.qualification,
              e.institute,
              format.format(e.startDate),
              e.endDate != null ? format.format(e.endDate) : null)));

      /*  print(skillsList);
      print(experienceList);
      print(educationList);
      print(languagesList); */
    } else {
      isLoaded.value = false;
      Timer(const Duration(seconds: 3), () {
        isEmpty.value = true;
        //Get.off(() => LoginActivity());
      });
    }
  }

  List<String> getStringList(String data) {
    final removedBrackets = data.substring(1, data.length - 1);
    return removedBrackets.split(',');
  }
}
