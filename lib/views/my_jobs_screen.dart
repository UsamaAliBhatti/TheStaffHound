import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/my_jobs_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/main.dart';

import '../custom_widgets/job_item_view.dart';

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
                    text: 'Shifts',
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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: AppText(
                  text: 'All Jobs',
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
          ),
          const SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              jobItemView('pending'),
              const SizedBox(
                height: 20,
              ),
              jobItemView('approved'),
              const SizedBox(
                height: 20,
              ),
              jobItemView('rejected'),
            ],
          ),
        ],
      ),
    );
  }

  getShiftsItems() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: AppText(
                  text: 'On - Going Shifts',
                  textColor: Colors.white,
                  isBold: true,
                  textSize: 16,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: AppText(
                  text: 'Completed Shifts',
                  textColor: Colors.white,
                  isBold: true,
                  textSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          JobItemView(
            shiftType: 'Completed',
          ),
          JobItemView(
            shiftType: 'On - Going',
          ),
          JobItemView(
            shiftType: 'On - Going',
          ),
          JobItemView(
            shiftType: 'Completed',
          ),
        ],
      ),
    );
  }

  getSavedJobs() {
    return ListView(
      children: [
        const SizedBox(
          height: 10,
        ),
        JobItemView(
          isSaved: true,
        ),
        JobItemView(
          isSaved: true,
        ),
        JobItemView(
          isSaved: true,
        ),
      ],
    );
  }

  jobItemView(String type) {
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
                  : type == 'approved'
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'Jun 1 - 7',
                      textColor: Colors.grey.shade500,
                      textSize: 16,
                      isStart: true,
                    ),
                    AppText(
                      text: type.capitalizeFirstofEach,
                      textColor: type == 'pending'
                          ? Colors.grey
                          : type == 'approved'
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
                    AppText(
                      text: 'Robert Half',
                      textColor: Colors.black,
                      textSize: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: '30h 0m',
                          textColor: Colors.black,
                          textSize: 18,
                        ),
                        AppText(
                          text: 'Some text',
                          textColor: Colors.grey,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
                  buildBottomRowItem('6 days ago', textColor: Colors.grey),
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
