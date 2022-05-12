import 'package:get_storage/get_storage.dart';

class UserSharedPrefs {
  static final _loginDataBox = GetStorage('TheStaffHoundPrefs');

  static  saveUserData(String userToken, String userName, String userEmail,
      String userPhoneNumber) {
    _loginDataBox.write('userToken', userToken);
    _loginDataBox.write('userName', userName);
    _loginDataBox.write('userEmail', userEmail);
    _loginDataBox.write('userPhoneNumber', userPhoneNumber);
  }

  static getUserName() async {
    return await _loginDataBox.read('userName');
  }

  static getUserEmail() async {
    return await _loginDataBox.read('userEmail');
  }

  static getUserPhoneNumber() async {
    return await _loginDataBox.read('userPhoneNumber');
  }

  static getUserToken() async {
    return await _loginDataBox.read('userToken');
  }

  static userLogout() async {
    await _loginDataBox.erase();
  }
}
