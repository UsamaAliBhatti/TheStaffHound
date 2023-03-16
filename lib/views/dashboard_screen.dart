import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/auth_service/auth_api.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/dasboard_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/helper/dialog_helper.dart';
import 'package:the_staff_hound/main.dart';
import 'package:the_staff_hound/routes/app_pages.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class DashboardActivity extends StatelessWidget {
  final dashboardController = Get.put(DashBoardController());

  DashboardActivity({Key? key}) : super(key: key);
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _globalKey,
        backgroundColor: Constants.backgroundColor,
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
                      Get.toNamed(Routes.NOTIFICATIONS);
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
          return RefreshIndicator(
            onRefresh: () async {
              dashboardController.fetchAllData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 20, right: 20),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Get.toNamed(Routes.MY_JOBS);
                                print('Approved Jobs Tapped');
                              },
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                Get.toNamed(Routes.MY_JOBS);
                                // print('Saved Jobs Tapped');
                              },
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppText(
                          text: 'Job Categories',
                          textSize: 25,
                          textColor: Colors.black,
                          isBold: true,
                          isStart:
                              true), /* Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                     
                                   /*    InkWell(
                                        onTap: () {
                                          Get.to(() => const RecentJobs(),
                                              arguments: {'more': true});
                                        },
                                        child: AppText(
                                            text: 'View More',
                                            textSize: 15,
                                            textColor: Constants.primaryColor,
                                            isBold: true,
                                            isStart: true),
                                      ) */
                                    ],
                                  ), */
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: size.width,
                    height: 60,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dashboardController.jobCategoryList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.RECENT_JOBS,
                                arguments: [
                                  {
                                    'categoryId': dashboardController
                                        .jobCategoryList[index].id
                                  }
                                ],
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.primaries[
                                      index % Colors.primaries.length],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: AppText(
                                  text: dashboardController
                                      .jobCategoryList[index].title,
                                  textColor: Colors.white,
                                  textSize: 17,
                                  isBold: true,
                                ),
                              ),
                            ),
                          );
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AppText(
                          text: 'Job Offers',
                          textColor: Colors.black,
                          isStart: true,
                          isBold: true,
                          textSize: 25,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.RECENT_JOBS, arguments: [
                                {'categoryId': 0}
                              ]);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.search),
                                AppText(
                                  text: 'Search',
                                  textSize: 15,
                                  isBold: true,
                                ),
                              ],
                            ))
                        /* InkWell(
                                      onTap: () {
                                        
                                      },
                                      child: AppText(
                                        text: 'View More',
                                        textColor: Constants.primaryColor,
                                        textSize: 15,
                                        isBold: true,
                                      ),
                                    ), */
                      ],
                    ),
                  ),
                  /*  const SizedBox(
                                height: 10,
                              ), */
                  if (dashboardController.jobsList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dashboardController.jobsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return /*  InkWell(
                                onTap: () =>
                                    Get.toNamed(Routes.JOB_DETAILS, arguments: [
                                      {
                                        'offerID': dashboardController
                                            .jobsList[index].id,
                                        'type': 'offer'
                                      }
                                    ]),
                                child: */
                                jobItemView(
                              size: size,
                              offerID: dashboardController.jobsList[index].id,
                              jobTitle:
                                  dashboardController.jobsList[index].title,
                              address:
                                  dashboardController.jobsList[index].branch,
                              salaryRange:
                                  dashboardController.jobsList[index].rateHour,
                              jobPostTime:
                                  dashboardController.jobsList[index].createdAt,
                              //)
                            );
                          },
                        )
                        /*  Obx(() {
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
                                  }) */
                        ,
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: AppText(
                          text: 'No Offers Yet',
                          isBold: true,
                          textSize: 25,
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        })
        /*  Obx(() {
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AppText(
                              text: 'Assignment Categories',
                              textSize: 25,
                              textColor: Colors.black,
                              isBold: true,
                              isStart:
                                  true), /* Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                             
                           /*    InkWell(
                                onTap: () {
                                  Get.to(() => const RecentJobs(),
                                      arguments: {'more': true});
                                },
                                child: AppText(
                                    text: 'View More',
                                    textSize: 15,
                                    textColor: Constants.primaryColor,
                                    isBold: true,
                                    isStart: true),
                              ) */
                            ],
                          ), */
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
                                      () => const RecentJobs(),
                                      /*   arguments: {
                                        'categoryId': controller
                                            .jobCategoryList[index].id,
                                        'more': false
                                      }, */
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AppText(
                              text: 'Assignments',
                              textColor: Colors.black,
                              isStart: true,
                              isBold: true,
                              textSize: 25,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => const RecentJobs(),
                                      arguments: {'more': true});
                                },
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.search),
                                    AppText(
                                      text: 'Search',
                                      textSize: 15,
                                      isBold: true,
                                    ),
                                  ],
                                ))
                            /* InkWell(
                              onTap: () {
                                
                              },
                              child: AppText(
                                text: 'View More',
                                textColor: Constants.primaryColor,
                                textSize: 15,
                                isBold: true,
                              ),
                            ), */
                          ],
                        ),
                      ),
                      /*  const SizedBox(
                        height: 10,
                      ), */
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () =>
                                      Get.to(() => JobDetailsActivity()),
                                  child: JobItemView());
                            },
                          ) /*  Obx(() {
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
                          }) */
                          ,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }) */
        );
  }

  Widget navDrawer() {
    return SafeArea(
      child: Drawer(
        backgroundColor: Constants.backgroundColor,
        child: Stack(
          children: <Widget>[
            Stack(
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
                        var text = await Get.toNamed(Routes.PROFILE);

                        if (text == 'refresh') {
                          dashboardController.fetchDashboardData(
                              SharedPrefsManager.getUserToken);
                        }
                      },
                      icon: const Icon(
                        Icons.edit_sharp,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            AppText(
                              text: 'Available?',
                              textColor: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            /*  ToggleButtons(isSelected: const [
                                false,
                                false
                              ], children: [
                                AppText(
                                  text: 'Active',
                                  textColor: Colors.white,
                                ),
                                AppText(
                                  text: 'Away',
                                  textColor: Colors.white,
                                ),
                              ]) */

                            GetX<DashBoardController>(
                              init: DashBoardController(),
                              initState: (_) {},
                              builder: (_) {
                                return Switch(
                                    activeColor: Constants.secondaryColor,
                                    value:
                                        dashboardController.isAvailable.value,
                                    onChanged: (value) {
                                      dashboardController.isAvailable.value =
                                          value;
                                      if (dashboardController
                                          .isAvailable.isFalse) {
                                        DialogHelper.openDurationDialog();
                                      } else {
                                        AuthApis.setUserAvailability(
                                            SharedPrefsManager.getUserToken, 0);
                                      }
                                    });
                              },
                            )
                            /*  ToggleSwitch(
                                minWidth: 45,
                                minHeight: 25,
                                totalSwitches: 2,
                                labels: const ['Yes', 'No'],
                                fontSize: 14,
                                initialLabelIndex: null,
                                customTextStyles: const [
                                  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)
                                ],
                                activeBgColor: const [Constants.secondaryColor],
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.grey[900],
                                onToggle: (index) {
                                  switch (index) {
                                    case 0:
                                      // _isEducationContinue.value = 'true';
                                      break;
                                    case 1:
                                      //_isEducationContinue.value = 'false';
                                      break;
                                  }
                                },
                              ), */
                          ],
                        ),
                      ],
                    ))
              ],
            ),
            GetX<DashBoardController>(
              init: DashBoardController(),
              initState: (_) {},
              builder: (_) {
                return Center(
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
                              text: dashboardController
                                  .navModelList[index].getNavName,
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
                                dashboardController
                                    .navModelList[i].setIsSelected = true;
                              } else {
                                dashboardController
                                    .navModelList[i].setIsSelected = false;
                              }
                            }

                            switch (index) {
                              case 0:
                                _globalKey.currentState!.openEndDrawer();
                                Get.toNamed(Routes.MY_JOBS);
                                // dashboardController.resetNav();
                                break;
                              case 1:
                                _globalKey.currentState!.openEndDrawer();
                                Get.toNamed(Routes.RECENT_JOBS, arguments: [
                                  {'categoryId': 0}
                                ]);
                                break;

                              /*  case 2:
                                _globalKey.currentState!.openEndDrawer();
                                Get.to(() => ArchivedJobsActivity());
                                // _globalKey.currentState!.openEndDrawer();
                                // dashboardController.resetNav();
                                break; */
                              case 2:
                                _globalKey.currentState!.openEndDrawer();
                                Get.toNamed(Routes.BRANCHES);

                                // dashboardController.resetNav();
                                break;
                              case 3:
                                _globalKey.currentState!.openEndDrawer();
                                Get.toNamed(Routes.VIEW_RESUME);
                                break;
                              default:
                                Get.back();
                            }
                          });
                    }),
                  ),
                );
              },
            ),
            Positioned(
                left: 90,
                bottom: 30,
                width: 120,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    SharedPrefsManager.userLogout();
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
      ),
    );
  }

  jobItemView(
      {Size? size,
      String? jobTitle,
      bool? isSaved = false,
      int? offerID,
      String? address,
      String? salaryRange,
      DateTime? jobPostTime}) {
    return Container(
      width: size!.width,
      decoration: const BoxDecoration(color: Colors.white, border: Border()),
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
                          Get.toNamed(Routes.NOTIFICATION_DETAILS, arguments: [
                            {'offerID': offerID, 'type': 'offer'}
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
              /*  IconButton(
                splashRadius: 10,
                splashColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  dashboardController.saveProject(offerID!, 1);
                },
                icon: Icon(
                  isSaved! ? Icons.favorite : Icons.favorite_outline,
                  color: Constants.primaryColor,
                ),
              ) */
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


/* class RecentJobsItemView extends StatelessWidget {
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
                      icon: const Icon(Icons.favorite_border_outlined,
                          color: Constants.primaryColor)),
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
} */
