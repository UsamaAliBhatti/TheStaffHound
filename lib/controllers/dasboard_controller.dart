import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/models/general_jobs_model.dart';
import 'package:the_staff_hound/models/job_categories_model.dart';
import 'package:the_staff_hound/models/nav_model.dart';

class DashBoardController extends GetxController {
  var jobCategoryList = <JobCategoriesModel>[].obs;
  var featuredJobsList = <GeneralJobModel>[].obs;
  var recentJobsList = <GeneralJobModel>[].obs;
  var navModelList = <NavModel>[].obs;

  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobCategories();
    fetchFeaturedJobs();
    fetchDrawerMenu();
  }

  fetchDrawerMenu() {
    navModelList.add(NavModel('Profile', Constants.navProfile));
    navModelList
        .add(NavModel('Searched Jobs', Constants.navSearchJobIcon));
    navModelList
        .add(NavModel('Change Password', Constants.passwordIcon));
    navModelList.add(NavModel('My Jobs', Constants.navMyJobsIcon));
  }

  void fetchJobCategories() {
    var jCList = [
      JobCategoriesModel(jobCategoryName: 'Designer'),
      JobCategoriesModel(jobCategoryName: 'Manager'),
      JobCategoriesModel(jobCategoryName: 'Programmer'),
      JobCategoriesModel(jobCategoryName: 'UI / UX Designer'),
      JobCategoriesModel(jobCategoryName: 'Photographer'),
      JobCategoriesModel(jobCategoryName: 'Tester'),
    ];
    jobCategoryList.value = jCList;
  }

  void fetchFeaturedJobs() {
    var fJList = [
      GeneralJobModel(
          companyLogo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz88SO-zK_6Gn9TVa1yzb46f3UZvMJSRI5vg&usqp=CAU',
          companyName: 'NetSol Pvt. Ltd.',
          jobLocation: 'Lahore, Pakistan',
          jobTitle: 'Software Engineer',
          jobSalaryRange: '\$1000 - \$2000',
          jobDescription:
              'We are Looking For Software Engineer with minimum experience of 3 years',
          salaryRangeType: 'monthly',
          jobType: 'FULLTIME',
          jobCategory: 'CONTRACT',
          jobRequirements: [
            'Minimum 3 Years of Experience in relative field',
            'Must have Strong OOP Knowledge',
            'Well acknowledged about software architectures'
          ],
          requiredSkillsList: [
            "strong communication skills",
            "java script",
            "strong oop knowledge",
            "fast learner",
            "strong decision maker"
          ]),
      GeneralJobModel(
          companyLogo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz88SO-zK_6Gn9TVa1yzb46f3UZvMJSRI5vg&usqp=CAU',
          companyName: 'Systems Ltd.',
          jobLocation: 'DHA Lahore, Pakistan',
          jobTitle: 'Flutter Developer',
          jobSalaryRange: '\$1500 - \$3000',
          jobDescription:
              'We are Looking For Software Engineer with minimum experience of 3 years',
          salaryRangeType: 'monthly',
          jobType: 'FULLTIME',
          jobCategory: 'CONTRACT',
          jobRequirements: [
            'Minimum 3 Years of Experience in relative field',
            'Must have Strong OOP Knowledge',
            'Well acknowledged about software architectures'
          ],
          requiredSkillsList: [
            "strong communication skills",
            "java script",
            "strong oop knowledge",
            "fast learner",
            "strong decision maker"
          ]),
      GeneralJobModel(
          companyLogo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz88SO-zK_6Gn9TVa1yzb46f3UZvMJSRI5vg&usqp=CAU',
          companyName: 'Tek X Solutions',
          jobLocation: 'Lahore, Pakistan',
          jobTitle: 'Android Developer',
          jobSalaryRange: '\$1500 - \$3500',
          jobDescription:
              'We are Looking For Software Engineer with minimum experience of 3 years',
          salaryRangeType: 'monthly',
          jobType: 'FULLTIME',
          jobCategory: 'CONTRACT',
          jobRequirements: [
            'Minimum 3 Years of Experience in relative field',
            'Must have Strong OOP Knowledge',
            'Well acknowledged about software architectures'
          ],
          requiredSkillsList: [
            "strong communication skills",
            "java script",
            "strong oop knowledge",
            "fast learner",
            "strong decision maker"
          ]),
      GeneralJobModel(
          companyLogo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz88SO-zK_6Gn9TVa1yzb46f3UZvMJSRI5vg&usqp=CAU',
          companyName: 'Hazel Mobile',
          jobLocation: 'Bahria Town, Lahore, Pakistan',
          jobTitle: 'Angular Developer',
          jobSalaryRange: '\$1000 - \$2500',
          jobDescription:
              'We are Looking For Software Engineer with minimum experience of 3 years',
          salaryRangeType: 'monthly',
          jobType: 'FULLTIME',
          jobCategory: 'PERMANENT',
          jobRequirements: [
            'Minimum 3 Years of Experience in relative field',
            'Must have Strong OOP Knowledge',
            'Well acknowledged about software architectures'
          ],
          requiredSkillsList: [
            "strong communication skills",
            "java script",
            "strong oop knowledge",
            "fast learner",
            "strong decision maker"
          ]),
      GeneralJobModel(
          companyLogo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz88SO-zK_6Gn9TVa1yzb46f3UZvMJSRI5vg&usqp=CAU',
          companyName: 'Optimus Fox',
          jobLocation: 'Lahore, Pakistan',
          jobTitle: 'React Developer',
          jobSalaryRange: '\$2000 - \$5000',
          jobDescription:
              'We are Looking For Software Engineer with minimum experience of 3 years',
          salaryRangeType: 'monthly',
          jobType: 'FULLTIME',
          jobCategory: 'PERMANENT',
          jobRequirements: [
            'Minimum 3 Years of Experience in relative field',
            'Must have Strong OOP Knowledge',
            'Well acknowledged about software architectures'
          ],
          requiredSkillsList: [
            "strong communication skills",
            "java script",
            "strong oop knowledge",
            "fast learner",
            "strong decision maker"
          ]),
    ];

    featuredJobsList.value = fJList;
    recentJobsList.value = fJList;
  }
}

// ['Designer', 'Manager', 'Programmer', 'UX / UI Designer', 'Photographer','Tester'].
