import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/branches_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/custom_widgets/my_scroll_behavior.dart';

class BranchesActivity extends StatelessWidget {
  final branchesController = Get.put(BranchesController());
  BranchesActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.black,
              )),
          backgroundColor: Constants.backgroundColor,
          elevation: 1,
          title: AppText(
            text: 'Manage Branches',
            textColor: Colors.black,
            textSize: 18,
            isBold: true,
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          return SafeArea(
              child: Container(
            margin: const EdgeInsets.all(20),
            width: size.width,
            height: size.height,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.radio_button_checked_sharp,
                        color: Constants.secondaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AppText(
                        text: 'Default Branches',
                        textSize: 18,
                        isBold: true,
                        textColor: Colors.black,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: branchesController.currentBranchesList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey.shade200),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.location_pin,
                                    color: Colors.black,
                                  ),
                                  AppText(
                                    text: branchesController
                                        .currentBranchesList[index],
                                    textColor: Colors.black,
                                  ),
                                ],
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ))),
                                  onPressed: () {},
                                  child: AppText(
                                    text: 'Remove',
                                  ))
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  AppText(
                    text: 'Update Branches',
                    textSize: 20,
                    isBold: true,
                    textColor: Colors.black,
                    isStart: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: 'Select City',
                            isBold: true,
                            textColor: Colors.black,
                            textSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                              itemCount: branchesController.listOfCities.length,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.radio_button_checked,
                                            color: Constants.secondaryColor,
                                          )),
                                      AppText(
                                        text: branchesController
                                            .listOfCities[index],
                                        textColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: 'Select Branch',
                            isBold: true,
                            textColor: Colors.black,
                            textSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: branchesController.listOfBranches.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey.shade200),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        color: Colors.black,
                                      ),
                                      AppText(
                                        text: branchesController
                                            .listOfBranches[index],
                                        textColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      focusColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Constants.secondaryColor,
                                      ))
                                ],
                              ),
                            );
                          },
                        ),

                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.teal.shade100),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                            onPressed: () {},
                            child: AppText(
                              text: 'Add',
                              isBold: true,
                              textSize: 18,
                            ))
                        // ListView.builder()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        }));
  }
}
