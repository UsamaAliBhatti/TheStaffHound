import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Constants {
  //base url for api's
  static const baseUrl = 'https://pensive-fermi.157-175-231-72.plesk.page/api/';
  // Custom Colors
  static Color backgroundColor = Colors.grey.shade100;
  static const Color secondaryColor = Color(0xfff4bd05);
  static const Color primaryColor = Color(0xff12727f);
  static const Color buttonBackgroundColor = Color(0xffECF0F3);
  static const Color textHintColor = Color(0xFFA1A3A4);

  // Images
  static const String splashLogo = "assets/images/staff_hound_logo.png";
  static const String passwordIcon = "assets/images/password_icon.png";
  static const String googleIcon = "assets/images/google_icon.png";
  static const String facebookIcon = "assets/images/facebook_icon.png";
  static const String forgotPasswordImage = "assets/images/forgot_pass_img.png";
  static const String otpScreenImage = "assets/images/otp_screen_img.png";
  static const String placeholderUserImage = "assets/images/placeholder.png";
  static const String notificationImage =
      "assets/images/ic_notification_img.png";
  static const String applicationAcceptImage =
      "assets/images/ic_application_accept_img.png";
  static const String applicationRejectImage =
      "assets/images/ic_application_reject_img.png";
  static const String resetPasswordImage =
      "assets/images/reset_password_img.png";
  static const String successPasswordImage =
      "assets/images/success_password_image.png";

  static const jobImg = "assets/images/job_img.png";
  static const backArrow = "assets/images/back_arrow.png";
  static const navProfile = "assets/images/ic_nav_profile.png";
  static const navMyJobsIcon = "assets/images/ic_nav_my_job.png";
  static const navResume = "assets/images/ic_nav_resume_img.png";
  static const navSearchJobIcon = "assets/images/ic_nav_search_job.png";
  static const placeholderImage = "assets/images/placeholder.jpg";
  static const oopsImage = "assets/images/oops.png";

  // Icons

  static const icPhone = "assets/images/ic_phone.png";
  static const icHomeAddress = "assets/images/ic_home_address.png";
  static const icEmail = "assets/images/ic_email.png";
  static const icArchived = "assets/images/ic_archived_img.png";
  static const icBranch = "assets/images/ic_branch.png";
  static const icFavorite = "assets/images/ic_favorite.png";
  static const icFilter = "assets/images/ic_filter.png";
  static const successImg = "assets/images/success.jpg";
  static const failedImg = "assets/images/failed.png";

  //Methods
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Constants.secondaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String convertDate(String date) {
    return DateFormat.MMMEd().format(DateTime.parse(date));
  }

  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }
}
