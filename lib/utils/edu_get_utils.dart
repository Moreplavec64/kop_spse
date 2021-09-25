import 'package:intl/intl.dart';
import 'package:kop_spse/utils/edu_id_util.dart';

void getRozvrh(Map<String, dynamic> convJson, DateTime date) {
  //date format - YYYY-MM-DD
  final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  final dp = convJson['dp'];
  final todayPlans = dp['dates'][formattedDate];
  if (todayPlans == null) {
    //TODO chyba na tento datum neexistuje rozvrh
    print('chyba na tento datum neexistuje rozvrh');
    return;
  }

  final todayPlan = todayPlans['plan'];

  for (Map<String, dynamic> hodina in todayPlan) {
    // Redux.store.state.eduState.eduRepository
    // print(hodina['subjectid']);
    final List<dynamic> ucebne = hodina['classroomids'];
    print(hodina['uniperiod'] +
        '  ' +
        EduIdUtil.idToClassroom(
            convJson, ucebne.isNotEmpty ? hodina['classroomids'][0] : ''));
  }
}
