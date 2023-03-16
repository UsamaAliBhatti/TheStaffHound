import 'dart:io';

import 'package:flutter/material.dart ';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/api_services/resume_service/resume_model.dart';
import 'package:the_staff_hound/main.dart';
import 'package:the_staff_hound/models/language_model.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../api_services/resume_service/resume_apis.dart';
import '../constants.dart';
import '../custom_widgets/app_text.dart';
import '../models/education_model.dart';
import '../models/experience_model.dart';

class ResumeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedImagepath = ''.obs;
  var selectedImageSize = ''.obs;
  final DateFormat format = DateFormat('yyyy-MM-dd');
// Skills Dialog Parameters
/*   var skillsList = [
    'Programming',
    'Graphic designing',
    'Web Development',
    'Mobile App Development',
    'Backend Development'
  ].obs; */
  // var selectedSkill = ''.obs;
  final otherSkillController = TextEditingController();
  var skillFormKey = GlobalKey<FormState>();
  var userSelectedSkillsList = <String>[].obs;
  var tempSkillsList = <String>[].obs;

// Language Dialog Parameters
/*   var languagesList = [
    'Urdu',
    'Punjabi',
    'Sindhi',
    'Balochi',
    'Pashto',
    'English',
    'Spanish',
    'French'
  ].obs; */
  // var selectedLanguage = 'Urdu'.obs;
  var languagesList = <LanguageModel>[].obs;
  var tempLanguagesList = <String>[].obs;
  final otherLanguageController = TextEditingController();
  var userSelectedLanguagesList = <String>[].obs;
  var languageFormKey = GlobalKey<FormState>();

//Experience Dialog Parameters
  final GlobalKey<FormState> experienceFormKey = GlobalKey<FormState>();
  final companyNameController = TextEditingController();
  final designationController = TextEditingController();
  var companyNameText = ''.obs;
  var designationText = ''.obs;
  var userExperienceList = <UserExperienceModel>[].obs;
  var experienceStartDate = ''.obs;
  var experienceEndDate = ''.obs;
  final _isExperienceContinue = 'toggle'.obs;

  //header dialog parameters
  /*  final introductionFormKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController(); */
  var phoneNumber = ''.obs;
  var address = ''.obs;

