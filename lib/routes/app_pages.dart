import 'package:get/get.dart';
import 'package:the_staff_hound/api_services/response_models/job_detail_response.dart';
import 'package:the_staff_hound/controllers/recent_job_controller.dart';
import 'package:the_staff_hound/views/branches_screen.dart';
import 'package:the_staff_hound/views/create_resume_screen.dart';
import 'package:the_staff_hound/views/dashboard_screen.dart';
import 'package:the_staff_hound/views/email_otp_screen.dart';
import 'package:the_staff_hound/views/forgot_password_screen.dart';
import 'package:the_staff_hound/views/job_details_screen.dart';
import 'package:the_staff_hound/views/login_screen.dart';
import 'package:the_staff_hound/views/my_jobs_screen.dart';
import 'package:the_staff_hound/views/phone_otp_screen.dart';
import 'package:the_staff_hound/views/profile_screen.dart';
import 'package:the_staff_hound/views/recent_jobs_screen.dart';
import 'package:the_staff_hound/views/reset_password_screen.dart';
import 'package:the_staff_hound/views/resume_view.dart';
import 'package:the_staff_hound/views/signup_screen.dart';
import 'package:the_staff_hound/views/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: _Paths.BRANCHES, page: () => BranchesActivity()),
    GetPage(name: _Paths.DASHBOARD, page: () => DashboardActivity()),
    GetPage(name: _Paths.CREATE_RESUME, page: () => CreateResumeActivity()),
    GetPage(name: _Paths.VIEW_RESUME, page: () => ResumeViewActivity()),
    GetPage(name: _Paths.RECENT_JOBS, page: () => const RecentJobs()),
    GetPage(name: _Paths.EMAIL_OTP, page: () => EmailOTPActivity()),
    GetPage(name: _Paths.FORGOT_PASSWORD, page: () => ForgotPasswordActivity()),
    GetPage(name: _Paths.JOB_DETAILS, page: () => JobDetailsActivity()),
    GetPage(name: _Paths.SIGN_UP, page: () => SignUpActivity()),
    GetPage(name: _Paths.LOGIN, page: () => LoginActivity()),
    GetPage(name: _Paths.NOTIFICATIONS, page: () => ForgotPasswordActivity()),
    GetPage(name: _Paths.PROFILE, page: () => ProfileActivity()),
    GetPage(name: _Paths.RESET_PASSWORD, page: () => const ResetPasswordActivity()),
    GetPage(name: _Paths.SPLASH, page: () => SplashScreen()),
    GetPage(name: _Paths.MY_JOBS, page: () => MyJobsActivity()),
    GetPage(name: _Paths.PHONE_OTP, page: () => PhoneOTPActivity()),
  ];
}
