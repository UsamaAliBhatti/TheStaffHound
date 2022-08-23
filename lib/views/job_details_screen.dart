import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/job_detail_controller.dart';

import 'package:the_staff_hound/custom_widgets/app_text.dart';

import '../custom_widgets/app_button.dart';
import 'create_resume_screen.dart';

// ignore: must_be_immutable
class JobDetailsActivity extends StatelessWidget {
  var jobDetailController = Get.put(JobDetailController());

  @override
  JobDetailsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
//
    return SafeArea(
      child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            backgroundColor: Constants.backgroundColor,
            elevation: 1,
            titleSpacing: 0,
            centerTitle: true,
            shape: const Border(
                bottom: BorderSide(color: Colors.black26, width: 0.2)),
            shadowColor: Colors.black38,
            toolbarHeight: 70,
            leading: IconButton(
                onPressed: () {
                  Get.back(result: 'refresh');
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Constants.primaryColor,
                )),
            title: AppText(
              text: 'Job Details',
              textSize: 22,
              isBold: true,
            ),
            /* Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(() {
                        return _getImage(
                            jobDetailController.jobDetail.value.jobs!.imageUrl!);
                      })),
                  const SizedBox(
                    width: 10,
                  ),
                  AppText(
                    text: jobDetailController.jobDetail.value.jobs!.companyName ??
                        'Name is empty',
                    textSize: 20,
                    isBold: true,
                  ),
                ],
              ), */
            actions: [
              /*  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Platform.isAndroid ? Icons.more_vert : Icons.more_horiz,
                      color: Constants.primaryColor,
                      size: 30,
                    )) */
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone,
                    color: Constants.primaryColor,
                  )),
              PopupMenuButton(
                  icon: Icon(
                    Platform.isAndroid ? Icons.more_vert : Icons.more_horiz,
                    color: Constants.primaryColor,
                    size: 30,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: AppText(
                          text: 'Interested',
                        )),
                        PopupMenuItem(
                            child: AppText(
                          text: 'Respond Later',
                        ))
                      ])
            ],
          ),
          body: Obx(() {
            return Visibility(
                visible: jobDetailController.isLoaded.value,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: Obx(() {
                  return jobDetailController.status.value == 'approved'
                      ? appliedJobDetailFunction(size, context)
                      : simpleJobDetailsMethod(size, context);
                }));
          })),
    );
  }

  appliedJobDetailFunction(size, context) {
    return Obx(() {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: size.width,
            margin: const EdgeInsets.all(10),
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
                        text:
                            jobDetailController.jobDetail.value.jobs!.jobType ??
                                'Empty',
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
                        text: jobDetailController
                                .jobDetail.value.jobs!.jobOrigin ??
                            'Empty',
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
                  text: jobDetailController.jobDetail.value.jobs!.jobTitle ??
                      'Empty',
                  isBold: true,
                  isStart: true,
                  textColor: Colors.black,
                  textSize: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  text: jobDetailController.jobDetail.value.jobs!.location ??
                      'Empty',
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
                          text: /*  jobDetailController.jobDetail
                                            .value.jobs!.salary ?? */
                              'Empty',
                          textSize: 15,
                          isBold: true,
                          isStart: true,
                          textColor: Colors.black),
                      AppText(
                          text: 'salary range ()',
                          textSize: 15,
                          isStart: true,
                          textColor: Colors.grey)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TabBar(
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Constants.primaryColor,
              labelColor: Constants.primaryColor,
              unselectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                  color: Constants.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              controller: jobDetailController.tabController,
              isScrollable: true,
              tabs: const [
                Tab(
                  child: Text(
                    "Job Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Client Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: TabBarView(
              controller: jobDetailController.tabController,
              children: [
                jobDetailMethod(context),
                clientDetailMethod(context),
              ],
            ),
          ),
        ]),
      );
    });
  }

  jobDetailMethod(context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
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
              text: jobDetailController.jobDetail.value.jobs!.description ??
                  'Job Description is Empty',
              textSize: 17,
              isStart: true,
            ),
            const SizedBox(height: 15),
            Row(
              children: <Widget>[
                Expanded(
                    child: createDetailsRow(
                        'Vacancies:',
                        jobDetailController
                                .jobDetail.value.jobs!.hiringNumbers ??
                            'Empty')),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: createDetailsRow(
                        'Salary Mode:',
                        jobDetailController.jobDetail.value.jobs!.salaryMode ??
                            'Empty')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: createDetailsRow(
                        'Branch ID:',
                        jobDetailController.jobDetail.value.jobs!.branchId ??
                            'Empty')),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: createDetailsRow(
                        'Frequency:',
                        jobDetailController.jobDetail.value.jobs!.frequency ??
                            'Empty')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(child: createDetailsRow('start time:', '10:00 AM')),
                const SizedBox(
                  width: 5,
                ),
                Expanded(child: createDetailsRow('End Time:', '06:00 PM')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(child: createDetailsRow('start Date:', 'Dec 02 2021')),
                const SizedBox(
                  width: 5,
                ),
                Expanded(child: createDetailsRow('End Date:', 'Jan 02 2022')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: createDetailsRow(
                        'Break Time:',
                        jobDetailController.jobDetail.value.jobs!.breakTime ??
                            'Empty')),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: createDetailsRow(
                        'Break Salary:',
                        jobDetailController.jobDetail.value.jobs!.breakSalary ??
                            'Empty')),
              ],
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
                  jobDetailController.jobDetail.value.jobs!.skillDescription ??
                      'N/A',
              textSize: 17,
              isStart: true,
            ),

            /*  const SizedBox(height: 15),
            /*   GridView.builder(
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
                                            backgroundColor:
                                                Constants.primaryColor,
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
                                    }), */ */
          ]),
    );
  }

  clientDetailMethod(context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Row(
              children: [
                AppText(
                  text: 'Client Name:',
                  textSize: 18,
                  isBold: true,
                  isStart: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                AppText(
                  text:
                      '${jobDetailController.jobDetail.value.client!.ownerFirstName}',
                  textSize: 16,
                  isStart: true,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: <Widget>[
                AppText(
                  text: 'Company Name:',
                  textSize: 18,
                  isBold: true,
                  isStart: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                AppText(
                  text:
                      jobDetailController.jobDetail.value.client!.companyName ??
                          'Company Name is Empty',
                  textSize: 16,
                  isStart: true,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                AppText(
                  text: 'Email:',
                  textSize: 18,
                  isBold: true,
                  isStart: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                AppText(
                  text: jobDetailController.jobDetail.value.client!.email ??
                      'Email is Empty',
                  textSize: 16,
                  isStart: true,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                AppText(
                  text: 'Phone:',
                  textSize: 18,
                  isBold: true,
                  isStart: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                AppText(
                  text: jobDetailController.jobDetail.value.client!.phone ??
                      'Phone is Empty',
                  textSize: 16,
                  isStart: true,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  text: 'Address:',
                  textSize: 18,
                  isBold: true,
                  isStart: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: AppText(
                    text:
                        '${jobDetailController.jobDetail.value.client!.street1} ${jobDetailController.jobDetail.value.client!.zipCode}  ${jobDetailController.jobDetail.value.client!.state} ${jobDetailController.jobDetail.value.client!.country}',
                    textSize: 16,
                    isStart: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            AppText(
              text: 'Discription:',
              textSize: 20,
              isBold: true,
              isStart: true,
            ),
            const SizedBox(
              height: 10,
            ),
            AppText(
              text: jobDetailController.jobDetail.value.client!.description ??
                  'Description is empty',
              textSize: 17,
              isStart: true,
            ),
          ]),
    );
  }

  simpleJobDetailsMethod(size, context) {
    return Obx(() {
      return Stack(
        children: [
          SizedBox(
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
                                text: jobDetailController
                                        .jobDetail.value.jobs!.jobType ??
                                    'Empty',
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
                                text: jobDetailController
                                        .jobDetail.value.jobs!.jobOrigin ??
                                    'Empty',
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
                          text: jobDetailController
                                  .jobDetail.value.jobs!.jobTitle ??
                              'Empty',
                          isBold: true,
                          isStart: true,
                          textColor: Colors.black,
                          textSize: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: jobDetailController
                                  .jobDetail.value.jobs!.location ??
                              'Empty',
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
                                  text: jobDetailController
                                          .jobDetail.value.jobs!.salary ??
                                      'Empty',
                                  textSize: 15,
                                  isBold: true,
                                  isStart: true,
                                  textColor: Colors.black),
                              AppText(
                                  text: 'salary range ()',
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
                              text: jobDetailController
                                      .jobDetail.value.jobs!.description ??
                                  'Job Description is Empty',
                              textSize: 17,
                              isStart: true,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: createDetailsRow(
                                        'Vacancies:',
                                        jobDetailController.jobDetail.value
                                                .jobs!.hiringNumbers ??
                                            'Empty')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: createDetailsRow(
                                        'Salary Mode:',
                                        jobDetailController.jobDetail.value
                                                .jobs!.salaryMode ??
                                            'Empty')),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: createDetailsRow(
                                        'Branch ID:',
                                        jobDetailController.jobDetail.value
                                                .jobs!.branchId ??
                                            'Empty')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: createDetailsRow(
                                        'Frequency:',
                                        jobDetailController.jobDetail.value
                                                .jobs!.frequency ??
                                            'Empty')),
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
                                        'Break Time:',
                                        jobDetailController.jobDetail.value
                                                .jobs!.breakTime ??
                                            'Empty')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: createDetailsRow(
                                        'Break Salary:',
                                        jobDetailController.jobDetail.value
                                                .jobs!.breakSalary ??
                                            'Empty')),
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
                              text: jobDetailController
                                      .jobDetail.value.jobs!.skillDescription ??
                                  'N/A',
                              textSize: 17,
                              isStart: true,
                            ),
                            const SizedBox(height: 15),
                            /*   GridView.builder(
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
                                                          backgroundColor:
                                                              Constants.primaryColor,
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
                                                  }), */
                          ]),
                    ),
                  ),
                  (jobDetailController.status.value == 'new')
                      ? const SizedBox(
                          height: 100,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          Obx((() {
            return (jobDetailController.status.value == 'new')
                ? Positioned(
                    bottom: 0,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                            color: Constants.backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, -2),
                                  blurRadius: 0.8,
                                  blurStyle: BlurStyle.outer)
                            ]),
                        width: size.width,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width / 2.8,
                              height: 60,
                              child: TextButton(
                                onPressed: () {
                                  jobDetailController.notInterestedInJob();
                                },
                                style: TextButton.styleFrom(
                                    // padding: const EdgeInsets.symmetric(horizontal: 30),
                                    backgroundColor:
                                        Constants.buttonBackgroundColor,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: AppText(
                                  text: 'Not Interested',
                                  isBold: true,
                                  textSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width / 3,
                              height: 60,
                              child: TextButton(
                                onPressed: jobDetailController.isApplied.value
                                    ? null
                                    : () async {
                                        await jobDetailController.checkResume()
                                            ? jobDetailController.applyForJob()
                                            : openBottomSheetDialog(
                                                size, context);
                                      },
                                style: TextButton.styleFrom(

                                    // padding: const EdgeInsets.symmetric(horizontal: 30),
                                    backgroundColor:
                                        Constants.buttonBackgroundColor,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: AppText(
                                  text: 'Apply Now',
                                  isBold: true,
                                  textSize: 18,
                                ),
                              ),
                            )
                          ],
                        )))
                : const SizedBox();
          }))
        ],
      );
    });
  }

/*   */
  openBottomSheetDialog(Size size, context) {
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
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                AppText(
                  text: 'Please create / update  your resume before applying',
                  textSize: 15,
                  isBold: true,
                  isStart: true,
                  textColor: Colors.red,
                ),
                const SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => CreateResumeActivity());
                        },
                        child: Container(
                            height: 50,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Constants.secondaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.upload,
                                  color: Colors.white,
                                ),
                                AppText(
                                  text: 'Update Resume',
                                  textColor: Colors.white,
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
                          Get.back();
                          Get.to(() => CreateResumeActivity());
                        },
                        child: Container(
                            height: 50,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                AppText(
                                  text: 'Create Resume',
                                  textColor: Colors.white,
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
                  onTap: jobDetailController.isApplied.value
                      ? null
                      : () async {
                          jobDetailController.applyForJob();
                        },
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
        enterBottomSheetDuration: const Duration(milliseconds: 500),
        exitBottomSheetDuration: const Duration(milliseconds: 500));
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

 /*  Widget _getImage(String? s) {
    if (s == null) {
      return Image.asset(
        Constants.placeholderImage,
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        s,
        fit: BoxFit.cover,
      );
    }
  } */
}
