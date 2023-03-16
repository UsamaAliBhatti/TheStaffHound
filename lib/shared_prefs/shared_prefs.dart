import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_staff_hound/routes/app_pages.dart';

class SharedPrefsManager {
  static var userNameKey = 'userName';
  static var userIdKey = 'userId';
  static var userEmailKey = 'userEmail';
  static var userTokenKey = 'userToken';
  static var userTypeKey = 'userType';
  static var userPhoneNumberKey = 'userPhoneNumber';
  static var userAddresskey = 'userAddressKey';
  static var userAvailabilitykey = 'userAvailabilityKey';

  static late SharedPreferences prefs;

  static Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<bool> saveUserData(
      String userToken,
      int userId,
      String userName,
      String userEmail,
      int userType,
      String userPhoneNumber,
      String userAddress,
      int isAvailable) async {
    prefs.setInt(userIdKey, userId);
    prefs.setString(userNameKey, userName);
    prefs.setString(userEmailKey, userEmail);
    prefs.setInt(userTypeKey, userType);
    prefs.setString(userPhoneNumberKey, userPhoneNumber);
    prefs.setString(userAddresskey, userAddress);
    prefs.setInt(userAvailabilitykey, isAvailable);
    return prefs.setString(userTokenKey, userToken);
  }

  static Future<bool> update(
      String userName, String userPhoneNumber, String userAddress) {
    prefs.setString(userNameKey, userName);
    prefs.setString(userPhoneNumberKey, userPhoneNumber);

    return prefs.setString(userAddresskey, userAddress);
  }

  static get getUserToken => prefs.getString(userTokenKey);
  static get getUserName => prefs.getString(userNameKey);
  static get getUserId => prefs.getString(userIdKey);
  static get getUserType => prefs.getInt(userTypeKey);
  static get getUserEmail => prefs.getString(userEmailKey);
  static get getUserPhoneNumber => prefs.getString(userPhoneNumberKey);
  static get getUserAddress => prefs.getString(userAddresskey);
  static get getUserAvailabilityStatus => prefs.getInt(userAvailabilitykey);

  static void userLogout() {
    prefs.remove(userTokenKey);
    prefs.remove(userEmailKey);
    prefs.remove(userIdKey);
    prefs.remove(userNameKey);
    prefs.remove(userTypeKey);
    prefs.remove(userPhoneNumberKey);
    prefs.remove(userAddresskey);
    prefs.remove(userAvailabilitykey);
    Get.offNamedUntil(Routes.LOGIN, (route) => false);
  }
}
