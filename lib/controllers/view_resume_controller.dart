import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/resume_response.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
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

  getResume(String token) async {
    isLoaded.value = false;
    var response = await RestApiServices.getUserResume(token);
    if (response != null) {
      isEmpty.value = false;
      isLoaded.value = true;
      ResumeResponse resumeResponse = response;
      aboutMe.value = resumeResponse.aboutMe!;
      skillsList.value = jsonDecode(resumeResponse.skills!).cast<String>();
      languagesList.value = jsonDecode(resumeResponse.languages!);

      experienceList.value = List<UserExperienceModel>.from(
          jsonDecode(resumeResponse.experience!)
              .map((element) => UserExperienceModel.fromJson(element)));
      educationList.value = List<UserEducation>.from(
          jsonDecode(resumeResponse.education!)
              .map((element) => UserEducation.fromJson(element)));

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
}
