import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/main_api_services.dart';
import 'package:the_staff_hound/api_services/response_models/jobs_model.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

import '../api_services/response_models/dashboard_offers_response.dart';
import '../api_services/response_models/general_data_class.dart';

class RecentJobController extends GetxController {
  var categoryId = 0.obs;
  var jobsList = <Data>[].obs;
  var offersList = <Offer>[].obs;
  var controller = TextEditingController();
  var isLoaded = false.obs;
  var isEmpty = false;
  var listOfCities = <String>['Miami', 'Chicago', 'Florida'];
  var tempList = <Data>[].obs;

  var listOfBranches = <String>['Branch 1', 'Branch 2', 'Branch 3'];
  var skillsList = <String>[
    'Carpenter',
    'Android Developer',
    'Plumber',
    'Flutter Developer',
    'Doctor',
    'Software Developer'
  ];

  var isCitySearchSelected = false.obs;
  var isSkillSearchSelected = false.obs;
  @override
  void onInit() {
    super.onInit();

    // token.value = SharedPrefsManager.getUserToken;

    // fetchFeaturedJobs();
    if (Get.arguments != null) {
      categoryId.value = Get.arguments[0]['categoryId'];

      if (categoryId.value != 0) {
        fetchJobsByCategory(SharedPrefsManager.getUserToken, categoryId.value);
        debugPrint('Jobs By Category Called');
      } else {
        fetchMultipleOffers(SharedPrefsManager.getUserToken);
        debugPrint('All Projects API Called');
      }
    } else {
      debugPrint('Arguments are null');
    }

    fetchRecentOffers(SharedPrefsManager.getUserToken);
  }

  updateList(String value) {
    tempList.value = jobsList
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  fetchMultipleOffers(String token) async {
    var response = await ApiServices.getMulitpleProjects(token);
    if (response!.statusCode == 200) {
      var data = multipleProjectsResponseFromJson(response.body);
      jobsList.value = data.success.data;
      tempList.value = data.success.data;
    } else {
      Constants.showToast('Error');
      print(response.body);
    }
  }

  fetchJobsByCategory(String token, int categoryId) async {
    var response = await ApiServices.getJobsByCategory(token, categoryId);
    if (response!.statusCode == 200) {
      var data = multipleProjectsResponseFromJson(response.body);
      jobsList.value = data.success.data;
      tempList.value = data.success.data;
    } else {
      print(response.body);
      Constants.showToast('Error');
    }
  }

  fetchRecentOffers(String token) async {
    var response = await ApiServices.getJobOffers(token);
    if (response!.statusCode == 200) {
      var data = dashboardOffersResponseFromJson(response.body);
      offersList.value = data.offers;
      // print(jobsList.toJson());
    } else {
      Constants.showToast('Error');
      print(response.body.toString());
    }
  }

  saveProject(int id, int status) async {
    var response = await ApiServices.saveProject(
        SharedPrefsManager.getUserToken, id, status);
    if (response!.statusCode == 200) {
      // print('Error Not Given');
      if (categoryId.value != 0) {
        fetchJobsByCategory(SharedPrefsManager.getUserToken, categoryId.value);
        debugPrint('Jobs By Category Called');
      } else {
        fetchMultipleOffers(SharedPrefsManager.getUserToken);
        debugPrint('All Projects API Called');
      }
    } else {
      print(response.body);
    }
  }

  /* fetchJobsbyCategory(int? id, String getUserToken) async {
    var response = await RestApiServices.getJobsByCategory(id!, getUserToken);
    if (response!.recentJobs != null) {
      jobsList.value = response.recentJobs!;
      isLoaded.value = true;
    } else {
      isLoaded.value = false;
    }
  } */

  // addToArchive(int jobId) {
  //   RestApiServices.addToArchive(SharedPrefsManager.getUserToken, jobId);
  // }

  openFiltersDialog(Size size) {
    showDialog(
      barrierDismissible: false,
      context: Get.overlayContext!,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.all(10),
        insetPadding: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: AppText(
          text: 'Filter Your Search',
          isBold: true,
          textColor: Colors.black,
          textSize: 24,
        ),
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        content: Obx(() {
          return SizedBox(
            width: size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'Search by city and  branch',
                      isBold: true,
                      textColor: Colors.black,
                      textSize: 18,
                    ),
                    IconButton(
                        onPressed: () {
                          isCitySearchSelected.value =
                              !isCitySearchSelected.value;
                        },
                        icon: Icon(
                          isCitySearchSelected.value
                              ? Icons.radio_button_checked_sharp
                              : Icons.radio_button_off_sharp,
                          color: isCitySearchSelected.value
                              ? Constants.secondaryColor
                              : Colors.grey,
                          size: 20,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                isCitySearchSelected.isTrue
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
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
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                                itemCount: listOfCities.length,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            highlightColor: Colors.transparent,
                                            padding: EdgeInsets.zero,
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.radio_button_checked,
                                              color: Constants.secondaryColor,
                                            )),
                                        AppText(
                                          text: listOfCities[index],
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
                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              itemCount: listOfBranches.length,
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
                                            text: listOfBranches[index],
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
                          )
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'Search by skill',
                      isBold: true,
                      textColor: Colors.black,
                      textSize: 18,
                    ),
                    IconButton(
                        onPressed: () {
                          isSkillSearchSelected.value =
                              !isSkillSearchSelected.value;
                        },
                        icon: Icon(
                          isSkillSearchSelected.value
                              ? Icons.radio_button_checked_sharp
                              : Icons.radio_button_off_sharp,
                          color: isSkillSearchSelected.value
                              ? Constants.secondaryColor
                              : Colors.grey,
                          size: 20,
                        ))
                  ],
                ),
                isSkillSearchSelected.isTrue
                    ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: skillsList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 40),
                        itemBuilder: (_, index) {
                          return Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade200),
                            child: AppText(
                                text: skillsList[index],
                                textColor: Colors.black),
                          );
                        })
                    : const SizedBox(),
              ],
            ),
          );
        }),
        actionsPadding: const EdgeInsets.only(bottom: 10),
        actions: [
          TextButton(
              style: ButtonStyle(
                  // elevation: MaterialStateProperty.all(2),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  backgroundColor: MaterialStateProperty.all(
                      Constants.buttonBackgroundColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))),
              onPressed: () {
                Get.back();
              },
              child: AppText(
                text: 'Cancel',
                textSize: 18,
                isBold: true,
              )),
          TextButton(
              style: ButtonStyle(
                  // elevation: MaterialStateProperty.all(2),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  backgroundColor:
                      MaterialStateProperty.all(Constants.primaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))),
              onPressed: () {},
              child: AppText(
                text: 'Apply',
                textSize: 18,
                isBold: true,
                textColor: Colors.white,
              ))
        ],
      ),
    );
    /*   */
  }
}
