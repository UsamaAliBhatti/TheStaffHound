import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_staff_hound/views/resume_view.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../constants.dart';
import '../custom_widgets/app_text.dart';
import '../models/education_model.dart';
import '../models/experience_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ResumeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedImagepath = ''.obs;
  var selectedImageSize = ''.obs;

// Skills Dialog Parameters
  var skillsList = [
    'Programming',
    'Graphic designing',
    'Web Development',
    'Mobile App Development',
    'Backend Development'
  ].obs;
  var selectedSkill = 'Programming'.obs;
  var userSelectedSkillsList = [].obs;

// Language Dialog Parameters
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
  var userSelectedLanguagesList = [].obs;

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
  void onInit() {
    aboutMeTextController.text = aboutMeText.value;
    super.onInit();
  }

// About Me Dialog Methods
  void saveAboutMeDescription() {}

// method to get Image from gallery
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
                          hintText: "Qualification",
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
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: AppText(
                                  text: 'Cancel',
                                  isBold: true,
                                  textSize: 15,
                                )),
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: AppText(
                                  text: 'Save',
                                  isBold: true,
                                  textSize: 15,
                                  textColor: Colors.white,
                                )),
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
      if (educationEndDate.isEmpty || educationStartDate.isEmpty) {
        showToast('Please Enter Start Date or End Date');
        return false;
      } else {
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
      educationEndDate.value = DateFormat.MEd().format(pickedDate);
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
      educationStartDate.value = DateFormat.MEd().format(pickedDate);
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
        educationEndDate.value = 'Present';
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Constants.primaryColor)),
          child: AppText(
            text: 'Present',
            isBold: true,
            textSize: 18,
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
                          hintText: "Designation",
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
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: AppText(
                                  text: 'Cancel',
                                  isBold: true,
                                  textSize: 15,
                                )),
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: AppText(
                                  text: 'Save',
                                  isBold: true,
                                  textSize: 15,
                                  textColor: Colors.white,
                                )),
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
      if (experienceStartDate.isEmpty || experienceEndDate.isEmpty) {
        showToast('Please Enter Start Date or End Date');
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
      experienceStartDate.value = DateFormat.MEd().format(pickedDate);
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
        experienceEndDate.value = 'Present';
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Constants.primaryColor)),
          child: AppText(
            text: 'Present',
            isBold: true,
            textSize: 18,
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
                text: 'About',
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
                          hintText: "Enter about you here",
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
                  child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: AppText(
                        text: 'Cancel',
                        isBold: true,
                        textSize: 15,
                      )),
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
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: AppText(
                        text: 'Save',
                        isBold: true,
                        textSize: 15,
                        textColor: Colors.white,
                      )),
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

  // select list method
  void selectSkill(Object value) {
    selectedSkill.value = value.toString();
  }

  // select list language
  void selectLanguage(Object value) {
    selectedLanguage.value = value.toString();
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

//  create Resume PDF Method
  Future<Uint8List> createResumePdf(Size size) async {
    final pdfDocument = pw.Document();

    pdfDocument.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Container(
              padding: const pw.EdgeInsets.all(20),
              child: pw.Column(
                children: [
                  pw.Container(
                    width: size.width,
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
                            resumeText('Usama Ali', 25),
                            pw.SizedBox(
                              height: 10,
                            ),
                            pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Icon(
                                    const pw.IconData(0xe0cd),
                                    color: PdfColor.fromHex("#12727f"),
                                  ),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  resumeText('0310-4241301', 13),
                                ]),
                            pw.SizedBox(
                              height: 5,
                            ),
                            pw.Row(
                              children: [
                                pw.Icon(
                                  const pw.IconData(0xe0be),
                                  color: PdfColor.fromHex("#12727f"),
                                ),
                                pw.SizedBox(
                                  width: 5,
                                ),
                                pw.Expanded(
                                  child: resumeText(
                                      'usamaali185.ua@gmail.com', 13),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 5,
                            ),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Icon(
                                  const pw.IconData(0xe88a),
                                  color: PdfColor.fromHex("#12727f"),
                                ),
                                pw.SizedBox(
                                  width: 5,
                                ),
                                pw.Expanded(
                                  child: resumeText('Lahore', 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
              decoration: const pw.BoxDecoration(
                  color: PdfColors
                      .grey300 /* , boxShadow: [
                pw.BoxShadow(
                  color: PdfColors.black,
                  offset: PdfPoint(0, 0.5),
                )
              ] */
                  )),
        ]);
      },
    ));
    return pdfDocument.save();
  }

  //method to save and view pdf
  void saveAndViewPdf(Uint8List list) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/ Resume.pdf";
    final file = File(filePath);
    await file.writeAsBytes(list);
    print(filePath);

    if (filePath.isNotEmpty) {
      Get.to(() => ResumeViewActivity(), arguments: [
        filePath,
      ]);
    }
  }

  pw.Text resumeText(
    String text,
    double textSize,
  ) {
    return pw.Text(text,
        style: pw.TextStyle(
            color: PdfColor.fromHex("#12727f"),
            fontWeight: pw.FontWeight.bold,
            fontSize: textSize),
        textAlign: pw.TextAlign.left);
  }
}
