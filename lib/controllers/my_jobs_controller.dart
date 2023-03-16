import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/applied_jobs_response.dart'
    as applied_jobs_response;
import 'package:the_staff_hound/api_services/response_models/archive_jobs_response.dart';
import 'package:the_staff_hound/api_services/response_models/assigned_jobs_response.dart'
    as assigned_jobs_response;
import 'package:the_staff_hound/api_services/response_models/jobs_model.dart'
    as jobs_model;
import 'package:the_staff_hound/api_services/response_models/my_jobs_response.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

import '../api_services/main_api_services.dart';

class MyJobsController extends GetxController {
  var appliedJobsList = <applied_jobs_response.Applied>[].obs;
  var tempJobsList = <applied_jobs_response.Applied>[].obs;
  var approvedJobsList = <Job>[].obs;

  var assignedJobs = <assigned_jobs_response.Success>[].obs;
  var rejectedJobsList = <Job>[].obs;

  var savedJobs = <Success>[].obs;
  var onGoingProjects = <jobs_model.Success>[].obs;
  // var waitingJobsList = <Job>[].obs;
  var isLoaded = false.obs;

  var filtersList = <FilterItem>[];

  @override
  void onInit() {
    // getAppliedJobs(token.value);
    getSavedJobs(SharedPrefsManager.getUserToken);
    getAppliedJobs(SharedPrefsManager.getUserToken);
    getAssignedJobs(SharedPrefsManager.getUserToken);
    populateFiltersList();
    super.onInit();
  }

  saveProject(int id, int status) async {
    var response = await ApiServices.saveProject(
        SharedPrefsManager.getUserToken, id, status);
    if (response!.statusCode == 200) {
      getSavedJobs(SharedPrefsManager.getUserToken);
      // print('Error Not Given');
    }
  }

  getJobsByFilters(int index) {
    for (int i = 0; i < filtersList.length; i++) {
      if (i == index) {
        filtersList[i].setIsSelected = true;
      } else {
        filtersList[i].setIsSelected = false;
      }
    }
    switch (index) {
      case 1:
        // tempJobsList.clear();
        tempJobsList.value = appliedJobsList
            .where((success) => success.appliedStatus.contains('pending'))
            .toList();
        break;
      case 2:
        // tempJobsList.clear();
        tempJobsList.value = List.from(appliedJobsList
            .where((success) => success.appliedStatus.contains('approved')));
        // .toList();
        break;
      case 3:
        // tempJobsList.clear();
        tempJobsList.value = appliedJobsList
            .where((success) => success.appliedStatus.contains('rejected'))
            .toList();
        break;
      default:
        // tempJobsList.clear();
        tempJobsList.value = appliedJobsList;
        break;
    }
  }

  populateFiltersList() {
    filtersList.add(FilterItem(filter: 'All Jobs', isSelected: true.obs));
    filtersList.add(FilterItem(filter: 'pending', isSelected: false.obs));
    filtersList.add(FilterItem(filter: 'approved', isSelected: false.obs));
    filtersList.add(FilterItem(filter: 'rejected', isSelected: false.obs));
  }

  getSavedJobs(String token) async {
    var response = await ApiServices.getSavedProjects(token);
    if (response != null && response.statusCode == 200) {
      var data = savedJobsResponseFromJson(response.body);
      savedJobs.value = data.success;
      isLoaded.value = true;
    } else {
      debugPrint(response!.statusCode.toString());
      isLoaded.value = false;
    }
  }

  getAssignedJobs(String token) async {
    var response = await ApiServices.getAssignedJobs(token);
    if (response != null && response.statusCode == 200) {
      var data =
          assigned_jobs_response.assignedJobsResponseFromJson(response.body);
      assignedJobs.value = data.success;
      // isLoaded.value = true;
    } else {
      debugPrint(response!.statusCode.toString());
      // isLoaded.value = false;
    }
  }

  getAppliedJobs(String token) async {
    // tempJobsList.value = [];
    var response = await ApiServices.getAppliedJobs(token);
    if (response != null && response.statusCode == 200) {
      var data =
          applied_jobs_response.appliedJobsResponseFromJson(response.body);
      appliedJobsList.addAll(data.success.applied);
      appliedJobsList.addAll(data.success.offers);
      tempJobsList.value = appliedJobsList;
      // isLoaded.value = true;
    } else {
      debugPrint(response!.statusCode.toString());
      // isLoaded.value = false;
    }
  }

  /*  getAppliedJobs(String token) async {
    var response = await RestApiServices.getAppliedJobs(token);
    if (response != null) {
      isLoaded.value = true;
      appliedJobsList.value = response.appliedJobs!;
      approvedJobsList.value = response.approvedJobs!;
      // waitingJobsList.value = response.waitingJobs!;
      rejectedJobsList.value = response.rejectedJobs!;
      completedJobsList.value = response.completedJobs!;
    } else {
      isLoaded.value = false;
    }
  } */
}

class FilterItem {
  String filter;
  RxBool isSelected;

  FilterItem({required this.filter, required this.isSelected});

  get getFilter => filter;
  get getISSelected => isSelected;

  set setFilter(filter) => this.filter = filter;
  set setIsSelected(isSelected) => this.isSelected.value = isSelected;
}