//Education Dialog Parameters
  final GlobalKey<FormState> educationFormKey = GlobalKey<FormState>();
  final qualificationController = TextEditingController();
  final instituteNameController = TextEditingController();
  var instituteNameText = ''.obs;
  var qualificationText = ''.obs;
  var educationStartDate = ''.obs;
  var educationEndDate = ''.obs;
  final _isEducationContinue = 'toggle'.obs;
  var userEducationsList = <UserEducation>[].obs;

  //About me methods Parameters
  final GlobalKey<FormState> aboutFormKey = GlobalKey<FormState>();
  final aboutMeTextController = TextEditingController();
  var aboutMeText = ''.obs;

  var userName = ''.obs;
  var userEmail = ''.obs;
  var userToken = ''.obs;

  // Custom Icons

  @override
  void onClose() {
    companyNameController.dispose();
    designationController.dispose();

    instituteNameController.dispose();
    qualificationController.dispose();

    aboutMeTextController.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    userToken.value = SharedPrefsManager.getUserToken;

    languagesList
        .add(LanguageModel(languageName: 'English', isSelected: false.obs));
    languagesList
        .add(LanguageModel(languageName: 'Spanish', isSelected: false.obs));
    languagesList
        .add(LanguageModel(languageName: 'Polish', isSelected: false.obs));
    languagesList
        .add(LanguageModel(languageName: 'Russian', isSelected: false.obs));
    languagesList
        .add(LanguageModel(languageName: 'Hindi', isSelected: false.obs));
    languagesList
        .add(LanguageModel(languageName: 'Urdu', isSelected: false.obs));
    languagesList
        .add(LanguageModel(languageName: 'Arabic', isSelected: false.obs));
    languagesList
        .add(LanguageModel(languageName: 'Chinese', isSelected: false.obs));

    // aboutMeTextController.text = aboutMeText.value;
    /*  addressController.text = address.value;
    phoneNumberController.text = phoneNumber.value; */
    userName.value = SharedPrefsManager.getUserName;
    userEmail.value = SharedPrefsManager.getUserEmail;
    address.value = SharedPrefsManager.getUserAddress ?? '';
    phoneNumber.value = SharedPrefsManager.getUserPhoneNumber ?? '';
    // getUserPhoneAndAddress(userToken.value);
    getResume(userToken.value);
    super.onInit();
  }

  getUserPhoneAndAddress(String token) async {
    var response = await RestApiServices.getMyProfile(token);
    if (response != null) {
      phoneNumber.value = response.profile!.phone!;
      address.value = response.address!;
    }
  }

  getResume(String token) async {
    address.value = SharedPrefsManager.getUserAddress ?? '';
    phoneNumber.value = SharedPrefsManager.getUserPhoneNumber ?? '';
    var response = await ResumeApis.getMyResume(token);
    if (response != null) {
      var resume = resumeModelFromJson(response);

      aboutMeText.value = resume.data[0].aboutMe;
      aboutMeTextController.text = aboutMeText.value;

      userSelectedSkillsList.value = getStringList(resume.data[0].skills);
      userSelectedLanguagesList.value = getStringList(resume.data[0].languages);
      userExperienceList.value = List<UserExperienceModel>.from(
          resume.data[0].experience.map((e) => UserExperienceModel(
              e.designation,
              e.company,
              format.format(e.startDate),
              e.endDate != null ? format.format(e.endDate) : null)));
      userEducationsList.value = List<UserEducation>.from(
          resume.data[0].education.map((e) => UserEducation(
              e.qualification,
              e.institute,
              format.format(e.startDate),
              e.endDate != null ? format.format(e.endDate) : null)));

      // userSelectedSkillsList.value = jsonDecode(resume.data!.skills!);
      /*   userSelectedLanguagesList.value =
          jsonDecode(response.languages!).cast<String>();

      userExperienceList.value = List<UserExperienceModel>.from(
          jsonDecode(response.experience!)
              .map((element) => UserExperienceModel.fromJson(element)));
      userEducationsList.value = List<UserEducation>.from(
          jsonDecode(response.education!)
              .map((element) => UserEducation.fromJson(element))); */

      // print(skillsList);
      // print(experienceList);
      // print(educationList);
      // print(languagesList);
    } else {
      aboutMeTextController.text = '';
      aboutMeText.value = '';
      userSelectedSkillsList.value = [];
      userEducationsList.value = [];
      userExperienceList.value = [];
      userSelectedLanguagesList.value = [];
    }
  }

