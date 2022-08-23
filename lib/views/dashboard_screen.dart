import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/dasboard_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/main.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';
import 'package:the_staff_hound/views/archived_jobs_screen.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';
import 'package:the_staff_hound/views/login_screen.dart';
import 'package:the_staff_hound/views/my_jobs_screen.dart';
import 'package:the_staff_hound/views/notification_screen.dart';
import 'package:the_staff_hound/views/profile_screen.dart';
import 'package:the_staff_hound/views/recent_jobs_screen.dart';
import 'package:the_staff_hound/views/resume_view.dart';

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
                        Get.to(() => NotificationsActivity());
                      },
                      icon: const Icon(
                        Icons.notifications,
                        color: Constants.primaryColor,
                        size: 30,
                      )),
                  /* Positioned(
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
                  ) */
                ]),
              ),
            ],
          ),
          body: Obx(() {
            return Visibility(
              visible: dashboardController.isLoaded.value,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Container(
                width: size.width,
                height: size.height,
                color: Constants.backgroundColor,
                child: RefreshIndicator(
                  onRefresh: () => dashboardController
                      .fetchDashboardData(SharedPrefsManager.getUserToken),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                  Obx(() {
                                    return AppText(
                                      text: dashboardController
                                          .userName.value.capitalizeFirstofEach,
                                      isBold: true,
                                      textSize: 20,
                                    );
                                  })
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
                        /*  InkWell(
                          onTap: () {},
                          child: Container(
                              width: size.width,
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                        ), */
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(top: 40),
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Constants.secondaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AppText(
                                        text: 'Find a nearest branch',
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
                                              'See how close you are to us. \nRegister with your branch to get your desired jobs.',
                                          textColor: Colors.white,
                                          textSize: 15,
                                          isStart: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    child: Image.asset(
                                      Constants.jobImg,
                                      width: 110,
                                      height: 130,
                                    )),
                              ],
                            ),
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
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => MyJobsActivity());
                                      print('Approved Jobs Tapped');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      // width: 170,
                                      // height: 100,
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Obx(() {
                                            return AppText(
                                              text: dashboardController
                                                  .approvedJobs.value
                                                  .toString(),
                                              isBold: true,
                                              isStart: true,
                                              textSize: 25,
                                              textColor: Colors.black,
                                            );
                                          }),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          AppText(
                                            text: 'Approved Jobs',
                                            isStart: true,
                                            textSize: 15,
                                            textColor: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => ArchivedJobsActivity());
                                      // print('Saved Jobs Tapped');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      // width: 170,
                                      // height: 100,
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Obx(() {
                                            return AppText(
                                              text: dashboardController
                                                  .savedJobs.value
                                                  .toString(),
                                              isBold: true,
                                              isStart: true,
                                              textSize: 25,
                                              textColor: Colors.black,
                                            );
                                          }),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          AppText(
                                            text: 'Saved Jobs',
                                            isStart: true,
                                            textSize: 15,
                                            textColor: Colors.black,
                                          ),
                                        ],
                                      ),
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
                                  Get.to(() => RecentJobs(),
                                      arguments: {'more': true});
                                },
                                child: AppText(
                                    text: 'View More',
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: size.width,
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
                                      Get.to(
                                        () => RecentJobs(),
                                        arguments: {
                                          'categoryId': controller
                                              .jobCategoryList[index].id,
                                          'more': false
                                        },
                                      );
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
                                              .jobCategoryList[index].jobTitle!,
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
                        const SizedBox(
                          height: 20,
                        ),
                        /* Padding(
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
                                child: Obx(() {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          dashboardController.featuredJobsList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => JobDetailsActivity(),
                                              arguments: [
                                                {
                                                  'jobId': dashboardController
                                                      .featuredJobsList[index].id
                                                }
                                              ],
                                            );
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
                                                      Container(
                                                          width: 40,
                                                          height: 40,
                                                          padding: EdgeInsets.zero,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10),
                                                          ),
                                                          child: Obx(() {
                                                            return _getImage(
                                                                dashboardController
                                                                    .featuredJobsList[
                                                                        index]
                                                                    .imageUrl);
                                                          })),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      AppText(
                                                        text: dashboardController
                                                            .featuredJobsList[index]
                                                            .jobTitle!,
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
                                                    text: dashboardController
                                                        .featuredJobsList[index]
                                                        .jobTitle!,
                                                    isBold: true,
                                                    isStart: true,
                                                    textColor: Colors.black,
                                                    textSize: 20,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppText(
                                                    text: dashboardController
                                                        .featuredJobsList[index]
                                                        .location!,
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
                                                          text: dashboardController
                                                                  .featuredJobsList[
                                                                      index]
                                                                  .salary ??
                                                              'Empty',
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
                            ), */
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              AppText(
                                text: 'Jobs',
                                textColor: Colors.black,
                                isStart: true,
                                isBold: true,
                                textSize: 25,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => RecentJobs(),
                                      arguments: {'more': true});
                                },
                                child: AppText(
                                  text: 'View More',
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
                            child: Obx(() {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount:
                                      dashboardController.recentJobsList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      height: 1,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return RecentJobsItemView(
                                      dashboardController: dashboardController,
                                      size: size,
                                      index: index,
                                    );
                                  });
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }

  Widget navDrawer() {
    return Drawer(
      backgroundColor: Constants.backgroundColor,
      child: Stack(
        children: <Widget>[
          Obx(() {
            return Stack(
              children: [
                UserAccountsDrawerHeader(
                  accountName: AppText(
                    text: dashboardController
                        .userName.value.capitalizeFirstofEach,
                    textColor: Colors.white,
                    textSize: 18,
                    isBold: true,
                  ),
                  accountEmail: AppText(
                    text: dashboardController.userEmail.value,
                    textColor: Colors.white,
                    textSize: 16,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Constants.secondaryColor,
                    child: AppText(
                      text: dashboardController.userName.value[0].inCaps,
                      textSize: 25,
                      isBold: true,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 10,
                  child: IconButton(
                      onPressed: () async {
                        _globalKey.currentState!.openEndDrawer();
                        var text = await Get.to(
                          () => ProfileActivity(),
                        );

                        if (text == 'refresh') {
                          dashboardController.fetchDashboardData(
                              dashboardController.token.value);
                        }
                      },
                      icon: const Icon(
                        Icons.edit_sharp,
                        color: Colors.white,
                      )),
                )
              ],
            );
          }),
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
                        color: dashboardController
                                .navModelList[index].getIsSelected
                            ? Constants.secondaryColor
                            : Constants.primaryColor,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    title: Obx(
                      () => AppText(
                        text:
                            dashboardController.navModelList[index].getNavName,
                        textSize: 18,
                        isStart: true,
                        textColor: dashboardController
                                .navModelList[index].getIsSelected
                            ? Constants.secondaryColor
                            : const Color.fromRGBO(18, 114, 127, 1),
                      ),
                    ),
                    onTap: () async {
                      // dashboardController.selectedIndex.value = index;

                      // dashboardController.navModelList[index].setIsSelected =
                      //     true;

                      for (int i = 0;
                          i < dashboardController.navModelList.length;
                          i++) {
                        if (i == index) {
                          dashboardController.navModelList[i].setIsSelected =
                              true;
                        } else {
                          dashboardController.navModelList[i].setIsSelected =
                              false;
                        }
                      }

                      switch (index) {
                        case 0:
                          _globalKey.currentState!.openEndDrawer();
                          Get.to(() => MyJobsActivity());
                          // dashboardController.resetNav();
                          break;
                        case 1:
                          _globalKey.currentState!.openEndDrawer();
                          Get.to(() => RecentJobs(), arguments: {'more': true});
                          break;

                        case 2:
                          _globalKey.currentState!.openEndDrawer();
                          Get.to(() => ArchivedJobsActivity());
                          // _globalKey.currentState!.openEndDrawer();
                          // dashboardController.resetNav();
                          break;
                        case 3:
                          _globalKey.currentState!.openEndDrawer();
                          print('Branches Selected');

                          // dashboardController.resetNav();
                          break;
                        case 4:
                          _globalKey.currentState!.openEndDrawer();
                          Get.to(() => ResumeViewActivity());
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
                onPressed: () {
                  SharedPrefsManager.userLogout();
                  Get.off(() => LoginActivity());
                },
                style: TextButton.styleFrom(
                    // padding: const EdgeInsets.symmetric(horizontal: 30),
                    backgroundColor: Constants.buttonBackgroundColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: AppText(
                  text: 'Sign Out',
                  isBold: true,
                  textSize: 15,
                ),
              ))
        ],
      ),
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
  }*/
}

class RecentJobsItemView extends StatelessWidget {
  const RecentJobsItemView(
      {Key? key,
      required this.dashboardController,
      required this.size,
      required this.index})
      : super(key: key);

  final DashBoardController dashboardController;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var text = await Get.to(
          () => JobDetailsActivity(),
          arguments: [
            {
              'jobId': dashboardController.recentJobsList[index].id,
              'status': 'new'
            }
          ],
        );

        if (text == 'refresh') {
          dashboardController
              .fetchDashboardData(dashboardController.token.value);
        }
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: size.width,
            color: Colors.white,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Constants.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AppText(
                        text: 'J',
                        textSize: 30,
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
                        text:
                            dashboardController.recentJobsList[index].jobTitle!,
                        isBold: true,
                        isStart: true,
                        textColor: Colors.black,
                        textSize: 20,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AppText(
                        text:
                            dashboardController.recentJobsList[index].location!,
                        textColor: Constants.textHintColor,
                        isStart: true,
                        textSize: 13,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          AppText(
                            text: 'Salary:',
                            textSize: 18,
                            isBold: true,
                            isStart: true,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          AppText(
                            text: dashboardController
                                    .recentJobsList[index].salary ??
                                '500,000',
                            textSize: 18,
                            isBold: true,
                            isStart: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        dashboardController.addToArchive(
                            dashboardController.recentJobsList[index].id!);
                        dashboardController.fetchDashboardData(
                            SharedPrefsManager.getUserToken);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: () async {
                        var text = await Get.to(
                          () => JobDetailsActivity(),
                          arguments: [
                            {
                              'jobId':
                                  dashboardController.recentJobsList[index].id,
                              'status': 'new'
                            }
                          ],
                        );

                        if (text == 'refresh') {
                          dashboardController.fetchDashboardData(
                              dashboardController.token.value);
                        }
                      },
                      icon: const Icon(
                        Icons.remove_red_eye_rounded,
                        color: Constants.primaryColor,
                      )),
                ],
              ))

          /* PopupMenuButton(
              itemBuilder: (context) => [
                // popupmenu item 1
                PopupMenuItem(
                    value: 1,
                    // row has two child icon and text.
                    child: AppText(
                      text: 'Apply',
                    )),
                // popupmenu item 2
                PopupMenuItem(
                  value: 2,
                  // row has two child icon and text
                  child: Row(
                    children: const [
                      Icon(Icons
                          .chrome_reader_mode),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("About")
                    ],
                  ),
                ),
              ],
              offset: const Offset(0, 100),
              color: Colors.grey,
              elevation: 2,
            ), */
          /*  IconButton(
                onPressed: () {
                  dashboardController
                      .addToArchive(
                          dashboardController
                              .recentJobsList[
                                  index]
                              .id!);
                  dashboardController
                      .fetchDashboardData(
                          SharedPrefsManager
                              .getUserToken);
                },
                icon: const Icon(
                  Icons.archive,
                  color:
                      Constants.secondaryColor,
                )) */
        ],
      ),
    );
  }
}
