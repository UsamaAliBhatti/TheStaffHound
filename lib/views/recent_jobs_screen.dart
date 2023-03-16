import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/custom_widgets/job_item_view.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';
import 'package:the_staff_hound/views/dashboard_screen.dart';

import '../controllers/recent_job_controller.dart';
import '../routes/app_pages.dart';

class RecentJobs extends StatelessWidget {
  final recentJobController = Get.put(RecentJobController());
  RecentJobs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: Constants.backgroundColor,
          elevation: 0,
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
          bottom: const TabBar(
              indicatorColor: Constants.secondaryColor,
              labelColor: Constants.primaryColor,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              labelStyle: TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(color: Constants.primaryColor, width: 3),
                  insets: EdgeInsets.only(left: 70, right: 70)),
              tabs: [
                Tab(
                  text: 'New Offers',
                ),
                Tab(
                  text: 'Search',
                )
              ]),
          /*   actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Platform.isAndroid ? Icons.more_vert : Icons.more_horiz,
                  color: Constants.primaryColor,
                  size: 30,
                ))
          ], */
        ),
        backgroundColor: Constants.backgroundColor,
        body: TabBarView(children: [assignmentsTab(size), searchTab(size)]),
      ),
    );
  }

  searchTab(Size size) {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: () async {
          await recentJobController
              .fetchMultipleOffers(SharedPrefsManager.getUserToken);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10.0),
                width: size.width,
                color: Colors.white,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            recentJobController.updateList(value);
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search)),
                              hintText: 'Search Jobs',
                              border: InputBorder.none),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          recentJobController.openFiltersDialog(size);
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              Constants.icFilter,
                              width: 24,
                              height: 24,
                              color: Constants.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            AppText(
                              text: 'Filters',
                              textColor: Constants.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
              ListView.builder(
                itemCount: recentJobController.tempList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return JobItemView(
                    offerID: recentJobController.tempList[index].id,
                    jobTitle: recentJobController.tempList[index].title,
                    jobPostTime: recentJobController.tempList[index].createdAt,
                    address: recentJobController.tempList[index].branch,
                    salaryRange: recentJobController.tempList[index].rateHour,
                    isSaved:
                        recentJobController.tempList[index].savedJob == null
                            ? false
                            : recentJobController
                                        .tempList[index].savedJob!.status ==
                                    '1'
                                ? true
                                : false,
                  );
                },
                /*    children: [
                        JobItemView(),
                        JobItemView(),
                        JobItemView(),
                        JobItemView(),
                        JobItemView(),
                      ], */
              )
            ],
          ),
        ),
      );
    });
  }

  jobItemView(
      {Size? size,
      String? jobTitle,
      bool? isSaved = false,
      int? offerID,
      String? address,
      String? salaryRange,
      DateTime? jobPostTime}) {
    return Container(
      width: size!.width,
      decoration: const BoxDecoration(color: Colors.white, border: Border()),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade300,
                    child: Image.asset(
                      Constants.splashLogo,
                      width: 23,
                      height: 23,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.NOTIFICATION_DETAILS, arguments: [
                            {'offerID': offerID, 'type': 'offer'}
                          ]);
                        },
                        child: SizedBox(
                          width: size.width / 1.7,
                          child: AppText(
                            text: jobTitle!,
                            textColor: Colors.black,
                            textSize: 18,
                            isBold: true,
                            isStart: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      AppText(
                        text: address!,
                        textColor: Colors.grey,
                        textSize: 16,
                        isStart: true,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      AppText(
                        text: '\$$salaryRange / h',
                        textColor: Constants.secondaryColor,
                        textSize: 16,
                        isStart: true,
                      )
                    ],
                  ),
                ],
              ),
              /*  IconButton(
                splashRadius: 10,
                splashColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  dashboardController.saveProject(offerID!, 1);
                },
                icon: Icon(
                  isSaved! ? Icons.favorite : Icons.favorite_outline,
                  color: Constants.primaryColor,
                ),
              ) */
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildBottomRowItem('24 Dec - 4 Jan', icon: Icons.calendar_month),
              buildBottomRowItem('Temp', icon: Icons.shopping_bag_rounded),
              buildBottomRowItem(
                  Constants.timeAgo(
                      DateTime.parse(jobPostTime!.toIso8601String())),
                  textColor: Colors.grey),
            ],
          )
        ],
      ),
    );
  }

  assignmentsTab(Size size) {
    return Obx(() {
      return ListView.builder(
        itemCount: recentJobController.offersList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return jobItemView(
            size: size,
            offerID: recentJobController.offersList[index].id,
            jobTitle: recentJobController.offersList[index].title,
            jobPostTime: recentJobController.offersList[index].createdAt,
            address: recentJobController.offersList[index].branch,
            salaryRange: recentJobController.offersList[index].rateHour,
          );
        },
        /*    children: [
                            JobItemView(),
                            JobItemView(),
                            JobItemView(),
                            JobItemView(),
                            JobItemView(),
                          ], */
      );
    });

    /* ListView(
      padding: const EdgeInsets.only(top: 10),
      children: [
        JobItemView(
          isNew: true,
          showBorder: true,
        ),
        JobItemView(
          isNew: true,
          showBorder: true,
        ),
        JobItemView(
          isNew: false,
          showBorder: true,
        ),
      ],
    ) */
    // Container();
    /* SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'New Assignments',
            textColor: Colors.black,
            textSize: 18,
            isBold: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              JobItemView(),
              JobItemView(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AppText(
            text: 'Old Assignments',
            textColor: Colors.black,
            textSize: 18,
            isBold: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              JobItemView(),
              JobItemView(),
            ],
          ),
        ],
      ),
    ); */
  }

  notificationItemView(String text, String time, bool isRead) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          color: isRead
              ? Constants.primaryColor.withOpacity(0.2)
              : Colors.grey.shade200,
          border: Border(
              left: BorderSide(
                  width: 5,
                  color: isRead ? Constants.primaryColor : Colors.grey))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade300,
          child: Image.asset(
            Constants.splashLogo,
            width: 23,
            height: 23,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: text,
                textColor: Colors.black,
                textSize: 16,
                isStart: true,
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {},
                child: AppText(
                  text: 'click to view',
                  isBold: true,
                  isStart: true,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AppText(
                  text: time,
                  textColor: Colors.grey,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  announcementItemView(bool isNew) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              left: BorderSide(
                  color: isNew ? Constants.primaryColor : Colors.grey,
                  width: 5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade300,
                child: Image.asset(
                  Constants.splashLogo,
                  width: 23,
                  height: 23,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'West Ridge Branch',
                    textColor: Colors.black,
                    textSize: 18,
                    isBold: true,
                    isStart: true,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: 240,
                    child: AppText(
                      text:
                          'Please pay a visit to branch for biometric verification',
                      textColor: Colors.grey,
                      textSize: 16,
                      isStart: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          isNew
              ? AppText(
                  text: 'Today',
                  textColor: Colors.black,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