// method to get Image from gallery
  void getImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagepath.value = pickedFile.path;
      selectedImageSize.value =
          '${((File(selectedImagepath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)}Mb';
    } else {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  List<String> getStringList(String data) {
    final removedBrackets = data.substring(1, data.length - 1);
    return removedBrackets.split(',');
  }
//---------------------------------------------------------------------------------------------//
//--------------------------------------Education Methods--------------------------------------//
//---------------------------------------------------------------------------------------------//

// Education Dialog
  void openEducationDialog(Size size) {
    showDialog(
        context: Get.overlayContext!,
        builder: (_) => AlertDialog(
              title: AppText(
                text: 'Education',
                textSize: 25,
                isBold: true,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              content: SizedBox(
                width: size.width,
                child: Form(
                  key: educationFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Degree / Certification",
                        ),
                        controller: qualificationController,
                        onSaved: (value) {
                          qualificationText.value = value!;
                        },
                        validator: (value) {
                          return validateQualificationTextField(value!);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Institute Name",
                        ),
                        controller: instituteNameController,
                        onSaved: (value) {
                          instituteNameText.value = value!;
                        },
                        validator: (value) {
                          return validateInstituteNameTextField(value!);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                chooseEducationStartDate();
                              },
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Constants.primaryColor)),
                                  child: AppText(
                                    text: (educationStartDate.value.isEmpty)
                                        ? 'Start Year'
                                        : educationStartDate.value,
                                    isBold: true,
                                    textSize: 18,
                                  ),
                                ),
                              )),
                          Obx(() => educationCalenderOrText())
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                  color: Constants.primaryColor, width: 2),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            onPressed: () {
                              updateEducationState();
                              Get.back();
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: AppText(
                                  text: 'Cancel',
                                  isBold: true,
                                  textSize: 15,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                            onPressed: () {
                              if (saveEducation()) {
                                Get.back();
                              }
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: AppText(
                                  text: 'Save',
                                  isBold: true,
                                  textSize: 15,
                                  textColor: Colors.white,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  //validate Qualification Text
  String? validateQualificationTextField(String value) {
    if (value.isEmpty) {
      return "please provide your designation";
    }

    return null;
  }

// validate Institiute textfield
  String? validateInstituteNameTextField(String value) {
    if (value.isEmpty) {
      return "please provide your company name";
    }
    return null;
  }

  // method to save education
  bool saveEducation() {
    final isValid = educationFormKey.currentState!.validate();

    if (!isValid) {
      showToast("Please Fill The Credentials");
      return false;
    } else {
      educationFormKey.currentState!.save();
      if (educationStartDate.isEmpty) {
        showToast('Please Enter Start Date');
        return false;
      } else {
        print(educationEndDate.value);
        userEducationsList.add(UserEducation(
            qualificationText.value,
            instituteNameText.value,
            educationStartDate.value,
            educationEndDate.value));

        updateEducationState();
        showToast("Data Saved Successfully");
        return true;
      }
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
      educationEndDate.value = format.format(pickedDate);
      update();
    }
  }

// add education start date dialog
  chooseEducationStartDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());

    if (pickedDate != null /* && pickedDate != selectedStartDate.value */) {
      educationStartDate.value = format.format(pickedDate);
      update();
    }
  }

  // Education state updation Dialog
  bool updateEducationState() {
    // educationFormKey.currentState!.reset();
    educationStartDate = ''.obs;
    educationEndDate = ''.obs;
    instituteNameController.text = '';
    qualificationController.text = '';
    _isEducationContinue.value = 'toggle';
    return true;
  }

// Education Calender Or Text method
  Widget educationCalenderOrText() {
    switch (_isEducationContinue.value) {
      case 'true':
        educationEndDate.value = '';
        return InkWell(
          onTap: () {
            chooseEducationEndDate();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Constants.primaryColor)),
            child: Obx(
              () => AppText(
                text: (educationEndDate.value.isEmpty)
                    ? 'Present'
                    : educationEndDate.value,
                isBold: true,
                textSize: 18,
              ),
            ),
          ),
        );
      case 'false':
        return InkWell(
          onTap: () {
            chooseEducationEndDate();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Constants.primaryColor)),
            child: Obx(
              () => AppText(
                text: (educationEndDate.value.isEmpty)
                    ? 'End Year'
                    : educationEndDate.value,
                isBold: true,
                textSize: 18,
              ),
            ),
          ),
        );
      default:
        return Column(
          children: <Widget>[
            AppText(
              text: 'Still Studying?',
              textSize: 15,
              isBold: true,
            ),
            const SizedBox(
              height: 5,
            ),
            ToggleSwitch(
              minWidth: 50,
              minHeight: 35,
              totalSwitches: 2,
              labels: const ['Yes', 'No'],
              fontSize: 16,
              initialLabelIndex: null,
              customTextStyles: const [
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
              ],
              activeBgColor: const [Constants.secondaryColor],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.grey[900],
              onToggle: (index) {
                switch (index) {
                  case 0:
                    _isEducationContinue.value = 'true';
                    break;
                  case 1:
                    _isEducationContinue.value = 'false';
                    break;
                }
              },
            ),
          ],
        );
    }
  }
//-------------------------------------------------------------------------------------------------//

//-------------------------------------------------------------------------------------------------//
//------------------------------------------Experience Methods-------------------------------------//
//-------------------------------------------------------------------------------------------------//

