import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:the_staff_hound/api_services/response_models/branches_model.dart';

class RestApiServices {
  static const _baseUrl = 'https://api.thestaffhound.com/api/';

  static userLogin(userEmail, userPassword) async {
    String token = '';
    try {
      FirebaseMessaging.instance.getToken().then((newToken) {
        token = newToken!;
      });
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}login');

      http.Response response = await client.post(uri, body: {
        'email': userEmail,
        'password': userPassword,
        'password_confirmation': userPassword,
        'device_token': token,
      });

      print(token);
      if (response.statusCode == 200) {
        var json = response.body;
        print(json.toString());
      } else {
        print(response.body.toString());

        print('Login Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static userSignUp(userName, userEmail, userPassword, userType, branchId,
      deviceToken) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('${_baseUrl}newRegister');

      http.Response response = await client.post(uri, body: {
        'name': userName,
        'email': userEmail,
        'password': userPassword,
        'password_confirmation': userPassword,
        'type': userType,
        'branch_id': branchId,
        'device_token': deviceToken,
      });

      if (response.statusCode == 200) {
        var json = response.body;
        print(json.toString());
      } else {
        print(response.body.toString());
        print('Login Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

//method to get all branches from server
  static Future<dynamic> getAllBranches() async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${_baseUrl}getbranchesforseeker');
      http.Response response = await client.get(uri);
      if (response.statusCode == 200) {
        print('Branches Loaded Successfully...');
        return branchesFromJson(response.body);
      } else {
        print('Branch Error: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}
