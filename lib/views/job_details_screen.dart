import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/tab_bar_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_button.dart';

import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/models/general_jobs_model.dart';
import 'package:the_staff_hound/views/create_resume_screen.dart';

// ignore: must_be_immutable
class JobDetailsActivity extends StatelessWidget {
  var tabBarController = Get.put(TabBarController());
  JobDetailsActivity({Key? key}) : super(key: key);

  GeneralJobModel model = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<String> skillsList = model.getRequiredSkillsList;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            backgroundColor: Constants.backgroundColor,
            elevation: 1,
            titleSpacing: 0,
            shape: const Border(
                bottom: BorderSide(color: Colors.black26, width: 0.2)),
            shadowColor: Colors.black38,
            toolbarHeight: 70,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Constants.primaryColor,
                )),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(model.getCompanyLogo),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(
                  width: 10,
                ),
                AppText(
                  text: model.companyName,
                  textSize: 20,
                  isBold: true,
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Platform.isAndroid ? Icons.more_vert : Icons.more_horiz,
                    color: Constants.primaryColor,
                    size: 30,
                  ))
            ],
          ),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 20, left: 10, right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Constants.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(3)),
                              child: AppText(
                                text: model.getJobType,
                                textSize: 15,
                                isBold: true,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Constants.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(3)),
                              child: AppText(
                                text: model.getJobCategory,
                                textSize: 15,
                                isBold: true,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppText(
                          text: model.jobTitle,
                          isBold: true,
                          isStart: true,
                          textColor: Colors.black,
                          textSize: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: model.jobLocation,
                          isStart: true,
                          textColor: Colors.black,
                          textSize: 16,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width,
                          // margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Constants.secondaryColor, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AppText(
                                  text: model.getJobSalaryRange,
                                  textSize: 15,
                                  isBold: true,
                                  isStart: true,
                                  textColor: Colors.black),
                              AppText(
                                  text:
                                      'salary range (${model.getSalaryRangeType})',
                                  textSize: 15,
                                  isStart: true,
                                  textColor: Colors.grey)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(15),
                    color: Constants.buttonBackgroundColor,
                    child: AppText(
                      text: 'Job Detail',
                      isBold: true,
                      textSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            AppText(
                              text: 'Description:',
                              textSize: 20,
                              isBold: true,
                              isStart: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AppText(
                              text: model.getJobDescription,
                              textSize: 17,
                              isStart: true,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: createDetailsRow('Vacancies:', '5')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: createDetailsRow(
                                        'Salary Mode:', 'hourly')),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: createDetailsRow('Branch ID:', '7')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: createDetailsRow(
                                        'Frequency:', 'two Weeks')),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: createDetailsRow(
                                        'start time:', '10:00 AM')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: createDetailsRow(
                                        'End Time:', '06:00 PM')),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: createDetailsRow(
                                        'start Date:', 'Dec 02 2021')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: createDetailsRow(
                                        'End Date:', 'Jan 02 2022')),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: createDetailsRow(
                                        'Break Time:', '1 hour')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: createDetailsRow(
                                        'Break Salary:', 'Unpaid')),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AppText(
                              text: 'Skills:',
                              textSize: 20,
                              isBold: true,
                              isStart: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AppText(
                              text:
                                  'This is Skills Description and following are the required skills.',
                              textSize: 17,
                              isStart: true,
                            ),
                            const SizedBox(height: 15),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 50,
                                        childAspectRatio: 4),
                                itemCount: skillsList.length,
                                itemBuilder: (context, index) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Chip(
                                        padding: const EdgeInsets.all(5),
                                        backgroundColor: Constants.primaryColor,
                                        avatar: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              Constants.secondaryColor,
                                          child: AppText(
                                            text: 'PR',
                                            isBold: true,
                                            textColor: Colors.white,
                                            textSize: 15,
                                          ),
                                        ),
                                        label: Text(
                                          skillsList[index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  );
                                }),
                            const SizedBox(
                              height: 50,
                            ),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      width: size.width,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                        color: Constants.backgroundColor,
                                      ),
                                      child: SingleChildScrollView(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            AppText(
                                              text:
                                                  'Please upload resume if you already have otherwise create your resume by clicking the button',
                                              textSize: 15,
                                              isBold: true,
                                              isStart: true,
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var result = await FilePicker
                                                          .platform
                                                          .pickFiles(
                                                              type: FileType
                                                                  .custom,
                                                              allowedExtensions: [
                                                            'pdf',
                                                            'doc'
                                                          ]);

                                                      if (result != null) {
                                                        var file =
                                                            result.files.first;
                                                      } else {
                                                        // User canceled the picker
                                                      }
                                                    },
                                                    child: Container(
                                                        height: 50,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration: BoxDecoration(
                                                            color: Constants
                                                                .secondaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons.upload,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            AppText(
                                                              text:
                                                                  'Upload Resume',
                                                              textColor:
                                                                  Colors.white,
                                                              textSize: 16,
                                                              isBold: true,
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          CreateResumeActivity());
                                                    },
                                                    child: Container(
                                                        height: 50,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration: BoxDecoration(
                                                            color: Constants
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            AppText(
                                                              text:
                                                                  'Create Resume',
                                                              textColor:
                                                                  Colors.white,
                                                              textSize: 16,
                                                              isBold: true,
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: AppButton(
                                                text: 'SUBMIT',
                                                textSize: 20,
                                                isBold: true,
                                                buttonHeight: 60,
                                                buttonWidth: size.width / 2,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    enterBottomSheetDuration:
                                        const Duration(milliseconds: 500),
                                    exitBottomSheetDuration:
                                        const Duration(milliseconds: 500));
                              },
                              child: AppButton(
                                text: 'Apply Now',
                                isBold: true,
                                buttonWidth: size.width,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          )),
    );
  }

  Row createDetailsRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppText(
          text: title,
          textSize: 16,
          isBold: true,
          isStart: true,
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: AppText(
            text: value,
            textSize: 16,
            isStart: true,
          ),
        ),
      ],
    );
  }
}
