import 'package:intl/intl.dart';
import 'package:kop_spse/models/plan.dart';

List<String> getAllClassrooms(Map<String, dynamic> data) {
  final r = data['dbi']['classrooms'] as Map<String, dynamic>;
  //vrati vsetky unikatne ucebne s aktualnim nazvom "trieda/nazov ucebne - cislo ucebne"
  return r.values.map((e) => (e['short'] as String)).toSet().toList();
}

List<LessonPlan> getRozvrh(Map<String, dynamic> convJson, DateTime date) {
  //date format - yyyy-MM-dd
  final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  final dp = convJson['dp'];
  final todayPlans = dp['dates'][formattedDate];
  if (todayPlans == null) {
    print('chyba na tento datum neexistuje rozvrh');
    return [];
  }

  //List<Map<String, dynamic>>
  final List<dynamic> todayPlan = todayPlans['plan'];

  if (todayPlan.isEmpty) return [];

  int _getPeriod(String period) {
    if (!period.contains('-'))
      return int.tryParse(period) ?? -1;
    else
      return int.parse(period.split('-').first);
  }

  String _verifyList(List<dynamic> list) =>
      list.isNotEmpty ? list.first : 'Neexistuje';

  return todayPlan.map((hodina) {
    final List<String> startTime = hodina['starttime'].toString().split(':');
    final List<String> endTime = hodina['endtime'].toString().split(':');
    final d = DateTime.now();

    return LessonPlan(
        period: _getPeriod(hodina['uniperiod']),
        ucitelID: _verifyList(hodina["teacherids"]),
        classroomID: _verifyList(hodina["classroomids"]),
        classID: _verifyList(hodina["classids"]),
        subjectID: hodina["subjectid"],
        skupina: _verifyList(hodina['groupnames']),
        startTime: DateTime(
          d.year,
          d.month,
          d.day,
          int.parse(startTime[0]),
          int.parse(startTime[1]),
        ),
        endTime: DateTime(
          d.year,
          d.month,
          d.day,
          int.parse(endTime[0]),
          int.parse(endTime[1]),
        ),
        isEvent: hodina['type'] == 'event');
  }).toList();
}
