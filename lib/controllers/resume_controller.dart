import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ResumeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedImagepath = ''.obs;
  var selectedImageSize = ''.obs;

  var educationStartDate = 'Start Year'.obs;
  var educationEndDate = 'End Year'.obs;

  var isSelected = <bool>[false, false].obs;
  var continueText = 'Continue'.obs;

  var experienceStartDate = 'Start Year'.obs;
  var experienceEndDate = 'End Year'.obs;
  var isExperienceContinue = <bool>[false, false].obs;

  var aboutMeText = ''.obs;
  var userSkills = [].obs;
  var userLanguages = [].obs;
  var userExperiences = [].obs;
  var userEducations = [].obs;
  var userSelectedSkillsList = [].obs;
  var userSelectedLanguagesList = [].obs;

  var skillsList = [
    'Programming',
    'Graphic designing',
    'Web Development',
    'Mobile App Development',
    'Backend Development'
  ].obs;
  var selectedSkill = 'Programming'.obs;

  var languagesList = [
    'Urdu',
    'Punjabi',
    'Sindhi',
    'Balochi',
    'Pashto',
    'English',
    'Spanish',
    'French'
  ].obs;
  var selectedLanguage = 'Urdu'.obs;

// get profile image method
  void getImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagepath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagepath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              'Mb';
    } else {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

// add education start date dialog
  chooseEducationStartDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());

    if (pickedDate != null /* && pickedDate != selectedStartDate.value */) {
      educationStartDate.value = DateFormat.MEd().format(pickedDate);
      update();
    }
  }

// add experience start date dialog
  chooseExperienceStartDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());

    if (pickedDate != null /* && pickedDate != selectedStartDate.value */) {
      experienceStartDate.value = DateFormat.MEd().format(pickedDate);
      update();
    }
  }

// add education end date dialog
  chooseEducationEndDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2030));

    if (pickedDate != null /* && pickedDate != selectedStartDate.value */) {
      educationEndDate.value = DateFormat.MEd().format(pickedDate);
      update();
    }
  }

// add experience end date dialog
  chooseExperienceEndDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2030));

    if (pickedDate != null /* && pickedDate != selectedStartDate.value */) {
      experienceEndDate.value = DateFormat.MEd().format(pickedDate);
      update();
    }
  }

// yes or no selection dialog for education
  void selectYesOrNO(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
  }

// yes or no selection dialog for experience
  void selectYesOrNOForExperience(int index) {
    for (int i = 0; i < isExperienceContinue.length; i++) {
      if (i == index) {
        isExperienceContinue[i] = true;
      } else {
        isExperienceContinue[i] = false;
      }
    }
  }

// Education state updation Dialog
  Future<bool> updateEducationState() async {
    isSelected = [false, false].obs;
    educationStartDate = 'Start Year'.obs;
    educationEndDate = 'End Year'.obs;
    return true;
  }

// Experience state updation Dialog
  Future<bool> updateExperienceState() async {
    isExperienceContinue = [false, false].obs;
    experienceStartDate = 'Start Year'.obs;
    experienceEndDate = 'End Year'.obs;
    return true;
  }

// select list method
  void selectSkill(Object value) {
    selectedSkill.value = value.toString();
  }

//Save User Skills Method
  saveUserSkills() {
    if (!userSelectedSkillsList.contains(selectedSkill.value)) {
      userSelectedSkillsList.add(selectedSkill.value);
      update();
    } else {
      return;
    }
  }

//Save User Languages Method
  saveUserLanguages() {
    if (!userSelectedLanguagesList.contains(selectedLanguage.value)) {
      userSelectedLanguagesList.add(selectedLanguage.value);
      update();
    } else {
      return;
    }
  }

// select list language
  void selectLanguage(Object value) {
    selectedLanguage.value = value.toString();
  }

  // void getProfileImage(Image)
}
