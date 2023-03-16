// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const DASHBOARD = _Paths.DASHBOARD;
  static const SPLASH = _Paths.SPLASH;
  static const SIGN_UP = _Paths.SIGN_UP;
  static const LOGIN = _Paths.LOGIN;
  static const BRANCHES = _Paths.BRANCHES;
  static const CREATE_RESUME = _Paths.CREATE_RESUME;
  static const EMAIL_OTP = _Paths.EMAIL_OTP;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const JOB_DETAILS = _Paths.JOB_DETAILS;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const RECENT_JOBS = _Paths.RECENT_JOBS;
  static const PHONE_OTP = _Paths.PHONE_OTP;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
  static const VIEW_RESUME = _Paths.VIEW_RESUME;
  static const PROFILE = _Paths.PROFILE;
  static const MY_JOBS = _Paths.MY_JOBS;
  static const SECOND_NOTIFICATION = _Paths.SECOND_NOTIFICATION;
  static const ARCHIVED_JOBS = _Paths.ARCHIVED_JOBS;
  static const NOTIFICATION_DETAILS = _Paths.NOTIFICATION_DETAILS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const DASHBOARD = '/dashboard';
  static const BRANCHES = '/branches';
  static const CREATE_RESUME = '/create_resume';
  static const EMAIL_OTP = '/email_otp';
  static const SIGN_UP = '/sign_up';
  static const LOGIN = '/login';
  static const FORGOT_PASSWORD = '/forgot_password';
  static const JOB_DETAILS = '/job_details';
  static const NOTIFICATIONS = '/notifications';
  static const RECENT_JOBS = '/recent_jobs';
  static const PHONE_OTP = '/phone_otp';
  static const RESET_PASSWORD = '/reset_password';
  static const VIEW_RESUME = '/view_resume';
  static const PROFILE = '/profile';
  static const MY_JOBS = '/my_jobs';
  static const SECOND_NOTIFICATION = '/second_notification';
  static const ARCHIVED_JOBS = '/archived_jobs';
  static const NOTIFICATION_DETAILS = '/notification_details';
}