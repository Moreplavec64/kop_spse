import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:developer' as dev;
import 'dart:convert' as convert;

import 'package:intl/intl.dart';
import 'package:kop_spse/edupage/edu_id_util.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets\\test_reponse\\edu_response.html');
}

Future<String> parseEduJsonData() async {
  final String data = await loadAsset();
  String json;
  json = data.split("\$j(document).ready(function() {")[1];
  json = json.split(");")[0];
  json.replaceAll('\t', '');
  json = json.split("userhome(")[1];
  json.replaceAll('\n', '');
  json.replaceAll('\r', '');

  final conv_json = convert.json.decode(json) as Map<String, dynamic>;

  //dev.log(conv_json.toString());

  // dev.log(conv_json['dp'].toString());

  getRozvrh(conv_json, DateTime.now().subtract(Duration(days: 2)));

  return '';
}

void getRozvrh(Map<String, dynamic> convJson, DateTime date) {
  //date format - YYYY-MM-DD
  final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  final dp = convJson['dp'];
  final today_plans = dp['dates'][formattedDate];
  if (today_plans == null) {
    //TODO chyba na tento datum neexistuje rozvrh
    print('chyba na tento datum neexistuje rozvrh');
    return;
  }

  final todayPlan = today_plans['plan'];

  for (Map<String, dynamic> hodina in todayPlan) {
    // print(hodina['uniperiod']);
    // print(hodina['subjectid']);
    final List<dynamic> ucebne = hodina['classroomids'];
    // print(EduIdUtil.idToClassroom(
    //     convJson, ucebne.isNotEmpty ? hodina['classroomids'][0] : ''));
  }
}
