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

  return todayPlan
      .map(
        (hodina) => LessonPlan(
          period: int.parse(hodina["uniperiod"]),
          ucitelID: hodina["teacherids"][0],
          classroomID: hodina["classroomids"][0],
          classID: hodina["classids"][0],
          subjectID: hodina["subjectid"],
        ),
      )
      .toList();
}