//Experience Dialog Method
  void openExperienceDialog(Size size) {
    showDialog(
        context: Get.overlayContext!,
        builder: (_) => AlertDialog(
              title: AppText(
                text: 'Experience',
                textSize: 25,
                isBold: true,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              content: SizedBox(
                width: size.width,
                child: Form(
                  key: experienceFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Title / Position",
                        ),
                        controller: designationController,
                        onSaved: (value) {
                          designationText.value = value!;
                        },
                        validator: (value) {
                          return validateDesignationTextField(value!);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Company Name",
                        ),
                        controller: companyNameController,
                        onSaved: (value) {
                          companyNameText.value = value!;
                        },
                        validator: (value) {
                          return validateCompanyNameTextField(value!);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                chooseExperienceStartDate();
                              },
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Constants.primaryColor)),
                                  child: AppText(
                                    text: (experienceStartDate.value.isEmpty)
                                        ? 'Start Year'
                                        : experienceStartDate.value,
                                    isBold: true,
                                    textSize: 18,
                                  ),
                                ),
                              )),
                          Obx(() => experienceCalenderOrText()),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                  color: Constants.primaryColor, width: 2),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            onPressed: () {
                              updateExperienceState();
                              Get.back();
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: AppText(
                                  text: 'Cancel',
                                  isBold: true,
                                  textSize: 15,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                            onPressed: () {
                              if (saveExperience()) {
                                Get.back();
                              }
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: AppText(
                                  text: 'Save',
                                  isBold: true,
                                  textSize: 15,
                                  textColor: Colors.white,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            ));
  }

//validate Designation Text
  String? validateDesignationTextField(String value) {
    if (value.isEmpty) {
      return "please provide your designation";
    }

    return null;
  }

// validate Company textfield
  String? validateCompanyNameTextField(String value) {
    if (value.isEmpty) {
      return "please provide your company name";
    }
    return null;
  }

//Method for saving User Experience
  bool saveExperience() {
    final isValid = experienceFormKey.currentState!.validate();

    if (!isValid) {
      showToast("Please Fill The Credentials");
      return false;
    } else {
      experienceFormKey.currentState!.save();
      if (experienceStartDate.isEmpty) {
        showToast('Please Enter Start Date');
        return false;
      } else {
        userExperienceList.add(UserExperienceModel(
            designationText.value,
            companyNameText.value,
            experienceStartDate.value,
            experienceEndDate.value));

        updateExperienceState();
        showToast("Data Saved Successfully");
        return true;
      }
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
      experienceStartDate.value = format.format(pickedDate);
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
      experienceEndDate.value = format.format(pickedDate);
      update();
    }
  }

// Experience state updation Dialog
  bool updateExperienceState() {
    experienceFormKey.currentState!.reset();
    designationController.text = '';
    companyNameController.text = '';
    experienceStartDate = ''.obs;
    experienceEndDate = ''.obs;
    _isExperienceContinue.value = 'toggle';

    return true;
  }

// Experience Calender Or Text method
  Widget experienceCalenderOrText() {
    switch (_isExperienceContinue.value) {
      case 'true':
        experienceEndDate.value = '';
        return InkWell(
          onTap: () {
            chooseExperienceEndDate();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Constants.primaryColor)),
            child: Obx(
              () => AppText(
                text: (experienceEndDate.value.isEmpty)
                    ? 'Present'
                    : experienceEndDate.value,
                isBold: true,
                textSize: 18,
              ),
            ),
          ),
        );
      case 'false':
        return InkWell(
          onTap: () {
            chooseExperienceEndDate();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Constants.primaryColor)),
            child: Obx(
              () => AppText(
                text: (experienceEndDate.value.isEmpty)
                    ? 'End Year'
                    : experienceEndDate.value,
                isBold: true,
                textSize: 18,
              ),
            ),
          ),
        );
      default:
        return Column(
          children: <Widget>[
            AppText(
              text: 'Still Continue?',
              textSize: 15,
              isBold: true,
            ),
            const SizedBox(
              height: 5,
            ),
            ToggleSwitch(
              minWidth: 50,
              minHeight: 35,
              totalSwitches: 2,
              labels: const ['Yes', 'No'],
              fontSize: 16,
              initialLabelIndex: null,
              customTextStyles: const [
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
              ],
              activeBgColor: const [Constants.secondaryColor],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.grey[900],
              onToggle: (index) {
                switch (index) {
                  case 0:
                    _isExperienceContinue.value = 'true';
                    break;
                  case 1:
                    _isExperienceContinue.value = 'false';
                    break;
                }
              },
            ),
          ],
        );
    }
  }
