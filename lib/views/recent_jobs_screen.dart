// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/dasboard_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/models/general_jobs_model.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';

class RecentJobs extends StatelessWidget {
  var dashboardController = Get.put(DashBoardController());
  RecentJobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Constants.backgroundColor,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Constants.primaryColor,
            )),
        title: AppText(
          text: 'Recent Jobs',
          textSize: 20,
          isBold: true,
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
      backgroundColor: Constants.backgroundColor,
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 30),
            Expanded(
                child: SingleChildScrollView(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Constants.textHintColor,
                              offset: Offset(0.2, 0.2),
                              blurRadius: 1)
                        ]),
                    child: Center(
                      child: SizedBox(
                        width: 550,
                        child: TextField(
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: 'search job here...',
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              )),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: size.width,
                      child: GetX<DashBoardController>(builder: (controller) {
                        return ListView.separated(
                            shrinkWrap: true,
                            itemCount: controller.recentJobsList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 1,
                              );
                            },
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  GeneralJobModel model =
                                      controller.recentJobsList[index];

                                  // debugPrint(model.getCompanyName);

                                  Get.to(() => JobDetailsActivity(),
                                      arguments: model,
                                      transition: Transition.zoom);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  width: size.width,
                                  color: Colors.white,
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    controller
                                                        .recentJobsList[index]
                                                        .companyLogo,
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            AppText(
                                              text: controller
                                                  .recentJobsList[index]
                                                  .jobTitle,
                                              isBold: true,
                                              isStart: true,
                                              textColor: Colors.black,
                                              textSize: 20,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            AppText(
                                              text: controller
                                                  .recentJobsList[index]
                                                  .jobLocation,
                                              textColor:
                                                  Constants.textHintColor,
                                              isStart: true,
                                              textSize: 13,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppText(
                                              text: controller
                                                  .recentJobsList[index]
                                                  .jobSalaryRange,
                                              textSize: 18,
                                              isBold: true,
                                              isStart: true,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}
