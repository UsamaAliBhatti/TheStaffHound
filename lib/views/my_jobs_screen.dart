import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/my_jobs_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/main.dart';

import '../routes/app_pages.dart';

class MyJobsActivity extends StatelessWidget {
  final controller = Get.put(MyJobsController());
  MyJobsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            backgroundColor: Constants.backgroundColor,
            title: AppText(
              text: 'All Jobs',
              textColor: Constants.primaryColor,
              textSize: 20,
              isBold: true,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Constants.primaryColor,
              ),
            ),
            elevation: 0,
            bottom: const TabBar(
                indicatorColor: Constants.secondaryColor,
                labelColor: Constants.primaryColor,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                labelStyle: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: Constants.primaryColor, width: 3),
                    insets: EdgeInsets.only(left: 50, right: 50)),
                tabs: [
                  Tab(
                    text: 'Applied',
                  ),
                  Tab(
                    text: 'Saved',
                  ),
                  Tab(
                    text: 'On-Going',
                  ),
                ]),
          ),
          body: TabBarView(
            children: [getAppliedJobs(), getSavedJobs(), getShiftsItems()],
          )
          /*   */
          ),
    );
  }

  getAppliedJobs() {
    return Obx(() {
      return controller.appliedJobsList.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: controller.filtersList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.getJobsByFilters(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: controller
                                          .filtersList[index].isSelected.value
                                      ? Constants.secondaryColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(10),
                              child: AppText(
                                text: controller.filtersList[index].filter
                                    .capitalizeFirstofEach,
                                textColor: Colors.white,
                                isBold: true,
                                textSize: 14,
                              ),
                            ),
                          );
                        }),
                  ),
                  /*  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: AppText(
                    text: 'Pending',
                    textColor: Colors.white,
                    isBold: true,
                    textSize: 14,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: AppText(
                    text: 'Approved',
                    textColor: Colors.white,
                    isBold: true,
                    textSize: 14,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: AppText(
                    text: 'Rejected',
                    textColor: Colors.white,
                    isBold: true,
                    textSize: 14,
                  ),
                ),
              ],
            ), */
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.tempJobsList.length,
                    // physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      return jobItemView(
                          controller.tempJobsList[index].appliedStatus,
                          controller.tempJobsList[index].id,
                          controller.tempJobsList[index].title,
                          controller.tempJobsList[index].rateHour,
                          controller.tempJobsList[index].createdAt);
                    },
                  )
                ],
              ),
            )
          : Center(
              child: AppText(
                text: 'Nothing To Show',
                textSize: 25,
                isBold: true,
              ),
            );
    });
  }

  getShiftsItems() {
    return Obx(() {
      return controller.assignedJobs.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: controller.assignedJobs.length,
              // physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                return jobItemView(
                    'On-Going',
                    controller.assignedJobs[index].id,
                    controller.assignedJobs[index].title,
                    controller.assignedJobs[index].rateHour,
                    controller.assignedJobs[index].createdAt);
              },
            )
          : Center(
              child: AppText(
              text: 'Nothing To Show',
              textSize: 25,
              isBold: true,
            ));
    });
  }

  getSavedJobs() {
    return Obx(() {
      return controller.savedJobs.isNotEmpty
          ? ListView.builder(
              itemCount: controller.savedJobs.length,
              itemBuilder: (context, index) {
                return savedJobItemView(
                  size: MediaQuery.of(context).size,
                  offerID: controller.savedJobs[index].id,
                  jobTitle: controller.savedJobs[index].title,
                  jobPostTime: controller.savedJobs[index].createdAt,
                  address: controller.savedJobs[index].branch,
                  salaryRange: controller.savedJobs[index].rateHour,
                  isSaved: true,
                );
              },
            )
          : Center(
              child: AppText(
                text: 'Nothing To Show',
                textSize: 25,
                isBold: true,
              ),
            );
    });
  }

  savedJobItemView(
      {required bool? isSaved,
      required int? offerID,
      required String? jobTitle,
      required String? address,
      required String? salaryRange,
      String? jobDuration,
      String? jobType,
      required DateTime? jobPostTime,
      required Size size}) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
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
                          Get.toNamed(Routes.JOB_DETAILS, arguments: [
                            {'offerID': offerID, 'type': 'job'}
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
              IconButton(
                splashRadius: 10,
                splashColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  controller.saveProject(offerID!, 1);
                },
                icon: Icon(
                  isSaved! ? Icons.favorite : Icons.favorite_outline,
                  color: Constants.primaryColor,
                ),
              )
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

  jobItemView(
    String type,
    int offerId,
    String title,
    String rate,
    DateTime date,
  ) {
    return ClipPath(
      clipper: const ShapeBorderClipper(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 5,
              color: type == 'pending'
                  ? Colors.grey
                  : type == 'approved' || type == 'On-Going'
                      ? Colors.green
                      : Colors.red,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // AppText(
                    //   text: 'Jun 1 - 7',
                    //   textColor: Colors.grey.shade500,
                    //   textSize: 16,
                    //   isStart: true,
                    // ),
                    AppText(
                      text: type.capitalizeFirstofEach,
                      textColor: type == 'pending'
                          ? Colors.grey
                          : type == 'approved' || type == 'On-Going'
                              ? Colors.green
                              : Colors.red,
                      textSize: 12,
                      isBold: true,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppText(
                        text: title,
                        textColor: Colors.black,
                        textSize: 20,
                        isStart: true,
                        isBold: true,
                      ),
                    ),
                    AppText(
                      text: '\$$rate/h',
                      textColor: Colors.black,
                      textSize: 18,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(height: 1, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildBottomRowItem('24 Dec - 4 Jan',
                      icon: Icons.calendar_month),
                  buildBottomRowItem('Temp', icon: Icons.shopping_bag_rounded),
                  buildBottomRowItem(Constants.timeAgo(date),
                      textColor: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomRowItem(String data, {IconData? icon, Color? textColor}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon != null
            ? Icon(
                icon,
                color: Colors.black,
              )
            : const SizedBox(),
        const SizedBox(
          width: 5,
        ),
        AppText(
          text: data,
          textColor: textColor ?? Colors.black,
          textSize: 14,
        )
      ],
    );
  }
  /* DefaultTabController(
      length: 4,
      
      child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            backgroundColor: Constants.backgroundColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: Constants.primaryColor,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: AppText(
              text: 'My Jobs',
              textSize: 25,
              isBold: true,
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Applied',
                ),
                Tab(
                  text: 'Approved',
                ),
                Tab(
                  text: 'Rejected',
                ),
                Tab(
                  text: 'Completed',
                ),
              ],
              labelColor: Constants.secondaryColor,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              unselectedLabelColor: Constants.primaryColor,
            ),
          ),
          body: Obx(() {
            return Visibility(
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              visible: controller.isLoaded.value,
              child: TabBarView(children: [
                generateAppliedJobsListView(size),
                generateApprovedJobsListView(size),
                generateRejectedJobsListView(size),
                generateCompletedJobsListView(size),
              ]),
            );
          })),
    );
  }

  Widget generateAppliedJobsListView(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.appliedJobsList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (() {
              Get.to(
                () => JobDetailsActivity(),
                arguments: [
                  {
                    'jobId': controller.appliedJobsList[index].id,
                    'status': 'applied'
                  }
                ],
              );
            }),
            child: createCard(size, index, controller.appliedJobsList));
      },
    );
  }

  Widget generateRejectedJobsListView(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.rejectedJobsList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (() {
              Get.to(
                () => JobDetailsActivity(),
                arguments: [
                  {
                    'jobId': controller.rejectedJobsList[index].id,
                    'status': 'rejected'
                  }
                ],
              );
            }),
            child: createCard(size, index, controller.rejectedJobsList));
      },
    );
  }

  Widget generateApprovedJobsListView(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.approvedJobsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (() {
            Get.to(
              () => JobDetailsActivity(),
              arguments: [
                {
                  'jobId': controller.approvedJobsList[index].id,
                  'status': 'approved'
                }
              ],
            );
          }),
          child: createCard(size, index, controller.approvedJobsList),
        );
      },
    );
  }

  /*  Widget generateWaitingJobsListView(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.waitingJobsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (() {}),
          child: createCard(size, index, controller.waitingJobsList),
        );
      },
    );
  } */

  Widget generateCompletedJobsListView(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.completedJobsList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (() {
              Get.to(
                () => JobDetailsActivity(),
                arguments: [
                  {
                    'jobId': controller.completedJobsList[index].id,
                    'status': 'completed'
                  }
                ],
              );
            }),
            child: createCard(size, index, controller.completedJobsList));
      },
    );
  }

  Card createCard(Size size, int index, List<Job> jobsList) {
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        color: Colors.white,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Constants.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AppText(
                    text: 'J',
                    textSize: 20,
                    isBold: true,
                    textColor: Colors.white,
                  )),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppText(
                    text: jobsList[index].jobTitle!,
                    isBold: true,
                    isStart: true,
                    textColor: Colors.black,
                    textSize: 20,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AppText(
                    text: jobsList[index].location!,
                    textColor: Constants.textHintColor,
                    isStart: true,
                    textSize: 13,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    text: jobsList[index].salary ?? 'Empty',
                    textSize: 18,
                    isBold: true,
                    isStart: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
 */
}
