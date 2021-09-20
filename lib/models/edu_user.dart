class EduUser {
  final String userID;
  final String studentID;
  final String firstName;
  final String lastName;
  final String email;
  final String triedaID;
  final String pohlavie;

  EduUser({
    this.userID = '',
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.pohlavie,
    required this.studentID,
    required this.triedaID,
  });

/*
"userrow" : {
      "UserID" : "Student949624",
      "StudentID" : "949624",
      "p_meno" : "Adam",
      "p_priezvisko" : "Hadar",
      "p_www_login" : "AdamHadar",
      "p_mail" : "adamkohadar77@gmail.com",
      "p_pohlavie" : "1",
      "TriedaID" : "949541"
    },
*/

}
