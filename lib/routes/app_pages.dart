import 'package:get/get.dart';
import 'package:the_staff_hound/views/archived_jobs_screen.dart';
import 'package:the_staff_hound/views/branches_screen.dart';
import 'package:the_staff_hound/views/create_resume_screen.dart';
import 'package:the_staff_hound/views/dashboard_screen.dart';
import 'package:the_staff_hound/views/email_otp_screen.dart';
import 'package:the_staff_hound/views/forgot_password_screen.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';
import 'package:the_staff_hound/views/login_screen.dart';
import 'package:the_staff_hound/views/my_jobs_screen.dart';
import 'package:the_staff_hound/views/notification_screen.dart';
import 'package:the_staff_hound/views/phone_otp_screen.dart';
import 'package:the_staff_hound/views/profile_screen.dart';
import 'package:the_staff_hound/views/recent_jobs_screen.dart';
import 'package:the_staff_hound/views/reset_password_screen.dart';
import 'package:the_staff_hound/views/resume_view.dart';
import 'package:the_staff_hound/views/second_notification_screen.dart';
import 'package:the_staff_hound/views/signup_screen.dart';
import 'package:the_staff_hound/views/splash_screen.dart';

import '../views/notification_detail_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: _Paths.BRANCHES, page: () => BranchesActivity()),
    GetPage(name: _Paths.DASHBOARD, page: () => DashboardActivity()),
    GetPage(name: _Paths.CREATE_RESUME, page: () => CreateResumeActivity()),
    GetPage(name: _Paths.VIEW_RESUME, page: () => ResumeViewActivity()),
    GetPage(name: _Paths.RECENT_JOBS, page: () => RecentJobs()),
    GetPage(name: _Paths.EMAIL_OTP, page: () => EmailOTPActivity()),
    GetPage(name: _Paths.FORGOT_PASSWORD, page: () => ForgotPasswordActivity()),
    GetPage(name: _Paths.JOB_DETAILS, page: () => JobDetailsActivity()),
    GetPage(name: _Paths.SIGN_UP, page: () => SignUpActivity()),
    GetPage(name: _Paths.LOGIN, page: () => LoginActivity()),
    GetPage(name: _Paths.NOTIFICATIONS, page: () => NotificationsActivity()),
    GetPage(name: _Paths.PROFILE, page: () => ProfileActivity()),
    GetPage(name: _Paths.RESET_PASSWORD, page: () => ResetPasswordActivity()),
    GetPage(name: _Paths.SPLASH, page: () => const SplashScreen()),
    GetPage(name: _Paths.MY_JOBS, page: () => MyJobsActivity()),
    GetPage(name: _Paths.PHONE_OTP, page: () => PhoneOTPActivity()),
    GetPage(
        name: _Paths.SECOND_NOTIFICATION,
        page: () => SecondNotificationScreen()),
    GetPage(name: _Paths.ARCHIVED_JOBS, page: () => ArchivedJobsActivity()),
    GetPage(
        name: _Paths.NOTIFICATION_DETAILS,
        page: () => NotificationDetailScreen()),
  ];
}
