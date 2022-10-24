import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/custom_widgets/job_item_view.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';

class RecentJobs extends StatelessWidget {
  // final recentJobController = Get.put(RecentJobController());
  const RecentJobs({
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10.0),
            width: size.width,
            color: Colors.white,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search)),
                      hintText: 'Search Jobs',
                      border: InputBorder.none),
                ),
              ),
              InkWell(
                onTap: () {},
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
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Get.to(() => JobDetailsActivity());
                  },
                  child: JobItemView());
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
    );
  }

  assignmentsTab(Size size) {
    return ListView(
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
    ); /* SingleChildScrollView(
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
