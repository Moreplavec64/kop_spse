class EduIdUtil {
  static String idToLongClassroom(Map<String, dynamic> data, String id) =>
      (data['dbi']['classrooms'][id.toString()] ??
          {'short': 'Žiadna pridelená učebňa'})['short'];

  static String idToNavClassroom(Map<String, dynamic> data, String id) {
    String ucebna = idToLongClassroom(data, id).split('-').last.trim();
    //ak sa nenachadza na 6, zmaze leading poschodie 1D106 => D106
    ucebna = ucebna.startsWith('6') ? ucebna : ucebna.substring(1);
    return ucebna;
  }

  static String idToClass(Map<String, dynamic> data, String id) =>
      data['dbi']['classes'][id.toString()]['name'];
  static String? idToShortSubject(Map<String, dynamic> data, String id) =>
      data['dbi']['subjects']?[id.toString()]?['short'];
  static String idToTeacher(Map<String, dynamic> data, String id) {
    final td = data['dbi']['teachers'][id.toString()];
    return '${td['firstname']} ${td['lastname']}';
  }

  static String idToLongSubject(Map<String, dynamic> data, String id) =>
      data['dbi']['subjects'][id.toString()]['name'];
}
