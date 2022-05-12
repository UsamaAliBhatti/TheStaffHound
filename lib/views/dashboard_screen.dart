import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/dasboard_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/my_jobs_screen.dart';
import 'package:the_staff_hound/views/notification_screen.dart';
import 'package:the_staff_hound/views/profile_screen.dart';
import 'package:the_staff_hound/views/recent_jobs_screen.dart';
import 'package:the_staff_hound/views/reset_password_screen.dart';

class DashboardActivity extends StatelessWidget {
  final dashboardController = Get.put(DashBoardController());
  DashboardActivity({Key? key}) : super(key: key);
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: navDrawer(),
        appBar: AppBar(
          backgroundColor: Constants.backgroundColor,
          elevation: 1,
          titleSpacing: 0,
          shape: const Border(
              bottom: BorderSide(color: Colors.black26, width: 0.2)),
          shadowColor: Colors.black38,
          toolbarHeight: 70,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            width: 25,
            height: 25,
            child: IconButton(
                onPressed: () {
                  _globalKey.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(children: <Widget>[
                IconButton(
                    onPressed: () {
                      Get.to(() => const NotificationsActivity());
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Constants.primaryColor,
                      size: 30,
                    )),
                Positioned(
                  // draw a red marble
                  top: 1,
                  right: 1,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.secondaryColor),
                    child: Center(
                      child: AppText(
                        text: '2',
                        textSize: 13,
                        isBold: true,
                        textColor: Colors.black,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Constants.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              /*   Container(
            decoration: const BoxDecoration(
                color: Constants.backgroundColor,
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(0, 0.5))
                ]),
            child: Row(
              children: <Widget>[
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              ],
            ),
          ), */
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AppText(
                                  text: "Hello",
                                  textSize: 15,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppText(
                                  text: "Richard Brownlee",
                                  isBold: true,
                                  textSize: 20,
                                )
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.all(8),
                                width: 50,
                                height: 50, // Border width
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWVufGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                                      fit: BoxFit.cover),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            width: size.width,
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  AppText(
                                    text: 'search job here...',
                                    textSize: 18,
                                    textColor: Colors.grey,
                                  ),
                                  const Icon(
                                    Icons.search,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                ])),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.only(top: 30),
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Constants.secondaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppText(
                                    text: 'Recomended Jobs',
                                    textColor: Colors.white,
                                    isBold: true,
                                    textSize: 20,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 230,
                                    child: AppText(
                                      text:
                                          'See our recomendations job for you based on your skills',
                                      textColor: Colors.white,
                                      textSize: 15,
                                      isStart: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 20,
                                child: Image.asset(
                                  Constants.jobImg,
                                  width: 100,
                                  height: 120,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  // width: 170,
                                  // height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade100,
                                          offset: const Offset(2, 3),
                                          blurRadius: 5,
                                        )
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AppText(
                                        text: '45',
                                        isBold: true,
                                        isStart: true,
                                        textSize: 25,
                                        textColor: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppText(
                                        text: 'Jobs Applied',
                                        isStart: true,
                                        textSize: 15,
                                        textColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  // width: 170,
                                  // height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade100,
                                          offset: const Offset(2, 3),
                                          blurRadius: 5,
                                        )
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AppText(
                                        text: '28',
                                        isBold: true,
                                        isStart: true,
                                        textSize: 25,
                                        textColor: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppText(
                                        text: 'Interviews',
                                        isStart: true,
                                        textSize: 15,
                                        textColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AppText(
                                text: 'Job Categories',
                                textSize: 25,
                                textColor: Colors.black,
                                isBold: true,
                                isStart: true),
                            InkWell(
                              onTap: () {
                                Get.to(() => RecentJobs());
                              },
                              child: AppText(
                                  text: 'MORE',
                                  textSize: 15,
                                  textColor: Constants.primaryColor,
                                  isBold: true,
                                  isStart: true),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 60,
                          child:
                              GetX<DashBoardController>(builder: (controller) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.jobCategoryList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => RecentJobs());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.primaries[
                                              index % Colors.primaries.length],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: AppText(
                                          text: controller
                                              .jobCategoryList[index]
                                              .jobCategoryName,
                                          textColor: Colors.white,
                                          textSize: 17,
                                          isBold: true,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: 'Featured Jobs',
                            isStart: true,
                            isBold: true,
                            textColor: Colors.black,
                            textSize: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: size.width,
                          height: 170,
                          child:
                              GetX<DashBoardController>(builder: (controller) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.featuredJobsList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => RecentJobs());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: 260,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade100,
                                              offset: const Offset(2, 3),
                                              blurRadius: 5,
                                            )
                                          ]),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                // ClipRRect(
                                                //   borderRadius:
                                                //       BorderRadius.circular(
                                                //           20), // Image border
                                                //   child: SizedBox.fromSize(
                                                //     size: const Size.fromRadius(
                                                //         48), // Image radius
                                                //     child: Image.network('imageUrl',
                                                //         fit: BoxFit.cover),
                                                //   ),
                                                // ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  padding: EdgeInsets.zero,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            controller
                                                                .featuredJobsList[
                                                                    index]
                                                                .companyLogo,
                                                          ),
                                                          fit: BoxFit.fill)),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                AppText(
                                                  text: controller
                                                      .featuredJobsList[index]
                                                      .companyName,
                                                  isBold: true,
                                                  isStart: true,
                                                  textColor:
                                                      Constants.textHintColor,
                                                  textSize: 15,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppText(
                                              text: controller
                                                  .featuredJobsList[index]
                                                  .jobTitle,
                                              isBold: true,
                                              isStart: true,
                                              textColor: Colors.black,
                                              textSize: 20,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppText(
                                              text: controller
                                                  .featuredJobsList[index]
                                                  .jobLocation,
                                              textColor:
                                                  Constants.textHintColor,
                                              isStart: true,
                                              textSize: 13,
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  AppText(
                                                    text: controller
                                                        .featuredJobsList[index]
                                                        .jobSalaryRange,
                                                    textSize: 20,
                                                    isBold: true,
                                                    isStart: true,
                                                  ),
                                                  const Icon(
                                                    Icons.keyboard_arrow_right,
                                                    color:
                                                        Constants.textHintColor,
                                                  )
                                                ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AppText(
                              text: 'Recent Jobs List',
                              textColor: Colors.black,
                              isStart: true,
                              isBold: true,
                              textSize: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(RecentJobs());
                              },
                              child: AppText(
                                text: 'MORE',
                                textColor: Constants.primaryColor,
                                textSize: 15,
                                isBold: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: size.width,
                          child:
                              GetX<DashBoardController>(builder: (controller) {
                            return ListView.separated(
                                shrinkWrap: true,
                                itemCount: controller.recentJobsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 1,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      width: size.width,
                                      color: Colors.white,
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        controller
                                                            .recentJobsList[
                                                                index]
                                                            .companyLogo,
                                                      ),
                                                      fit: BoxFit.fill)),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                AppText(
                                                  text: controller
                                                      .recentJobsList[index]
                                                      .jobTitle,
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
                                                      .recentJobsList[index]
                                                      .jobLocation,
                                                  textColor:
                                                      Constants.textHintColor,
                                                  isStart: true,
                                                  textSize: 13,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AppText(
                                                  text: controller
                                                      .recentJobsList[index]
                                                      .jobSalaryRange,
                                                  textSize: 18,
                                                  isBold: true,
                                                  isStart: true,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget navDrawer() {
    return Drawer(
      backgroundColor: Constants.backgroundColor,
      child: Stack(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: AppText(
              text: 'Usama Ali',
              textColor: Colors.white,
              textSize: 18,
              isBold: true,
            ),
            accountEmail: AppText(
              text: 'usamaali185.ua@gmail.com',
              textColor: Colors.white,
              textSize: 16,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Constants.secondaryColor,
              child: AppText(
                text: 'U',
                textSize: 25,
                isBold: true,
              ),
            ),
          ),
          Center(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dashboardController.navModelList.length,
              itemBuilder: ((context, index) {
                return ListTile(
                    contentPadding: const EdgeInsets.only(left: 20),
                    leading: Obx(
                      () => Image.asset(
                        dashboardController.navModelList[index].getIcon,
                        color:
                            (dashboardController.selectedIndex.value == index)
                                ? Constants.secondaryColor
                                : Constants.primaryColor,
                      ),
                    ),
                    title: Obx(
                      () => AppText(
                        text:
                            dashboardController.navModelList[index].getNavName,
                        textSize: 18,
                        isStart: true,
                        textColor:
                            (dashboardController.selectedIndex.value == index)
                                ? Constants.secondaryColor
                                : Constants.primaryColor,
                      ),
                    ),
                    onTap: () {
                      dashboardController.selectedIndex.value = index;

                      switch (index) {
                        case 0:
                          _globalKey.currentState!.openEndDrawer();
                          Get.to(
                            () => const ProfileActivity(),
                          );
                          break;
                        case 1:
                          _globalKey.currentState!.openEndDrawer();
                          Get.to(() => RecentJobs());
                          break;
                        case 2:
                          _globalKey.currentState!.openEndDrawer();
                          Get.to(() => const ResetPasswordActivity());
                          break;
                        case 3:
                          _globalKey.currentState!.openEndDrawer();
                          Get.to(() => const MyJobsActivity());
                          break;
                        default:
                          Get.back();
                      }
                    });
              }),
            ),
          ),
          Positioned(
              left: 90,
              bottom: 30,
              width: 120,
              height: 50,
              child: TextButton(
                onPressed: () {},
                child: AppText(
                  text: 'Sign Out',
                  isBold: true,
                  textSize: 15,
                ),
                style: TextButton.styleFrom(
                    // padding: const EdgeInsets.symmetric(horizontal: 30),
                    backgroundColor: Constants.buttonBackgroundColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
              ))
        ],
      ),
    );
  }
}
