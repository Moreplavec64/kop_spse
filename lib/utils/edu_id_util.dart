class EduIdUtil {
  static String idToClassroom(Map<String, dynamic> data, String id) =>
      data['dbi']['classrooms'][id.toString()]['short'];
  static String idToClass(Map<String, dynamic> data, String id) =>
      data['dbi']['classes'][id.toString()]['name'];
  static String idToShortSubject(Map<String, dynamic> data, String id) =>
      data['dbi']['subjects'][id.toString()]['short'];
  static String idToTeacher(Map<String, dynamic> data, String id) {
    final td = data['dbi']['teachers'][id.toString()];
    return '${td['firstname']} ${td['lastname']}';
  }

  static String idToLongSubject(Map<String, dynamic> data, String id) =>
      data['dbi']['subjects'][id.toString()]['name'];
}
