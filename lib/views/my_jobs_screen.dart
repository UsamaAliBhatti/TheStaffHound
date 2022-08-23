import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/my_jobs_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';

import '../api_services/response_models/my_jobs_response.dart';

class MyJobsActivity extends StatelessWidget {
  final controller = Get.put(MyJobsController());
  MyJobsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
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
      ),
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

 
}
