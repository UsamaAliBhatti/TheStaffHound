import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:the_staff_hound/api_services/response_models/dashboard_response.dart';
import 'package:the_staff_hound/api_services/rest_api_services.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/models/general_jobs_model.dart';
import 'package:the_staff_hound/models/nav_model.dart';
import 'package:the_staff_hound/shared_prefs/shared_prefs.dart';

class DashBoardController extends GetxController {
  var jobCategoryList = <Category>[].obs;
  // var featuredJobsList = <Job>[].obs;
  var recentJobsList = <Job>[].obs;
  var navModelList = <NavModel>[].obs;
  var testJobsList = <GeneralJobModel>[].obs;

  var selectedIndex = 0.obs;
  var isAvailable = false.obs;

  var savedJobs = 0.obs;
  var approvedJobs = 0.obs;
  DashboardResponse dashboardModel = DashboardResponse();

  var userName = ''.obs;
  var userEmail = ''.obs;
  var token = ''.obs;

  var isLoaded = false.obs;

  var focusedDay = DateTime.now().obs;
  var selectedDay = Rxn<DateTime>();
  var rangeStart = Rxn<DateTime>();
  var rangeEnd = Rxn<DateTime>();
  final rangeSelectionMode = RangeSelectionMode.toggledOn.obs;
  @override
  void onInit() {
    super.onInit();

    token.value = SharedPrefsManager.getUserToken;

    // fetchFeaturedJobs();
    fetchDrawerMenu();
    fetchDashboardData(SharedPrefsManager.getUserToken.toString());
  }

  fetchDashboardData(String token) async {
    userName.value = SharedPrefsManager.getUserName;
    userEmail.value = SharedPrefsManager.getUserEmail;
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

    navModelList.add(NavModel(
        navName: 'Saved Jobs',
        navIcon: Constants.icFavorite,
        isNavSelected: false.obs));

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

  addToArchive(int jobId) {
    RestApiServices.addToArchive(token.value, jobId);
  }

  /*  notInterestedInJob(int jobId) {
    RestApiServices.addNotInterested(token.value, jobId);
  } */
}
