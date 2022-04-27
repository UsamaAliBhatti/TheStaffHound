import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/resume_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

// ignore: must_be_immutable
class CreateResumeActivity extends StatelessWidget {
  var resumeController = Get.put(ResumeController());
  CreateResumeActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: Colors.amber,
                              /* image: DecorationImage(
                                    image: FileImage(
                                      File(
                                        resumeController.selectedImagepath.value,
                                      ),
                                    ),
                                    fit: BoxFit.fill) */
                            ),
                          ),
                          Positioned(
                              bottom: 2,
                              right: 1,
                              child: InkWell(
                                onTap: () {
                                  resumeController.getImage();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      color: Colors.red),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            AppText(
                              text: 'Usama Ali',
                              textColor: Constants.primaryColor,
                              isBold: true,
                              isStart: true,
                              textSize: 23,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Icon(
                                  Icons.phone,
                                  color: Constants.primaryColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                AppText(
                                  text: '0310-4241301',
                                  textSize: 13,
                                  textColor: Colors.black,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.email,
                                  color: Constants.primaryColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: AppText(
                                    text: 'usamaali786@gmail.com',
                                    textSize: 13,
                                    textColor: Colors.black,
                                    isBold: true,
                                    isStart: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Icon(
                                  Icons.home,
                                  color: Constants.primaryColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: AppText(
                                    text: 'Lahore',
                                    textSize: 13,
                                    textColor: Colors.black,
                                    isBold: true,
                                    isStart: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                  Container(
                    width: size.width,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Constants.textHintColor.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        AppText(
                          text: 'About Me ',
                          textColor: Constants.primaryColor,
                          textSize: 20,
                          isBold: true,
                          isStart: true,
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
                            splashRadius: 5,
                            onPressed: () {
                              resumeController.openDescriptionDialog(size);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Constants.secondaryColor,
                            ))
                      ],
                    ),
                  ),

                  Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AppText(
                          text: resumeController.aboutMeText.value,
                          textColor: Colors.black,
                          textSize: 15,
                          isStart: true,
                        ),
                      )),
                  Container(
                    width: size.width,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Constants.textHintColor.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'Education',
                          textColor: Constants.primaryColor,
                          textSize: 20,
                          isBold: true,
                          isStart: true,
                        ),
                        IconButton(
                            splashRadius: 5,
                            onPressed: () {
                              resumeController.openEducationDialog(size);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Constants.secondaryColor,
                            ))
                      ],
                    ),
                  ),
                  Obx(() {
                    return generateEducationListVIew();
                  }),
                  Container(
                    width: size.width,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Constants.textHintColor.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'Experience',
                          textColor: Constants.primaryColor,
                          textSize: 20,
                          isBold: true,
                          isStart: true,
                        ),
                        IconButton(
                            splashRadius: 5,
                            onPressed: () {
                              resumeController.openExperienceDialog(size);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Constants.secondaryColor,
                            ))
                      ],
                    ),
                  ),

                  Obx(() {
                    return generateUserExperienceListView();
                  }), //Calling Experience Method
                  Container(
                    width: size.width,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Constants.textHintColor.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Skills',
                                    textColor: Constants.primaryColor,
                                    textSize: 20,
                                    isBold: true,
                                    isStart: true,
                                  ),
                                  IconButton(
                                      splashRadius: 5,
                                      onPressed: () {
                                        openSkillDialog(size);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline_rounded,
                                        color: Constants.secondaryColor,
                                      ))
                                ],
                              ),
                              Obx(() => generateSkillsListView())
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Languages',
                                    textColor: Constants.primaryColor,
                                    textSize: 20,
                                    isBold: true,
                                    isStart: true,
                                  ),
                                  IconButton(
                                      splashRadius: 5,
                                      onPressed: () {
                                        openLanguageDialog(size);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline_rounded,
                                        color: Constants.secondaryColor,
                                      ))
                                ],
                              ),
                              Obx(() => generateLanguagesListView())
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 30,
                right: 1,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  /* width: 120, */
                  height: 60,
                  child: TextButton(
                      onPressed: () async {
                        final data =
                            await resumeController.createResumePdf(size);
                        resumeController.saveAndViewPdf(data);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            AppText(
                              text: 'Save & View',
                              textSize: 20,
                              isBold: true,
                              textColor: Colors.white,
                            )
                          ]),
                      style: TextButton.styleFrom(
                          backgroundColor: Constants.secondaryColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)))),
                ))
          ],
        ),
      ),
    ));
  }

