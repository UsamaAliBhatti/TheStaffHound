import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/view_resume_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/main.dart';
import 'package:the_staff_hound/views/create_resume_screen.dart';

import '../shared_prefs/shared_prefs.dart';

// import '../controllers/resume_controller.dart';

// ignore: must_be_immutable
class ResumeViewActivity extends StatelessWidget {
  var resumeController = Get.put(ResumeViewController());
  ResumeViewActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            title: AppText(
              text: 'My Resume',
              textSize: 25,
              isBold: true,
              textColor: Colors.white,
            ),
            centerTitle: true,
            backgroundColor: Constants.secondaryColor,
            elevation: 2,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_sharp,
                    color: Colors.white, size: 25)),
          ),
          body: Obx(() {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: Colors.amber,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        Constants.placeholderUserImage),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      AppText(
                        text: SharedPrefsManager.getUserName
                            .toString()
                            .capitalizeFirstofEach,
                        textColor: Constants.primaryColor,
                        isBold: true,
                        textSize: 25,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          width: size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              /*     boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(0, -5),
                                blurRadius: 20,
                                blurStyle: BlurStyle.outer),
                          ], */
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /* Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              const SizedBox(
                                height: 10,
                              ),
                              /* Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.phone_outlined,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Obx(
                                    () => AppText(
                                      text:
                                          resumeController.phoneNumber.value,
                                      textSize: 13,
                                      textColor: Colors.grey.shade800,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.email_outlined,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: AppText(
                                      text: SharedPrefsManager.getUserEmail,
                                      textSize: 13,
                                      textColor: Colors.grey.shade800,
                                      isBold: true,
                                      isStart: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              */
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ), */

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.phone_outlined,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Obx(
                                            () => AppText(
                                              text: resumeController
                                                  .userPhone.value,
                                              textSize: 13,
                                              textColor: Colors.grey.shade800,
                                              isBold: true,
                                              isStart: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.email_outlined,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: AppText(
                                              text: SharedPrefsManager
                                                  .getUserEmail,
                                              textSize: 13,
                                              textColor: Colors.grey.shade800,
                                              isBold: true,
                                              isStart: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.home_outlined,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: AppText(
                                        text:
                                            resumeController.userAddress.value,
                                        textSize: 13,
                                        textColor: Colors.grey.shade800,
                                        isBold: true,
                                        isStart: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: 'Summary',
                                  textColor: Constants.primaryColor,
                                  textSize: 23,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ),
                              resumeController.aboutMe.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: AppText(
                                        text: resumeController.aboutMe.value,
                                        textColor: Colors.black,
                                        textSize: 15,
                                        isStart: true,
                                      ),
                                    )
                                  : const SizedBox(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: 'Skills',
                                  textColor: Constants.primaryColor,
                                  textSize: 23,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ),
                              resumeController.skillsList.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: generateSkillsListView(),
                                    )
                                  : const SizedBox(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: 'Experience',
                                  textColor: Constants.primaryColor,
                                  textSize: 23,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ),
                              generateUserExperienceListView(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: 'Education',
                                  textColor: Constants.primaryColor,
                                  textSize: 23,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ),
                              generateEducationListVIew(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: 'Languages',
                                  textColor: Constants.primaryColor,
                                  textSize: 23,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: generateLanguagesListView(),
                              )
                            ],
                          )),
                    ],
                  )),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: size.width,
                    height: 60,
                    child: TextButton(
                        onPressed: () async {
                          /* final data = await resumeController.createResumePdf();
                                  resumeController.saveAndViewPdf(data);
                                  print(Icons.home.codePoint); */
                          // resumeController.createResume();
                          var text = await Get.to(() => CreateResumeActivity());
                          print(text);
                          if (text == 'refresh') {
                            resumeController
                                .getResume(resumeController.userToken.value);
                          }
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            backgroundColor: Constants.secondaryColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              AppText(
                                text: 'Edit',
                                textSize: 20,
                                isBold: true,
                                textColor: Colors.white,
                              )
                            ])),
                  )
                ],
              ),

              /* Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              boxShadow: const [
                                BoxShadow(
                                    color: Constants.textHintColor,
                                    offset: Offset(0, 1),
                                    blurRadius: 1)
                              ]),
                          padding: const EdgeInsets.all(10),
                          child: Row(children: <Widget>[
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
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Obx(
                                    () => AppText(
                                      text: resumeController.userName.value,
                                      textColor: Constants.primaryColor,
                                      isBold: true,
                                      isStart: true,
                                      textSize: 23,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.phone,
                                        color: Constants.primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Obx(() {
                                        return AppText(
                                          text: resumeController
                                              .userPhone.value,
                                          textSize: 13,
                                          textColor: Colors.black,
                                          isBold: true,
                                          isStart: true,
                                        );
                                      })
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
                                      Obx(() {
                                        return Expanded(
                                          child: AppText(
                                            text: resumeController
                                                .userEmail.value,
                                            textSize: 13,
                                            textColor: Colors.black,
                                            isBold: true,
                                            isStart: true,
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.home,
                                        color: Constants.primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Obx(() {
                                        return Expanded(
                                          child: AppText(
                                            text: resumeController
                                                .userAddress.value,
                                            textSize: 13,
                                            textColor: Colors.black,
                                            isBold: true,
                                            isStart: true,
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 5),
                          child: AppText(
                            text: 'Summary',
                            textColor: Constants.primaryColor,
                            textSize: 20,
                            isBold: true,
                            isStart: true,
                          ),
                        ),

                        Obx(() {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: AppText(
                              text: resumeController.aboutMe.value,
                              textColor: Colors.black,
                              textSize: 16,
                              isStart: true,
                            ),
                          );
                        }),
                        Container(
                          width: size.width,
                          height: 1,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          color: Constants.textHintColor.withOpacity(0.5),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: AppText(
                            text: 'Education',
                            textColor: Constants.primaryColor,
                            textSize: 20,
                            isBold: true,
                            isStart: true,
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
                          child: AppText(
                            text: 'Experience',
                            textColor: Constants.primaryColor,
                            textSize: 20,
                            isBold: true,
                            isStart: true,
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: AppText(
                                        text: 'Skills',
                                        textColor: Constants.primaryColor,
                                        textSize: 20,
                                        isBold: true,
                                        isStart: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
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
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: AppText(
                                        text: 'Languages',
                                        textColor: Constants.primaryColor,
                                        textSize: 20,
                                        isBold: true,
                                        isStart: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
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
                              /* final data = await resumeController.createResumePdf();
                                  resumeController.saveAndViewPdf(data);
                                  print(Icons.home.codePoint); */
                              // resumeController.createResume();
                              var text =
                                  await Get.to(() => CreateResumeActivity());
                              print(text);
                              if (text == 'refresh') {
                                resumeController.getResume(
                                    resumeController.userToken.value);
                              }
                            },
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                backgroundColor: Constants.secondaryColor,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AppText(
                                    text: 'Edit',
                                    textSize: 20,
                                    isBold: true,
                                    textColor: Colors.white,
                                  )
                                ])),
                      ))
                ],
              ), */
            );
          })),
    );
  }

  // ListView Generation Method for Experience
  ListView generateUserExperienceListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resumeController.experienceList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Constants.primaryColor),
                  ),
                  child: Center(
                    child: AppText(
                      text: (index + 1).toString(),
                      isBold: true,
                      textColor: Constants.secondaryColor,
                      textSize: 15,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Position: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: resumeController
                                .experienceList[index].userDesignation,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black),
                          )
                        ])),
                    RichText(
                        text: TextSpan(
                            text: 'Company Name: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: resumeController
                                  .experienceList[index].companyName,
                              style: const TextStyle(
                                  fontSize: 15,
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
                                    fontSize: 14,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                  text: resumeController
                                      .experienceList[index].startDate,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                            ])),
                        RichText(
                            text: TextSpan(
                                text: 'End Date: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                  text: resumeController
                                      .experienceList[index].endDate,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                            ])),
                      ],
                    )
                  ],
                ),
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
        itemCount: resumeController.educationList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Constants.primaryColor),
                  ),
                  child: Center(
                    child: AppText(
                      text: (index + 1).toString(),
                      isBold: true,
                      textColor: Constants.secondaryColor,
                      textSize: 15,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Degree: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: resumeController
                                .educationList[index].qualification,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          )
                        ])),
                    RichText(
                        text: TextSpan(
                            text: 'Institute Name: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: resumeController
                                  .educationList[index].instituteName,
                              style: const TextStyle(
                                  fontSize: 15,
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
                                    fontSize: 14,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                  text: resumeController
                                      .educationList[index].startDate,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                            ])),
                        RichText(
                            text: TextSpan(
                                text: 'End Date: ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                  text: resumeController
                                      .educationList[index].endDate,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                            ])),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  // user skills list method
  ListView generateSkillsListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resumeController.skillsList.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.centerLeft,
            child: createChip(resumeController.skillsList[index]),
          );
        });
  }

  // user Language list method
  ListView generateLanguagesListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resumeController.languagesList.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.centerLeft,
            child: createChip(resumeController.languagesList[index]),
          );
        });
  }

// Method For Creating Chips
  Widget createChip(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Constants.secondaryColor),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    /*  Chip(
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
        )); */
  }

  emptyDataScreen(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Constants.oopsImage,
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: size.width - 100,
            child: AppText(
              text: 'Looks like you haven\'t created your resume yet...',
              textColor: Colors.black,
              textSize: 24,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: size.width - 50,
            height: 80,
            child: TextButton(
              onPressed: () async {
                var text = await Get.to(() => CreateResumeActivity());
                if (text == 'refresh') {
                  resumeController.getResume(resumeController.userToken.value);
                }
              },
              style: TextButton.styleFrom(
                  // padding: const EdgeInsets.symmetric(horizontal: 30),
                  backgroundColor: Constants.buttonBackgroundColor,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              child: AppText(
                text: 'Create Resume',
                isBold: true,
                textSize: 20,
              ),
            ),
          )
        ],
      )),
    );
  }
}
