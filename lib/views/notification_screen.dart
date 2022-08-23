import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/notification_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';

class NotificationsActivity extends StatelessWidget {
  final controller = Get.put(NotificationController());
  NotificationsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
          text: 'The Staff Hound',
          textSize: 20,
          isBold: true,
          textColor: Constants.secondaryColor,
        ),
        titleSpacing: 50,
      ),
      body: SafeArea(child: Obx(() {
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
      })),
    );
  }
}