//-----------------------------------------------------------------------------------------------//

//-----------------------------------------------------------------------------------------------------//
//----------------------------------------------About me methods---------------------------------------//
//-----------------------------------------------------------------------------------------------------//
//About me textefield validation method
  String? validateAboutMeTextField(String value) {
    if (value.isEmpty) {
      return "please write about yourself";
    }

    return null;
  }

//About Me Dialog
  void openDescriptionDialog(size) {
    showDialog(
        context: Get.overlayContext!,
        builder: (_) => AlertDialog(
              backgroundColor: Constants.backgroundColor,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              title: AppText(
                text: 'About Yourself',
                textSize: 25,
                isBold: true,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              content: SizedBox(
                width: size.width,
                child: Form(
                  key: aboutFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: aboutMeTextController,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.start,
                        maxLines: 5,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: const InputDecoration(
                          isDense: true,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter about yourself here",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none),
                        ),
                        validator: (value) {
                          return validateAboutMeTextField(value!);
                        },
                        onSaved: (value) {
                          aboutMeTextController.text = value!;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Constants.primaryColor, width: 2),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  onPressed: () {
                    // updateExperienceState();
                    Get.back();
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: AppText(
                        text: 'Cancel',
                        isBold: true,
                        textSize: 15,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  onPressed: () {
                    if (saveAboutDescription()) {
                      Get.back();
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: AppText(
                        text: 'Save',
                        isBold: true,
                        textSize: 15,
                        textColor: Colors.white,
                      )),
                ),
              ],
            ));
  }

  bool saveAboutDescription() {
    if (aboutMeTextController.text.isNotEmpty) {
      aboutMeText.value = aboutMeTextController.text;
      showToast("Data Saved Succesfully");
      return true;
    }
    return false;
  }
  //------------------------------------------------------------------------------------------------------//

// Toast Method
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

//////----------------------------------------Skill Dialog Methods Starts--------------------------------------------//////
  // validate skill field
  String? validateSkillTextField(String value) {
    if (value.isEmpty) {
      return "please add your skill";
    }

    return null;
  }

  addSkill() {
    if (skillFormKey.currentState!.validate()) {
      if (!tempSkillsList.contains(otherSkillController.text)) {
        tempSkillsList.add(otherSkillController.text.capitalizeFirstofEach);
        otherSkillController.clear();
      } else {
        return;
      }
    }
  }

  removeSkill(int index) {
    if (tempSkillsList.isNotEmpty) {
      tempSkillsList.removeAt(index);
    } else {
      showToast('Please add skills first');
    }
  }

  //Save User Skills Method
  saveUserSkills() {
    if (tempSkillsList.isNotEmpty) {
      for (int i = 0; i < tempSkillsList.length; i++) {
        if (userSelectedSkillsList
            .every((element) => element != tempSkillsList[i])) {
          userSelectedSkillsList.add(tempSkillsList[i]);
        }
      }
    }
  }
  //////-------------------------------------------Skill Dialog Methods Ends---------------------------------------//////

  //////--------------------------------------Language Dialog Methods Starts--------------------------------------//////

  addLanguage() {
    if (languageFormKey.currentState!.validate()) {
      if (!tempLanguagesList.contains(otherLanguageController.text)) {
        tempLanguagesList
            .add(otherLanguageController.text.capitalizeFirstofEach);
        otherLanguageController.clear();
      } else {
        return;
      }
    }
  }

  addLanguageFromList(int index) {
    tempLanguagesList.add(languagesList[index].getLanguageName!);
  }

  removeLanguageAlongList(int index) {
    if (tempLanguagesList.isNotEmpty) {
      tempLanguagesList.removeWhere((element) =>
          languagesList[index].getLanguageName == element &&
          languagesList[index].getIsSelected == false);
    }
  }

  removeLanguage(int index) {
    if (tempLanguagesList.isNotEmpty) {
      // ignore: iterable_contains_unrelated_type
      if (languagesList
          .any((element) => element.languageName == tempLanguagesList[index])) {
        languagesList[languagesList.indexWhere(
                (element) => element.languageName == tempLanguagesList[index])]
            .isSelected!
            .value = false;
        // tempLanguagesList.removeAt(index);
      }

      tempLanguagesList.removeAt(index);
    }
  }

  // validate Language Text Field
  String? validateLanguageTextField(String value) {
    if (value.isEmpty) {
      return "Please add language first";
    }
    return null;
  }

  //Save User Languages Method
  saveUserLanguages() {
    if (tempLanguagesList.isNotEmpty) {
      for (int i = 0; i < tempLanguagesList.length; i++) {
        if (userSelectedLanguagesList
            .every((element) => element != tempLanguagesList[i])) {
          userSelectedLanguagesList.add(tempLanguagesList[i]);
          // return;
        }
      }
    }
  }

  //////----------------------------------------Language Dialog Methods End-------------------------------------------//////

  /*  userDetailDialogMethod(Size size) {
    showDialog(
        context: Get.overlayContext!,
        builder: (_) => AlertDialog(
              title: AppText(
                text: 'Contact Information',
                textSize: 25,
                isBold: true,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              content: SizedBox(
                width: size.width,
                child: Form(
                  key: introductionFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Phone Number",
                        ),
                        controller: phoneNumberController,
                        onSaved: (value) {
                          phoneNumber.value = value!;
                        },
                        validator: (value) {
                          return validatePhoneTextField(value!);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Address",
                        ),
                        controller: addressController,
                        onSaved: (value) {
                          address.value = value!;
                        },
                        validator: (value) {
                          return validateAddressTextField(value!);
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                  color: Constants.primaryColor, width: 2),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            onPressed: () {
                              //updateExperienceState();
                              Get.back();
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: AppText(
                                  text: 'Cancel',
                                  isBold: true,
                                  textSize: 15,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                            onPressed: () {
                              if (saveContactInfo()) {
                                Get.back();
                              }
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: AppText(
                                  text: 'Save',
                                  isBold: true,
                                  textSize: 15,
                                  textColor: Colors.white,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            ));
  }

   bool saveContactInfo() {
    final isValid = introductionFormKey.currentState!.validate();

    if (!isValid) {
      showToast("Please Fill The Credentials");
      return false;
    } else {
      introductionFormKey.currentState!.save();
      address.value = addressController.text;
      phoneNumber.value = phoneNumberController.text;
      showToast("Data Saved Successfully");
      return true;
    }
  }
 */
//validate phone Text
/*   String? validatePhoneTextField(String value) {
    if (value.isEmpty) {
      return "please provide your phone number";
    }

    return null;
  }

  //validate address Text
  String? validateAddressTextField(String value) {
    if (value.isEmpty) {
      return "please provide your address";
    }

    return null;
  } */

// Test Method
  // ignore: non_constant_identifier_names
  void TestCheck() {
    final isValid = experienceFormKey.currentState!.validate();

    if (!isValid) {
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    experienceFormKey.currentState!.save();
  }

// Method to create resume
  void createResume() async {
    if (aboutMeText.isEmpty) {
      showToast('Please Enter About Description');
    } else if (phoneNumber.isEmpty && address.isEmpty) {
      showToast('Please Enter your Contact Information');
    } else if (userExperienceList.isEmpty) {
      showToast('Please add some of your experience');
    } else if (userEducationsList.isEmpty) {
      showToast('Please add some of your education details');
    } else if (userSelectedLanguagesList.isEmpty) {
      showToast('Please add some languages that you know');
    } else if (userSelectedSkillsList.isEmpty) {
      showToast('Please add some of your skills');
    } else {
      /* Map<String, dynamic> data = {
        'about_me': aboutMeText.value,
        // 'phone': phoneNumber.value,
        'education': jsonEncode(userEducationsList),
        'skills': jsonEncode(userSelectedSkillsList),
        'experience': jsonEncode(userExperienceList),
        'languages': jsonEncode(userSelectedLanguagesList),
        // 'address': address.value
      }; */

      // print(data);

      var isCreated = await ResumeApis.createMyResume(
          SharedPrefsManager.getUserToken,
          educationList: userEducationsList,
          experienceList: userExperienceList,
          aboutMe: aboutMeText.value,
          skillsList: userSelectedSkillsList,
          languagesList: userSelectedLanguagesList);
      print(isCreated);
      if (isCreated!) {
        Get.back(result: 'refresh');
        print('Resume Created Successfully');
      } else {
        print('Error in Creating Resume');
      }
    }
  }

/* //  create Resume PDF Method
  Future<Uint8List> createResumePdf() async {
    late Uint8List emailIconBytes, phoneIconBytes, addressIconBytes;
    ByteData icHome = await rootBundle.load(Constants.ic_home_address);
    ByteData icPhone = await rootBundle.load(Constants.ic_phone);
    ByteData icEmail = await rootBundle.load(Constants.ic_email);
    emailIconBytes = icEmail.buffer.asUint8List();
    addressIconBytes = icHome.buffer.asUint8List();
    phoneIconBytes = icPhone.buffer.asUint8List();

    final pdfDocument = pw.Document();
    pdfDocument.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(20),
              child: pw.Column(
                children: [
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(horizontal: 10),
                    child: pw.Row(children: [
                      pw.Container(
                        width: 150,
                        height: 150,
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(75),
                          color: PdfColors.amber,
                          /* image: DecorationImage(
                                image: FileImage(
                                  File(
                                    resumeController.selectedImagepath.value,
                                  ),
                                ),
                                fit: BoxFit.fill) */
                        ),
                      ),
                      pw.SizedBox(
                        width: 30,
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisSize: pw.MainAxisSize.max,
                          children: [
                            resumeText('Usama Ali', 28, '#12727f', true),
                            pw.SizedBox(
                              height: 10,
                            ),
                            headerRow(phoneIconBytes, '0310-4241301'),
                            pw.SizedBox(
                              height: 5,
                            ),
                            headerRow(emailIconBytes, 'usamaali@gmail.com'),
                            pw.SizedBox(
                              height: 5,
                            ),
                            headerRow(addressIconBytes, 'Lahore'),
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
              decoration: const pw.BoxDecoration(
                color: PdfColors
                    .grey300, /*  boxShadow: [
                pw.BoxShadow(
                  color: PdfColors.black,
                  offset: PdfPoint(0, 0.5),
                )
              ] */
              )),
          pw.SizedBox(height: 15),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: resumeText('About Me', 25, '#12727f', true)),
          ),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Padding(
                padding: const pw.EdgeInsets.all(10),
                child: resumeText(aboutMeText.value, 18, '#000000', false)),
          ),
          pw.Container(
            width: double.infinity,
            height: 1,
            margin: const pw.EdgeInsets.symmetric(vertical: 10),
            color: PdfColor.fromHex('#d3d8db'),
          ),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: resumeText('Education', 25, '#12727f', true)),
          ),
          generateEducationListVIew(),
          pw.Container(
            width: double.infinity,
            height: 1,
            margin: const pw.EdgeInsets.symmetric(vertical: 10),
            color: PdfColor.fromHex('#d3d8db'),
          ),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: resumeText('Experience', 25, '#12727f', true)),
          ),
          generateEducationListVIew(),
        ]);
      },
    ));
    return pdfDocument.save();
  }

