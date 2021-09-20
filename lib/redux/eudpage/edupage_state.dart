import 'package:kop_spse/models/edu_user.dart';
import 'package:kop_spse/repository/edu_repository.dart';

class EduState {
  final EduRepository eduRepository;
  final EduUser eduUser;

  EduState({
    required this.eduUser,
    required this.eduRepository,
  });

  factory EduState.initial() => EduState(
        eduRepository: EduRepository(),
        eduUser: EduUser(
          email: '',
          firstName: '',
          lastName: '',
          pohlavie: '',
          studentID: '',
          triedaID: '',
        ),
      );
}
