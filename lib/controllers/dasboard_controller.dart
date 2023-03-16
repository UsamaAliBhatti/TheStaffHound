import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/main_api_services.dart';
import 'package:the_staff_hound/api_services/response_models/categories_response.dart';
import 'package:the_staff_hound/api_services/response_models/dashboard_offers_response.dart';
import 'package:the_staff_hound/api_services/response_models/dashboard_response.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/models/nav_model.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class DashBoardController extends GetxController {
  var jobCategoryList = <Success>[].obs;
  // var featuredJobsList = <Job>[].obs;
  var jobsList = <Offer>[].obs;
  var navModelList = <NavModel>[].obs;
  // var testJobsList = <GeneralJobModel>[].obs;

  var selectedIndex = 0.obs;
  var isAvailable = false.obs;

  var savedJobs = 0.obs;
  var approvedJobs = 0.obs;
  // DashboardResponse dashboardModel = DashboardResponse();

  var userName = ''.obs;
  var userEmail = ''.obs;
  // var token = ''.obs;

  var isLoaded = false.obs;
  var userAvailailityStatus = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    getUserData();
    // token.value = SharedPrefsManager.getUserToken;
    // print(await FirebaseMessaging.instance.getToken());
    // fetchFeaturedJobs();
    fetchDrawerMenu();
    fetchAllData();
  }

  fetchAllData() {
    fetchCategories(SharedPrefsManager.getUserToken);
    fetchDashboardData(SharedPrefsManager.getUserToken);
    fetchSavedJobsData(SharedPrefsManager.getUserToken);
  }

  getUserData() {
    // userAvailailityStatus.value = SharedPrefsManager.getUserAvailabilityStatus;
    userName.value = SharedPrefsManager.getUserName;
    userEmail.value = SharedPrefsManager.getUserEmail;
    if (userAvailailityStatus.value == 0) {
      isAvailable.value = true;
    } else {
      isAvailable.value = false;
    }
  }

  saveProject(int id, int status) async {
    var response = await ApiServices.saveProject(
        SharedPrefsManager.getUserToken, id, status);
    if (response!.statusCode == 200) {
      // print('Error Not Given');
      fetchDashboardData(SharedPrefsManager.getUserToken);
    } else {
      print(response.body);
    }
  }

  fetchSavedJobsData(String token) async {
    var response = await ApiServices.getDashboardData(token);
    if (response != null && response.statusCode == 200) {
      var data = dashboardResponseFromJson(response.body);
      savedJobs.value = data.savedJobCounter;
      approvedJobs.value = data.assignedJobCounter;
    } else {
      Constants.showToast('Error Occurred. Please try again later');
    }
  }

  fetchCategories(String token) async {
    var response = await ApiServices.getCategories(token);
    if (response != null && response.statusCode == 200) {
      var data = categoriesResponseFromJson(response.body);
      jobCategoryList.value = data.success;
    } else {
      Constants.showToast('Error Occurred. Please try again later');
    }
  }

  fetchDashboardData(String token) async {
    var response = await ApiServices.getJobOffers(token);
    if (response!.statusCode == 200) {
      var data = dashboardOffersResponseFromJson(response.body);
      jobsList.value = data.offers;
      print(jobsList.toJson());
    } else {
      Constants.showToast('Error');
      print(response.body.toString());
    }
    /* var json = await RestApiServices.getDashboardData(token);
    if (json != null) {
      isLoaded.value = true;
      dashboardModel = dashboardResponseFromJson(json);

      savedJobs.value = dashboardModel.jobs!;
      approvedJobs.value = dashboardModel.interview!;
      jobCategoryList.value = dashboardModel.categories!;
      // featuredJobsList.value = dashboardModel.featuredJobs!;
      recentJobsList.value = dashboardModel.recentJobs!;
    } else {
      isLoaded.value = false;
    } */
  }

  fetchDrawerMenu() {
/*     navModelList.add(NavModel(
        navName: 'My Account',
        navIcon: Constants.navProfile,
        isNavSelected: false.obs)); */
    navModelList.add(NavModel(
        navName: 'Job Board',
        navIcon: Constants.navMyJobsIcon,
        isNavSelected: false.obs));

    navModelList.add(NavModel(
        navName: 'Search Jobs',
        navIcon: Constants.navSearchJobIcon,
        isNavSelected: false.obs));

    /*  navModelList.add(NavModel(
        navName: 'Saved Jobs',
        navIcon: Constants.icFavorite,
        isNavSelected: false.obs));
 */
    navModelList.add(NavModel(
        navName: 'My Branches',
        navIcon: Constants.icBranch,
        isNavSelected: false.obs));

    navModelList.add(NavModel(
        navName: 'My Resume',
        navIcon: Constants.navResume,
        isNavSelected: false.obs));

    /*  navModelList.add(NavModel(
        navName: 'Change Password',
        navIcon: Constants.passwordIcon,
        isNavSelected: false.obs)); */
  }

  resetNav() {
    for (var element in navModelList) {
      element.setIsSelected = false;
    }
  }

  // addToArchive(int jobId) {
  //   RestApiServices.addToArchive(token.value, jobId);
  // }

  /*  notInterestedInJob(int jobId) {
    RestApiServices.addNotInterested(token.value, jobId);
  } */
}
