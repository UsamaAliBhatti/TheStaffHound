import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class RestApiServices {
  static const _baseUrl = 'https://api.thestaffhound.com/api/';

  static userLogin(userEmail, userPassword) async {
    String token = '';
    try {
      FirebaseMessaging.instance.getToken().then((newToken) {
        token = newToken!;
      });
      var client = http.Client();

      var uri = Uri.parse(_baseUrl + 'login');

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

  static userSignUp(userEmail, userPassword) async {
    try {
      var client = http.Client();

      var uri = Uri.parse(_baseUrl + 'login');

      http.Response response = await client.post(uri, body: {
        'email': userEmail,
        'password': userPassword,
        'password_confirmation': userPassword
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
}