// method for creating language and skill widget

// method for creating header rows
  pw.Row headerRow(Uint8List emailIconBytes, String value) {
    return pw.Row(
      children: [
        pw.Image(
          pw.MemoryImage(emailIconBytes),
          width: 24,
          height: 24,
        ),
        pw.SizedBox(
          width: 5,
        ),
        pw.Expanded(
          child: resumeText(value, 18, '#12727f', false),
        ),
      ],
    );
  }



  pw.Text resumeText(
      String text, double textSize, String textColor, bool isBold) {
    return pw.Text(text,
        style: pw.TextStyle(
            color: PdfColor.fromHex(textColor),
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            fontSize: textSize),
        textAlign: pw.TextAlign.left);
  }

// method to add education list in resume
  pw.ListView generateEducationListVIew() {
    return pw.ListView.builder(
        itemCount: userEducationsList.length,
        itemBuilder: (context, index) {
          return pw.Container(
            margin: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.RichText(
                    text: pw.TextSpan(
                        text: 'Qualification: ',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 18,
                            color: PdfColor.fromHex('#000000')),
                        children: [
                      pw.TextSpan(
                        text: userEducationsList[index].qualification,
                        style: pw.TextStyle(
                            fontSize: 16,
                            color: PdfColor.fromHex('#000000'),
                            fontWeight: pw.FontWeight.normal),
                      )
                    ])),
                pw.RichText(
                    text: pw.TextSpan(
                        text: 'Institute Name: ',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 18,
                            color: PdfColor.fromHex('#000000')),
                        children: [
                      pw.TextSpan(
                          text: userEducationsList[index].instituteName,
                          style: pw.TextStyle(
                              fontSize: 16,
                              color: PdfColor.fromHex('#000000'),
                              fontWeight: pw.FontWeight.normal)),
                    ])),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.RichText(
                        text: pw.TextSpan(
                            text: 'Start Date: ',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 18,
                                color: PdfColor.fromHex('#000000')),
                            children: [
                          pw.TextSpan(
                              text: userEducationsList[index].startDate,
                              style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColor.fromHex('#000000'),
                                  fontWeight: pw.FontWeight.normal)),
                        ])),
                    pw.RichText(
                        text: pw.TextSpan(
                            text: 'End Date: ',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 18,
                                color: PdfColor.fromHex('#000000')),
                            children: [
                          pw.TextSpan(
                              text: userEducationsList[index].endDate,
                              style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColor.fromHex('#000000'),
                                  fontWeight: pw.FontWeight.normal)),
                        ])),
                  ],
                )
              ],
            ),
          );
        });
  }

