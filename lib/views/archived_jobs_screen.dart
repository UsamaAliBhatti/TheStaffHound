import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/archived_jobs_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';

class ArchivedJobsActivity extends StatelessWidget {
  final  controller = Get.put(ArchivedJobsController());
  ArchivedJobsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.secondaryColor,
        title: AppText(
          text: 'Saved Jobs',
          textColor: Colors.white,
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
            color: Colors.white,
          ),
        ),
        elevation: 1,
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
              itemCount: controller.archivedJobsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (() {
                    Get.to(() => JobDetailsActivity(), arguments: [
                      {
                        'jobId': controller.archivedJobsList[index].id,
                        'status': 'new'
                      }
                    ]);
                  }),
                  child: Card(
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
                                alignment: Alignment.center,
                                width: 40,
                                height: 40,
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
                                ) /* Obx(() {
                                  return _getImage(controller
                                      .archivedJobsList[index].imageUrl);
                                }) */
                                ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AppText(
                                  text: controller
                                      .archivedJobsList[index].jobTitle!,
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
                                      .archivedJobsList[index].location!,
                                  textColor: Constants.textHintColor,
                                  isStart: true,
                                  textSize: 13,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                AppText(
                                  text: controller
                                          .archivedJobsList[index].salary ??
                                      'Empty',
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
