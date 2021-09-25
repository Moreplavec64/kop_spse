import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kop_spse/utils/edu_get_utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EduPageProvider with ChangeNotifier {
  final String _school = 'spojenaskolanz';
  late final String? _username;
  late final String? _password;
  // final EduPage _eduPage = EduPage('spojenaskolanz');
  bool _isLogin = false;

  //headers = {cookie name = cookie value,...}
  //cookie list = hodnoty pre http header
  final Map<String, String> headers = {};
  String cookieList = '';

  Map<String, dynamic> _parsedEdupageData = Map();

  set setIsLogin(bool x) => _isLogin = x;
  get getIsLogin => _isLogin;

  void setAuthValues(String username, String password) {
    _password = password;
    _username = username;
  }

  void login() async {
    final String requestUrl = 'https://$_school.edupage.org/login/index.php';
    final String loginRequestUrl =
        'https://$_school.edupage.org/login/edubarLogin.php';

    try {
      final r = await http.get(
        Uri.parse(requestUrl),
        headers: {'Cookie': cookieList},
      );
      _updateCookies(r.headers);

      final RegExp tokenRegex = RegExp(
        r'(?<=name="csrfauth" value=")(.*)(?=">)',
        caseSensitive: true,
        multiLine: false,
      );
      final String? csrfToken = tokenRegex.stringMatch(r.body);

      final Map<String, String> parameters = {
        "username": _username!,
        "password": _password!,
        "csrfauth": csrfToken.toString(),
      };

      final loginResponse = await http.post(
        Uri.parse(loginRequestUrl),
        body: parameters,
        headers: {'Cookie': cookieList},
      );

      _updateCookies(loginResponse.headers);

      print(loginResponse.statusCode);

      final loggedInResponse = await http.post(
        Uri.parse('https://$_school.edupage.org/user/'),
        headers: {'Cookie': cookieList},
      );

      //dev.log(loggedInResponse.body);
      _parseEduJsonData(data: loggedInResponse.body);
    } catch (e) {
      print('oops');
      print(e.toString());
    }
  }

  void _updateCookies(Map<String, String> responseHeaders) {
    List<String> setCookieEntry;
    List<String> wantedCookies = ['PHPSESSID', 'hsid', 'edid'];
    final String? setCookie = responseHeaders['set-cookie'];
    //ak netreba nastavit ziadne cookies, skip
    if (setCookie == null) return;
    final List<String> cookies = setCookie.split(',');
    //loop cez vsetky setCookies entries, pridaj do cookies ak treba
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

  void _parseEduJsonData({String data = ''}) async {
    //data = reponse header na parsnutie, ak sa nezada, nacita sa test reponse
    //TODO errors
    if (data == '') {
      data = await rootBundle
          .loadString('assets\\test_reponse\\edu_response.html');
    }
    String json;
    json = data.split("\$j(document).ready(function() {")[1];
    json = json.split(");")[0];
    json.replaceAll('\t', '');
    json = json.split("userhome(")[1];
    json.replaceAll('\n', '');
    json.replaceAll('\r', '');

    _parsedEdupageData = convert.json.decode(json) as Map<String, dynamic>;
  }
}
