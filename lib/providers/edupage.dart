import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'dart:developer' as dev;

import 'package:kop_spse/models/plan.dart';
import 'package:kop_spse/utils/edu_get_utils.dart';

enum LoginStatus {
  LoggedOut,
  LoggingIn,
  LoggedIn,
  LoginFailed,
}

class EduPageProvider with ChangeNotifier {
  final String _school = 'spojenaskolanz';
  late String _username;
  late String _password;

  LoginStatus _isLogin = LoginStatus.LoggedOut;
  set setLoginStatus(LoginStatus x) {
    _isLogin = x;
    notifyListeners();
  }

  LoginStatus get getEduLoginStatus => _isLogin;

  Map<String, dynamic> _parsedEdupageData = Map();
  Map<String, dynamic> get getEduData => _parsedEdupageData;

  late List<LessonPlan> _dnesnyRozvrh;
  List<LessonPlan> get getDnesnyRozvrh =>
      _dnesnyRozvrh.isNotEmpty ? _dnesnyRozvrh : [];

  DateTime _date = DateTime.now();
  late LessonPlan aktualnaHodina;
  late Duration zostavajuciCas;
  bool isPrestavka = false;

  void updateAktualne() {
    _date = DateTime.now();
    //TODO rozdelit updatovanie ak netreba
    aktualnaHodina = getDnesnyRozvrh.firstWhere(
      (e) {
        isPrestavka = false;
        return _date.isAfter(e.startTime) && _date.isBefore(e.endTime);
      },
      orElse: () {
        //ak sa nenajde hodina, je prestavka
        isPrestavka = true;
        print(zostavajuciCas);
        return getDnesnyRozvrh.firstWhere((e) => e.startTime.isAfter(_date));
      },
    );
    //ak je prestavka, cas zostavajuci do dalsej hodiny
    if (isPrestavka)
      zostavajuciCas = aktualnaHodina.startTime.difference(_date);
    //ak je hodina, cas do konca hodiny
    else
      zostavajuciCas = aktualnaHodina.endTime.difference(_date);
    notifyListeners();
  }

  //?LOGIN FUNCTIONS:
  //headers = {cookie name = cookie value,...}
  //cookie list = hodnoty pre http header
  final Map<String, String> _headers = {};
  String _cookieList = '';

  void setAuthValues(String username, String password) {
    _password = password;
    _username = username;
  }

  Future<void> login({bool useTestValues = false}) async {
    //skip login, a load test response
    if (useTestValues) {
      _parseEduJsonData();
      setLoginStatus = LoginStatus.LoggedIn;
    }
    final String requestUrl = 'https://$_school.edupage.org/login/index.php';
    final String loginRequestUrl =
        'https://$_school.edupage.org/login/edubarLogin.php';

    try {
      final r = await http.get(
        Uri.parse(requestUrl),
        headers: {'Cookie': _cookieList},
      );
      _updateCookies(r.headers);

      final RegExp tokenRegex = RegExp(
        r'(?<=name="csrfauth" value=")(.*)(?=">)',
        caseSensitive: true,
        multiLine: false,
      );
      final String? csrfToken = tokenRegex.stringMatch(r.body);

      final Map<String, String> parameters = {
        "username": _username,
        "password": _password,
        "csrfauth": csrfToken.toString(),
      };

      final loginResponse = await http.post(
        Uri.parse(loginRequestUrl),
        body: parameters,
        headers: {'Cookie': _cookieList},
      );

      _updateCookies(loginResponse.headers);

      if (loginResponse.headers['location']!.contains('bad')) {
        setLoginStatus = LoginStatus.LoginFailed;
        throw Exception('Nespravne udaje!');
      }

      final loggedInResponse = await http.post(
        Uri.parse('https://$_school.edupage.org/user/'),
        headers: {'Cookie': _cookieList},
      );
      // dev.log(loggedInResponse.body);
      _parseEduJsonData(data: loggedInResponse.body);
      updateAktualne();

      setLoginStatus = LoginStatus.LoggedIn;
    } catch (e) {
      print('ERROR: $e');
      setLoginStatus = LoginStatus.LoginFailed;
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
        if (_headers.keys.contains(setCookieEntry[0])) {
          _headers.update(
              setCookieEntry[0], (_) => setCookieEntry[1].split(';')[0]);
        } else {
          _headers.addAll({setCookieEntry[0]: setCookieEntry[1].split(';')[0]});
        }
      }
    }
    //Update cookie listu (parameter do requestov)
    _cookieList = '';
    _headers.forEach(
      (key, value) {
        _cookieList = _cookieList +
            '$key=$value${(_headers.keys.last != key) ? '; ' : ''}';
      },
    );
  }

  void _parseEduJsonData({String data = ''}) async {
    //data = reponse header na parsnutie, ak sa nezada, nacita sa test reponse
    //TODO errors
    late final DateTime date;
    // dev.log(data);
    if (data == '') {
      data = await rootBundle
          .loadString('assets\\test_reponse\\edu_response.html');
      date = DateTime.parse(
          DateFormat('yyyy/dd/MM').parse('2021/16/09').toString());
    } else
      date = DateTime.now();
    String json;
    json = data.split("\$j(document).ready(function() {")[1];
    json = json.split(");")[0];
    json.replaceAll('\t', '');
    json = json.split("userhome(")[1];
    json.replaceAll('\n', '');
    json.replaceAll('\r', '');

    _parsedEdupageData = convert.json.decode(json) as Map<String, dynamic>;

    // create data
    if (_parsedEdupageData.isEmpty) return;
    _dnesnyRozvrh = getRozvrh(_parsedEdupageData, date);
  }
}
