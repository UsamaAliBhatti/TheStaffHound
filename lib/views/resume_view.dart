import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/view_resume_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/main.dart';
import 'package:the_staff_hound/routes/app_pages.dart';
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
          backgroundColor: Constants.backgroundColor,
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
            return Visibility(
              visible: resumeController.isLoaded.isTrue &&
                  resumeController.isEmpty.isFalse,
              replacement: (resumeController.isLoaded.isFalse &&
                      resumeController.isEmpty.isTrue)
                  ? emptyDataScreen(size)
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Constants.secondaryColor,
                      ),
                    ),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: AppText(
                                  text: 'Summary',
                                  textColor: Constants.primaryColor,
                                  textSize: 23,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                              const SizedBox(
                                height: 10,
                              ),
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
                              const SizedBox(
                                height: 10,
                              ),
                              resumeController.skillsList.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: generateSkillsListView(),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: generateUserExperienceListView(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: generateEducationListVIew(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                    color: Colors.white,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: size.width,
                      height: 60,
                      color: Colors.white,
                      child: TextButton(
                          onPressed: () async {
                            /* final data = await resumeController.createResumePdf();
                                    resumeController.saveAndViewPdf(data);
                                    print(Icons.home.codePoint); */
                            // resumeController.createResume();
                            var text = await Get.toNamed(Routes.CREATE_RESUME);
                            print(text);
                            if (text == 'refresh') {
                              resumeController
                                  .getResume(resumeController.userToken.value);
                            }
                          },
                          style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                    ),
                  )
                ],
              ),
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
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (index != (resumeController.experienceList.length - 1))
                        ? Container(
                            height: 80,
                            width: 0.8,
                            color: Colors.grey,
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: resumeController
                          .experienceList[index].userDesignation,
                      textColor: Colors.grey.shade600,
                      textSize: 16,
                      isBold: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppText(
                      text: resumeController.experienceList[index].companyName,
                      textColor: Colors.grey.shade600,
                      textSize: 14,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                          text:
                              '${resumeController.experienceList[index].startDate} - ',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                          children: [
                            TextSpan(
                              text: resumeController
                                      .experienceList[index].endDate ??
                                  'present',
                            )
                          ]),
                    )
                    /* AppText(
                      text:
                          '${resumeController.userExperienceList[index].startDate} - $}',
                      textColor: Colors.grey,
                      textSize: 12,
                    ), */
                  ],
                ))
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
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (index != (resumeController.educationList.length - 1))
                        ? Container(
                            height: 80,
                            width: 0.8,
                            color: Colors.grey,
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Degree: ',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text:
                                    '${resumeController.educationList[index].qualification}',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal))
                          ]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Institute Name: ',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text:
                                    '${resumeController.educationList[index].instituteName}',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal))
                          ]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                          text:
                              '${resumeController.educationList[index].startDate} - ',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                          children: [
                            TextSpan(
                              text: (resumeController
                                      .educationList[index].endDate!.isNotEmpty)
                                  ? resumeController
                                      .educationList[index].endDate
                                  : 'present',
                            )
                          ]),
                    )
                  ],
                ))
              ],
            ),
          );
        });
  }

  // user skills list method
  GridView generateSkillsListView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 40,
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 5),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Constants.secondaryColor),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 100,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
          ),
        )
      ],
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
