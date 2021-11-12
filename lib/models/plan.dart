class LessonPlan {
  final int period;
  final String ucitelID;
  final String skupina;
  //TODO suplovanie
  final String classroomID;
  final String classID;
  final String subjectID;
  final DateTime startTime;
  final DateTime endTime;

  LessonPlan({
    required this.period,
    required this.ucitelID,
    required this.classroomID,
    required this.classID,
    required this.subjectID,
    required this.skupina,
    required this.startTime,
    required this.endTime,
  });
}
