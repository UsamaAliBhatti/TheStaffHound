import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

import '../api_services/response_models/jobs_response.dart';

class RecentJobController extends GetxController {
  var categoryId = 0.obs;
  var jobsList = <Job>[].obs;
  var isLoaded = false.obs;
  var isEmpty = false;
  var listOfCities = <String>[
    'Lahore',
    'Karachi',
    'Islamabad',
    'Sargodha',
    'Peshawar',
    'Quetta'
  ];

  var listOfBranches = <String>[
    'Branch 1',
    'Branch 2',
    'Branch 3',
    'Branch 4',
    'Branch 5',
    'Branch 6',
    'Branch 7',
    'Branch 8',
  ];

  @override
  void onInit() {
    super.onInit();
    print(Get.arguments['more']);
    if (Get.arguments['more'] == true) {
      fetchAllJobs(SharedPrefsManager.getUserToken);
    } else {
      categoryId.value = Get.arguments['categoryId'];

      fetchJobsbyCategory(categoryId.value, SharedPrefsManager.getUserToken);

      print(categoryId);
    }
  }

  fetchAllJobs(String token) async {
    var response = await RestApiServices.getAllJobs(token);
    if (response!.recentJobs != null) {
      jobsList.value = response.recentJobs!;
      print(jobsList.toJson());
      isLoaded.value = true;
    } else {
      isLoaded.value = false;
    }
  }

  fetchJobsbyCategory(int? id, String getUserToken) async {
    var response = await RestApiServices.getJobsByCategory(id!, getUserToken);
    if (response!.recentJobs != null) {
      jobsList.value = response.recentJobs!;
      isLoaded.value = true;
    } else {
      isLoaded.value = false;
    }
  }

  addToArchive(int jobId) {
    RestApiServices.addToArchive(SharedPrefsManager.getUserToken, jobId);
  }

  openFiltersDialog(Size size) {
    showDialog(
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
          text: 'Filters',
          textSize: 20,
          isBold: true,
        ),
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        content: SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: 'Search by city',
                  isBold: true,
                  textColor: Colors.black,
                  textSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              /*   MultipleSearchSelection(
                  items: listOfCities,
                  maximumShowItemsHeight: 100,
                  onPickedChange: (items) {},
                  itemsVisibility: ShowedItemsVisibility.alwaysOn,
                  fuzzySearch: FuzzySearch.jaro,
                  pickedItemBuilder: (String pickedItem) {
                    return AppText(text: pickedItem);
                  },
                  fieldToCheck: (String check) {
                    return check;
                  },
                  itemBuilder: (String item) {
                    return AppText(text: item);
                  }), */
              /*   MultipleSearchSelection(
    items: listOfCities, // List<String>
    fuzzySearch: FuzzySearch.jaro,
    title: Text(
        'Countries',
        style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        ),
    ),
    
   
    showedItemsBackgroundColor: Colors.grey.withOpacity(0.1),
    showShowedItemsScrollbar: false,
   
    onTapShowedItem: () {},
    onPickedChange: (items) {},
    onItemAdded: (item) {
        print('$item added to picked items');
    },
    onItemRemoved: (item) {
        print('$item removed from picked items');
    },
) */
              /* Wrap(
                  children: listOfCities
                      .map((city) => Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade200,
                                border:
                                    Border.all(color: Colors.grey.shade200)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.030,
                                vertical: size.height * 0.0045),
                            child: AppText(
                              text: city,
                              textColor: Colors.black,
                            ),
                          ))
                      .toList()), */

              SizedBox(
                height: 40,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listOfCities.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: /*  resumeController
                                                .languagesList[index]
                                                .isSelected!
                                                .value
                                            ? Colors.green.shade300
                                            :  */
                                Colors.grey.shade200),
                        child: AppText(
                          text: /*  resumeController
                                          .languagesList[index].getLanguageName! */
                              listOfCities[index],
                          textColor: Colors.black,
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
                height: 40,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listOfBranches.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: /*  resumeController
                                                .languagesList[index]
                                                .isSelected!
                                                .value
                                            ? Colors.green.shade300
                                            :  */
                                Colors.grey.shade200),
                        child: AppText(
                          text: /*  resumeController
                                          .languagesList[index].getLanguageName! */
                              listOfBranches[index],
                          textColor: Colors.black,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.green.shade100),
              ),
              onPressed: () {},
              child: AppText(
                text: 'Cancel',
                textSize: 20,
                isBold: true,
              )),
          TextButton(
              onPressed: () {},
              child: AppText(
                text: 'Apply',
                textSize: 20,
                isBold: true,
              ))
        ],
      ),
    );
  }
}
