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
  final Map<String, String> headers = {};

  Map<String, String> headerToCookies(Map<String, String> responseHeaders) {
    final Map<String, String> headers = {};
    List<String> c;
    String cookieList = '';
    List<String> wantedCookies = ['PHPSESSID', 'hsid', 'edid'];
    final String? setCookie = responseHeaders['set-cookie'];
    final List<String> cookies =
        (setCookie == null) ? [''] : setCookie.split(',');
    for (var x in cookies) {
      c = x.split('=');
      if (wantedCookies.contains(c[0])) {
        if (headers.keys.contains(c[0])) {
          headers.update(c[0], (_) => c[1].split(';')[0]);
        } else {
          headers.addAll({c[0]: c[1].split(';')[0]});
        }
      }
    }
    headers.forEach((key, value) {
      cookieList = cookieList + '$key=$value; ';
    });

    print(cookieList.substring(0, cookieList.lastIndexOf(';')));

    return headers;
  }

  void login() async {
    String requestUrl = 'https://$school.edupage.org/login/index.php';
    try {
      final r = await http.get(Uri.parse(requestUrl));

      print(r.headers['set-cookie']);
      headerToCookies(r.headers);

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
          await http.post(Uri.parse(loginRequestUrl), body: parameters);

      print(loginResponse.statusCode);

      /*
      print(loginResponse.headers);
      print(loginResponse.headers.entries);
      print(loginResponse.statusCode);
      */

      final loggedInResponse = await http.post(
          Uri.parse('https://$school.edupage.org/user/'),
          headers: headerToCookies(loginResponse.headers));

      print(headerToCookies(loginResponse.headers));
      print(loggedInResponse.headers['location']);

      print(loggedInResponse.body);
      print(loggedInResponse.headers);

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
