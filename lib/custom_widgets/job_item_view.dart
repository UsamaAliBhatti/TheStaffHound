import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

import '../controllers/recent_job_controller.dart';
import '../routes/app_pages.dart';

// ignore: must_be_immutable
class JobItemView extends StatelessWidget {
  var contoller = Get.put(RecentJobController());

  bool? isSaved;
  int? offerID;
  // Offer? data;
  // String? companyLogo;
  String? jobTitle;
  String? address;
  String? salaryRange;
  String? jobDuration;
  String? jobType;
  DateTime? jobPostTime;
  String? shiftType;
  bool? isNew;
  bool? showBorder;

  JobItemView(
      {Key? key,
      this.offerID,
      this.isSaved = false,
      // this.companyLogo,
      this.address,
      this.jobDuration,
      this.jobTitle,
      this.salaryRange,
      this.jobType,
      this.jobPostTime,
      this.shiftType,
      this.isNew = false,
      this.showBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: showBorder!
              ? Border(
                  left: BorderSide(
                      color: isNew! ? Constants.primaryColor : Colors.grey,
                      width: 5))
              : const Border()),
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
              shiftType != null
                  ? AppText(
                      text: shiftType!,
                      textColor: Colors.grey,
                      textSize: 12,
                    )
                  : IconButton(
                      splashRadius: 10,
                      splashColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        contoller.saveProject(offerID!, 1);
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
}