//Skill Dialog
  void openSkillDialog(Size size) {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) => AlertDialog(
        title: AppText(
          text: 'Skills',
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
          // height: size.height / 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30,
              ),
              Obx(() => DropdownButton(
                    hint: const Text(
                      'Select Skill',
                    ),
                    isDense: true,
                    isExpanded: true,
                    iconSize: 30,
                    onChanged: (newValue) {
                      resumeController.selectSkill(newValue!);
                    },
                    value: resumeController.selectedSkill.value,
                    items: resumeController.skillsList.map((selectedType) {
                      return DropdownMenuItem(
                        child: Text(
                          selectedType,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        value: selectedType,
                      );
                    }).toList(),
                  )),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
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
                      resumeController.saveUserSkills();
                      Get.back();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        // insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

//Language Dialog
  void openLanguageDialog(Size size) {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) => AlertDialog(
        title: AppText(
          text: 'Languages',
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
          // height: size.height / 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30,
              ),
              Obx(() => DropdownButton(
                    hint: const Text(
                      'Select Language',
                    ),
                    isDense: true,
                    isExpanded: true,
                    iconSize: 30,
                    onChanged: (newValue) {
                      resumeController.selectLanguage(newValue!);
                    },
                    value: resumeController.selectedLanguage.value,
                    items: resumeController.languagesList.map((selectedType) {
                      return DropdownMenuItem(
                        child: Text(
                          selectedType,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        value: selectedType,
                      );
                    }).toList(),
                  )),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
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
                      resumeController.saveUserLanguages();
                      Get.back();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        // insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

// user skills list method
  ListView generateSkillsListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resumeController.userSelectedSkillsList.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.centerLeft,
            child: createChip(resumeController.userSelectedSkillsList[index]),
          );
        });
  }

  // user Language list method
  ListView generateLanguagesListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resumeController.userSelectedLanguagesList.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.centerLeft,
            child:
                createChip(resumeController.userSelectedLanguagesList[index]),
          );
        });
  }

// Method For Creating Chips
  Chip createChip(
    String text,
  ) {
    return Chip(
        padding: const EdgeInsets.all(8),
        backgroundColor: Constants.primaryColor,
        avatar: CircleAvatar(
          radius: 20,
          backgroundColor: Constants.secondaryColor,
          child: AppText(
            text: 'LL',
            isBold: true,
            textColor: Colors.white,
            textSize: 15,
          ),
        ),
        label: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ));
  }

  // ListView Generation Method for Experience
  ListView generateUserExperienceListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resumeController.userExperienceList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Designation: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                        children: [
                      TextSpan(
                        text: resumeController
                            .userExperienceList[index].userDesignation,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black),
                      )
                    ])),
                RichText(
                    text: TextSpan(
                        text: 'Company Name: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                        children: [
                      TextSpan(
                          text: resumeController
                              .userExperienceList[index].companyName,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal)),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Start Date: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: resumeController
                                  .userExperienceList[index].startDate,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ])),
                    RichText(
                        text: TextSpan(
                            text: 'End Date: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: resumeController
                                  .userExperienceList[index].endDate,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ])),
                  ],
                )
              ],
            ),
          );
        });
  }

//Listview for Educations List
  ListView generateEducationListVIew() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resumeController.userEducationsList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Qualification: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                        children: [
                      TextSpan(
                        text: resumeController
                            .userEducationsList[index].qualification,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ])),
                RichText(
                    text: TextSpan(
                        text: 'Institute Name: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                        children: [
                      TextSpan(
                          text: resumeController
                              .userEducationsList[index].instituteName,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal)),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Start Date: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: resumeController
                                  .userEducationsList[index].startDate,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ])),
                    RichText(
                        text: TextSpan(
                            text: 'End Date: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: resumeController
                                  .userEducationsList[index].endDate,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        ])),
                  ],
                )
              ],
            ),
          );
        });
  }
}
