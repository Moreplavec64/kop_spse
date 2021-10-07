import 'package:intl/intl.dart';
import 'package:kop_spse/models/plan.dart';

List<LessonPlan> getRozvrh(Map<String, dynamic> convJson, DateTime date) {
  //date format - YYYY-MM-DD
  final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  final dp = convJson['dp'];
  final todayPlans = dp['dates'][formattedDate];
  if (todayPlans == null) {
    //TODO chyba na tento datum neexistuje rozvrh
    print('chyba na tento datum neexistuje rozvrh');
    return [];
  }

  //List<Map<String, dynamic>>
  final List<dynamic> todayPlan = todayPlans['plan'];

  print(todayPlan.last['uniperiod'].toString());

  int _getPeriod(String period) {
    if (!period.contains('-'))
      return int.parse(period);
    else
      return int.parse(period.split('-').first);
  }

  String _verifyList(List<dynamic> list) {
    if (list.isNotEmpty)
      return list.first;
    else
      return 'Neexistuje';
  }

  return todayPlan
      .map(
        (hodina) => LessonPlan(
          period: _getPeriod(hodina['uniperiod']),
          ucitelID: _verifyList(hodina["teacherids"]),
          classroomID: _verifyList(hodina["classroomids"]),
          classID: _verifyList(hodina["classids"]),
          subjectID: hodina["subjectid"],
          skupina: hodina['groupnames'][0],
          startTime: hodina['starttime'],
          endTime: hodina['endtime'],
        ),
      )
      .toList();
}
