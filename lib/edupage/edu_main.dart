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
  String cookieList = '';

  void _headerToCookies(Map<String, String> responseHeaders) {
    List<String> setCookieEntry;
    List<String> wantedCookies = ['PHPSESSID', 'hsid', 'edid'];
    final String? setCookie = responseHeaders['set-cookie'];
    final List<String> cookies =
        (setCookie == null) ? [''] : setCookie.split(',');
    for (var x in cookies) {
      setCookieEntry = x.split('=');
      if (wantedCookies.contains(setCookieEntry[0])) {
        if (headers.keys.contains(setCookieEntry[0])) {
          headers.update(
              setCookieEntry[0], (_) => setCookieEntry[1].split(';')[0]);
        } else {
          headers.addAll({setCookieEntry[0]: setCookieEntry[1].split(';')[0]});
        }
      }
    }
    //Update cookie listu (parameter do requestov)
    cookieList = '';
    headers.forEach(
      (key, value) {
        cookieList =
            cookieList + '$key=$value${(headers.keys.last != key) ? '; ' : ''}';
      },
    );
  }

  void login() async {
    final String requestUrl = 'https://$school.edupage.org/login/index.php';
    final String loginRequestUrl =
        'https://$school.edupage.org/login/edubarLogin.php';
    try {
      final r = await http.get(
        Uri.parse(requestUrl),
        headers: {'Cookie': cookieList},
      );
      _headerToCookies(r.headers);

      final RegExp tokenRegex = RegExp(
        r'(?<=name="csrfauth" value=")(.*)(?=">)',
        caseSensitive: true,
        multiLine: false,
      );

      final csrfToken = tokenRegex.stringMatch(r.body);

      //print('CSRF TOKER : ' + csrfToken.toString());

      final Map<String, String> parameters = {
        "username": username,
        "password": password,
        "csrfauth": csrfToken.toString(),
      };

      final loginResponse = await http.post(
        Uri.parse(loginRequestUrl),
        body: parameters,
        headers: {'Cookie': cookieList},
      );

      _headerToCookies(loginResponse.headers);

      print(loginResponse.statusCode);

      final loggedInResponse = await http.post(
        Uri.parse('https://$school.edupage.org/user/'),
        headers: {'Cookie': cookieList},
      );

      dev.log(loggedInResponse.body);
    } catch (e) {
      print('oops');
      print(e.toString());
    }
  }
}
