import 'package:kop_spse/redux/eudpage/edupage_reducer.dart';
import 'package:kop_spse/redux/eudpage/edupage_state.dart';
import 'package:redux/redux.dart';

class AppState {
  final EduState eduState;

  AppState({
    required this.eduState,
  });
}

class Redux {
  static Store<AppState> _store = Store<AppState>(
    (prevState, action) => prevState,
    initialState: AppState(
      eduState: EduState.initial(),
    ),
  );

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }
}
