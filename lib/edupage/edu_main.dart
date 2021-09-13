// ignore: import_of_legacy_library_into_null_safe
//import 'package:requests/requests.dart';

import 'dart:developer' as dev;

import 'package:http/http.dart' as http;

class EduPage {
  final String school;
  final String username;
  final String password;
  EduPage(this.school, this.username, this.password);

  bool isLoggedIn = false;

  void login() async {
    String requestUrl = 'https://$school.edupage.org/login/index.php';
    try {
      final r = await http.get(Uri.parse(requestUrl));

      // x final r = await Requests.get(requestUrl);
      //dev.log(r.content());

      final tokenRegex = RegExp(r'(?<=name="csrfauth" value=")(.*)(?=">)',
          caseSensitive: true, multiLine: false);
      final csrfToken = tokenRegex.stringMatch(r.body);

      print('CSRF TOKER : ' + csrfToken.toString());

      print(csrfToken.toString().length);

      final String loginRequestUrl =
          'https://$school.edupage.org/login/edubarLogin.php';

      Map<String, String> parameters = {
        "username": username,
        "password": password,
        "csrfauth": csrfToken.toString(),
      };

      final loginResponse =
          await http.post(Uri.parse(requestUrl), body: parameters);

      /*
      print(loginResponse.headers);
      print(loginResponse.headers.entries);
      print(loginResponse.statusCode);
      print(loginResponse.headers['set-cookie']);
      */

      /*
      dev.log(http
          .get('https://spojenaskolanz.edupage.org/login/index.php')
          .toString());
      */

      /*

      final response = await Requests.post(
        loginRequestUrl,
        queryParameters: parameters,
      );

      response.raiseForStatus();

      print(response.content());
      print(parameters);*/

    } catch (e) {
      print('oops');
      print(e.toString());
    }
  }
}