// method to add experience list in resume
  pw.ListView generateUserExperienceListView() {
    return pw.ListView.builder(
        itemCount: userExperienceList.length,
        itemBuilder: (context, index) {
          return pw.Container(
            margin: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.RichText(
                    text: pw.TextSpan(
                        text: 'Designation: ',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 18,
                            color: PdfColor.fromHex('#000000')),
                        children: [
                      pw.TextSpan(
                        text: userExperienceList[index].userDesignation,
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 16,
                            color: PdfColor.fromHex('#000000')),
                      )
                    ])),
                pw.RichText(
                    text: pw.TextSpan(
                        text: 'Company Name: ',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 18,
                            color: PdfColor.fromHex('#000000')),
                        children: [
                      pw.TextSpan(
                          text: userExperienceList[index].companyName,
                          style: pw.TextStyle(
                              fontSize: 16,
                              color: PdfColor.fromHex('#000000'),
                              fontWeight: pw.FontWeight.normal)),
                    ])),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.RichText(
                        text: pw.TextSpan(
                            text: 'Start Date: ',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 18,
                                color: PdfColor.fromHex('#000000')),
                            children: [
                          pw.TextSpan(
                              text: userExperienceList[index].startDate,
                              style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColor.fromHex('#000000'),
                                  fontWeight: pw.FontWeight.normal)),
                        ])),
                    pw.RichText(
                        text: pw.TextSpan(
                            text: 'End Date: ',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 18,
                                color: PdfColor.fromHex('#000000')),
                            children: [
                          pw.TextSpan(
                              text: userExperienceList[index].endDate,
                              style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColor.fromHex('#000000'),
                                  fontWeight: pw.FontWeight.normal)),
                        ])),
                  ],
                )
              ],
            ),
          );
        });
  } */
}
