import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';

import '../controllers/resume_controller.dart';
import '../custom_widgets/app_text.dart';

// ignore: must_be_immutable
class ResumeViewActivity extends StatelessWidget {
  var resumeController = Get.put(ResumeController());
  ResumeViewActivity({Key? key}) : super(key: key);

  var filePath = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.task_alt,
                  color: Constants.primaryColor,
                  size: 30,
                ))
          ],
        ),
        body: PDFView(
          filePath: filePath[0],
          autoSpacing: false,
          fitPolicy: FitPolicy.BOTH,
          fitEachPage: false,
        ),
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
  ListView generateEducationListView() {
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
