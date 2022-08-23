import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/recent_job_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';

class RecentJobs extends StatelessWidget {
  final recentJobController = Get.put(RecentJobController());
  RecentJobs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Constants.backgroundColor,
        elevation: 1,
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
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 30),
            Expanded(
                child: SingleChildScrollView(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: size.width - 100,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Constants.textHintColor,
                                    offset: Offset(0.2, 0.2),
                                    blurRadius: 1)
                              ]),
                          child: Center(
                            child: SizedBox(
                              width: 500,
                              child: TextField(
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'search job here...',
                                    suffixIcon: IconButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.search,
                                        size: 24,
                                        color: Colors.grey,
                                      ),
                                    )),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                recentJobController.openFiltersDialog(size);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Colors.amberAccent.shade100),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)))),
                              child: AppText(text: 'Filters'),
                            ),
                          ),
                        )
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
                        return Visibility(
                            visible: recentJobController.isLoaded.value,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: recentJobController.jobsList.length,
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
                                    onTap: () {
                                      print(recentJobController
                                          .jobsList[index].id);
                                      Get.to(
                                        () => JobDetailsActivity(),
                                        arguments: [
                                          {
                                            'jobId': recentJobController
                                                .jobsList[index].id,
                                            'status': 'new'
                                          }
                                        ],
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
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
                                                    padding: EdgeInsets.zero,
                                                    decoration: BoxDecoration(
                                                      color: Constants
                                                          .secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                        child: AppText(
                                                      text: 'J',
                                                      textSize: 30,
                                                      isBold: true,
                                                      textColor: Colors.white,
                                                    ))),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    AppText(
                                                      text: recentJobController
                                                          .jobsList[index]
                                                          .jobTitle!,
                                                      isBold: true,
                                                      isStart: true,
                                                      textColor: Colors.black,
                                                      textSize: 20,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    AppText(
                                                      text: recentJobController
                                                          .jobsList[index]
                                                          .location!,
                                                      textColor: Constants
                                                          .textHintColor,
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
                                                          textSize: 15,
                                                          isBold: true,
                                                          isStart: true,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        AppText(
                                                          text:
                                                              recentJobController
                                                                      .jobsList[
                                                                          index]
                                                                      .salary ??
                                                                  'N/A',
                                                          textSize: 15,
                                                          isBold: true,
                                                          isStart: true,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
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
                                                      recentJobController
                                                          .addToArchive(
                                                              recentJobController
                                                                  .jobsList[
                                                                      index]
                                                                  .id!);
                                                    },
                                                    icon: const Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      Get.to(
                                                        () =>
                                                            JobDetailsActivity(),
                                                        arguments: [
                                                          {
                                                            'jobId':
                                                                recentJobController
                                                                    .jobsList[
                                                                        index]
                                                                    .id,
                                                            'status': 'new'
                                                          }
                                                        ],
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .remove_red_eye_rounded,
                                                      color: Constants
                                                          .primaryColor,
                                                    )),
                                              ],
                                            ))
                                      ],
                                    ),
                                  );
                                }));
                      }),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      )),
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
