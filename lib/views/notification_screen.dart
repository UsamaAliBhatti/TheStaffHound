import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/notification_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

import '../routes/app_pages.dart';
import '../shared_prefs/shared_prefs.dart';

class NotificationsActivity extends StatelessWidget {
  final controller = Get.put(NotificationController());
  NotificationsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            leading: Container(
              margin: const EdgeInsets.only(left: 10),
              width: 25,
              height: 25,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Constants.primaryColor,
                  )),
            ),
            backgroundColor: Constants.backgroundColor,
            elevation: 0,
            title: AppText(
              text: 'Notifications',
              textSize: 20,
              isBold: true,
              textColor: Constants.secondaryColor,
            ),
            centerTitle: true,
            bottom: const TabBar(
                indicatorColor: Constants.secondaryColor,
                labelColor: Constants.primaryColor,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                labelStyle: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: Constants.primaryColor, width: 3),
                    insets: EdgeInsets.only(left: 70, right: 70)),
                tabs: [
                  Tab(
                    text: 'Assignments',
                  ),
                  Tab(
                    text: 'Announcements',
                  )
                ]),
          ),
          body: TabBarView(
            children: [assignmentsScreen(size), announcementsScreen()],
          )

          /* Obx(() {
          return Visibility(
            visible: controller.isLoaded.value,
            replacement: const Center(
              child: CircularProgressIndicator(
                color: Constants.secondaryColor,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.notificationsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (() {
                      print(controller.notificationsList[index].jobId!);
                      int jobId =
                          int.parse(controller.notificationsList[index].jobId!);
                      Get.to(() => JobDetailsActivity(), arguments: [
                        {'jobId': jobId, 'status': 'new'}
                      ]);
                    }),
                    child: Card(
                      elevation: 1,
                      child: Container(
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(children: <Widget>[
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage(Constants.notificationImage),
                            radius: 40,
                          ),
                          const SizedBox(width: 20),
                          Obx(() {
                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppText(
                                    text: controller
                                        .notificationsList[index].notiTitle!,
                                    textSize: 16,
                                    isBold: true,
                                    isStart: true,
                                  ),
                                  AppText(
                                    text: controller
                                        .notificationsList[index].notiBody!,
                                    textSize: 14,
                                    isBold: true,
                                    textColor: Colors.black,
                                    isStart: true,
                                  ),
                                ],
                              ),
                            );
                          })
                        ]),
                      ),
                    ),
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          );
        }), */
          ),
    );
  }

  announcementsScreen() {
    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*  AppText(
                text: 'New Announcements',
                textColor: Colors.black,
                textSize: 18,
                isBold: true,
              ),
              const SizedBox(
                height: 10,
              ), */
            ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              reverse: true,
              shrinkWrap: true,
              itemCount: controller.announcementsList.length,
              itemBuilder: (context, index) {
                if (controller.announcementsList[index].status == 'pending') {
                  return announcementItemView(
                      true,
                      controller.announcementsList[index].message,
                      controller.announcementsList[index].createdAt,
                      controller.announcementsList[index].id);
                } else {
                  return announcementItemView(
                      false,
                      controller.announcementsList[index].message,
                      controller.announcementsList[index].createdAt,
                      controller.announcementsList[index].id);
                }
              },
            ),
            /* const SizedBox(
                height: 10,
              ),
              AppText(
                text: 'Announcement History',
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
                
                ],
              ), */
          ],
        ),
      );
    });
  }

  assignmentsScreen(Size size) {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: controller.notificationsList.length,
        itemBuilder: (context, index) {
          if (controller.notificationsList[index].confirmation == '0') {
            if (controller.notificationsList[index].isSeen == '0') {
              return notificationItemView(
                  'You have received 1 new job assignment request  ${controller.notificationsList[index].title}',
                  controller.notificationsList[index].createdAt,
                  false,
                  controller.notificationsList[index].projectId,
                  controller.notificationsList[index].confirmation,
                  controller.notificationsList[index].table,
                  controller.notificationsList[index].id);
            } else {
              return notificationItemView(
                  'You have received 1 new job assignment request  ${controller.notificationsList[index].title}',
                  controller.notificationsList[index].createdAt,
                  true,
                  controller.notificationsList[index].projectId,
                  controller.notificationsList[index].confirmation,
                  controller.notificationsList[index].table,
                  controller.notificationsList[index].id);
            }
          } else {
            if (controller.notificationsList[index].isSeen == '0') {
              return notificationItemView(
                  'Congratulations! You have been approved for this  ${controller.notificationsList[index].title} job',
                  controller.notificationsList[index].createdAt,
                  false,
                  controller.notificationsList[index].projectId,
                  controller.notificationsList[index].confirmation,
                  controller.notificationsList[index].table,
                  controller.notificationsList[index].id);
            } else {
              return notificationItemView(
                  'Congratulations! You have been approved for this ${controller.notificationsList[index].title} job',
                  controller.notificationsList[index].createdAt,
                  true,
                  controller.notificationsList[index].projectId,
                  controller.notificationsList[index].confirmation,
                  controller.notificationsList[index].table,
                  controller.notificationsList[index].id);
            }
          }
        },
        /* children: [
            notificationItemView('You have received 1 new job assignment request',
                '8 minutes ago', true),
            notificationItemView('You have received 1 new job assignment request',
                '8 minutes ago', true),
            notificationItemView('You have received 1 new job assignment request',
                '8 minutes ago', false),
            notificationItemView('You have received 1 new job assignment request',
                '8 minutes ago', false),
          ], */
      );
    }); /* SingleChildScrollView(
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

  notificationItemView(String text, DateTime time, bool isRead, String id,
      String confirmation, String table, int offerID) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          color: !isRead
              ? Constants.primaryColor.withOpacity(0.2)
              : Colors.grey.shade200,
          border: Border(
              left: BorderSide(
                  width: 5,
                  color: !isRead ? Constants.primaryColor : Colors.grey))),
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
                onTap: () {
                  controller.updateAssignmentsStatus(
                      SharedPrefsManager.getUserToken, table, offerID);
                  if (confirmation == "0") {
                    Get.toNamed(Routes.NOTIFICATION_DETAILS, arguments: [
                      {'offerID': int.parse(id), 'type': 'new'}
                    ]);
                  } else {
                    Get.toNamed(Routes.SECOND_NOTIFICATION, arguments: [
                      {'offerID': int.parse(id), 'type': table, 'id': offerID}
                    ]);
                  }
                },
                child: AppText(
                  text: 'click to view',
                  isBold: true,
                  isStart: true,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AppText(
                  text: Constants.timeAgo(time),
                  textColor: Colors.grey,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  announcementItemView(bool isNew, String message, DateTime time, int id) {
    return InkWell(
      onTap: () {
        controller.updateAnnouncementsStatus(
            SharedPrefsManager.getUserToken, id);
        controller.showDetailsDialog(message, id);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
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
                      text: 'Branch',
                      textColor: Colors.black,
                      textSize: 18,
                      isBold: true,
                      isStart: true,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      width: 150,
                      child: AppText(
                        text: message,
                        textColor: Colors.grey,
                        textSize: 16,
                        isStart: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AppText(
              text: Constants.timeAgo(time),
              textColor: Colors.black,
              textSize: 12,
            )
          ],
        ),
      ),
    );
  }
}
