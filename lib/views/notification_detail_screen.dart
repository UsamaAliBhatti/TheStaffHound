import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/notification_detail_controller.dart';
import '../custom_widgets/app_text.dart';

class NotificationDetailScreen extends StatelessWidget {
  final controller = Get.put(NotificationDetailController());
  NotificationDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
//
    return Scaffold(
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
            text: 'Offer Details',
            textSize: 22,
            isBold: true,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_sharp,
                  color: Constants.primaryColor,
                )),
            Obx(() {
              return IconButton(
                  onPressed: () {
                    if (controller.status.value == '1') {
                      controller.saveProject(controller.jobId.value, 0);
                    } else {
                      controller.saveProject(controller.jobId.value, 1);
                    }
                  },
                  icon: Icon(
                    controller.status.value == '0'
                        ? Icons.favorite_border_sharp
                        : Icons.favorite_sharp,
                    color: Constants.primaryColor,
                  ));
            })
          ],
        ),
        body: Obx(() {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.type.value == 'new'
                    ? Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Constants.secondaryColor,
                        child: AppText(
                          text:
                              'Congratulation! You have been offered this job',
                          textColor: Colors.white,
                          isBold: true,
                        ),
                      )
                    : const SizedBox(),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: AppText(
                //     text: 'NEW',
                //     textColor: Colors.grey.shade400,
                //     textSize: 12,
                //     isStart: true,
                //   ),
                // ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      AppText(
                        text: controller.offerDetail.value.success != null
                            ? controller.offerDetail.value.success!.title
                            : 'N/A',
                        textColor: Constants.primaryColor,
                        isBold: true,
                        textSize: 20,
                        isStart: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AppText(
                        text: controller.offerDetail.value.success != null
                            ? controller.offerDetail.value.success!.client!
                                    .companyName ??
                                'N/A'
                            : 'N/A',
                        textColor: Colors.black,
                        textSize: 15,
                        isStart: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AppText(
                        text: controller.offerDetail.value.success != null
                            ? controller
                                    .offerDetail.value.success!.hiringType ??
                                'N/A'
                            : 'N/A',
                        textColor: Colors.grey.shade600,
                        textSize: 12,
                        isStart: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.folder_copy,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                AppText(
                                  text: controller.offerDetail.value.success !=
                                          null
                                      ? controller.offerDetail.value.success!
                                          .client!.businessCategory
                                      : 'N/A',
                                  textSize: 13,
                                  textColor: Colors.black,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                AppText(
                                  text: controller.offerDetail.value.success !=
                                          null
                                      ? controller.offerDetail.value.success!
                                          .client!.companyAddress
                                      : 'N/A',
                                  textSize: 13,
                                  textColor: Colors.black,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money_sharp,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                AppText(
                                  text: controller.offerDetail.value.success !=
                                          null
                                      ? '\$${controller.offerDetail.value.success!.rateHour} per hour'
                                      : 'N/A',
                                  textSize: 13,
                                  textColor: Colors.black,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_sharp,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                AppText(
                                  text: controller.offerDetail.value.success !=
                                          null
                                      ? controller.offerDetail.value.success!
                                                  .requiredAt ==
                                              null
                                          ? 'N/A'
                                          : 'Apply before  ${Constants.convertDate(controller.offerDetail.value.success!.requiredAt!)}'
                                      : 'N/A',
                                  textSize: 13,
                                  textColor: Colors.black,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'Job Description',
                            textColor: Colors.black,
                            textSize: 15,
                            isBold: true,
                          ),
                          AnimateIcons(
                              endIconColor: Colors.black,
                              startIconColor: Colors.black,
                              size: 25,
                              startIcon: Icons.keyboard_arrow_up_sharp,
                              endIcon: Icons.keyboard_arrow_down_sharp,
                              onStartIconPress: () {
                                controller.isDescriptionPressed.value = true;
                                return true;
                              },
                              onEndIconPress: () {
                                controller.isDescriptionPressed.value = false;
                                return true;
                              },
                              duration: const Duration(milliseconds: 500),
                              controller: AnimateIconController()),
                        ],
                      ),
                      controller.isDescriptionPressed.isFalse
                          ? Text(
                              controller.offerDetail.value.success != null
                                  ? controller.offerDetail.value.success!
                                          .description ??
                                      'N/A'
                                  : 'N/A',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  height: 1.5,
                                  wordSpacing: 1.5),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'Responsibilities / Duties',
                            textColor: Colors.black,
                            textSize: 15,
                            isBold: true,
                          ),
                          AnimateIcons(
                              endIconColor: Colors.black,
                              startIconColor: Colors.black,
                              size: 25,
                              startIcon: Icons.keyboard_arrow_up_sharp,
                              endIcon: Icons.keyboard_arrow_down_sharp,
                              onStartIconPress: () {
                                controller.isDutiesPressed.value = true;
                                return true;
                              },
                              onEndIconPress: () {
                                controller.isDutiesPressed.value = false;
                                return true;
                              },
                              duration: const Duration(milliseconds: 500),
                              controller: AnimateIconController()),
                        ],
                      ),
                      /*    const SizedBox(
                                      height: 10,
                                    ), */
                      controller.isDutiesPressed.isFalse
                          ? AppText(
                              text: controller.offerDetail.value.success != null
                                  ? controller.offerDetail.value.success!
                                          .responsibilities ??
                                      'N/A'
                                  : 'N/A',
                              textColor: Colors.black,
                              textSize: 15,
                              isStart: true,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      AppText(
                        text: 'Work Schedule',
                        textColor: Colors.black,
                        textSize: 16,
                        isStart: true,
                        isBold: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.offerDetail.value.success != null
                            ? controller
                                    .offerDetail.value.success!.workingHours ??
                                'N/A'
                            : 'N/A',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            height: 1.5,
                            wordSpacing: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /* Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 60,
                    width: size.width / 1.5,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35))),
                            backgroundColor: const MaterialStatePropertyAll(
                                Constants.primaryColor)),
                        onPressed: () {},
                        child: AppText(
                          textSize: 18,
                          text: 'Apply',
                          isBold: true,
                          textColor: Colors.white,
                        )),
                  ),
                ), */
                controller.isAccepted.value == 'accepted'
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        width: size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Constants.secondaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: AppText(
                            text: controller.isAccepted.value.capitalizeFirst!,
                            textSize: 20,
                            isBold: true,
                            textColor: Colors.white,
                          ),
                        ),
                      )
                    : (controller.isAccepted.value == 'declined')
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            width: size.width,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Constants.secondaryColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: AppText(
                                text: controller
                                    .isAccepted.value.capitalizeFirst!,
                                textSize: 20,
                                isBold: true,
                                textColor: Colors.white,
                              ),
                            ))
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: size.width / 2.8,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Constants.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          )),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Constants
                                                      .buttonBackgroundColor)),
                                      onPressed: () {
                                        controller.respondToOffer(
                                            controller.jobId.value, 'declined');
                                      },
                                      child: AppText(
                                        textSize: 18,
                                        text: 'Decline',
                                        isBold: true,
                                      )),
                                ),
                                SizedBox(
                                  height: 60,
                                  width: size.width / 2.8,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35))),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Constants.primaryColor)),
                                      onPressed: () {
                                        controller.respondToOffer(
                                            controller.jobId.value, 'accepted');
                                      },
                                      child: AppText(
                                        textSize: 18,
                                        text: 'Accept',
                                        isBold: true,
                                        textColor: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                const SizedBox(
                  height: 10,
                )
                /* Container(
                  width: size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                  decoration: const BoxDecoration(
                      color: Constants.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, -0.01),
                            blurRadius: 10.0)
                      ]),
                  child: 
                ) */
              ]);

          /* Visibility(
              visible: jobDetailController.isLoaded.value,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Obx(() {
                return jobDetailController.status.value == 'approved'
                    ? appliedJobDetailFunction(size, context)
                    : simpleJobDetailsMethod(size, context);
              })); */
        }));
  }
}
