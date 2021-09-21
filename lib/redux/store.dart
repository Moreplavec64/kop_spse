import 'package:kop_spse/redux/eudpage/edupage_actions.dart';
import 'package:kop_spse/redux/eudpage/edupage_reducer.dart';
import 'package:kop_spse/redux/eudpage/edupage_state.dart';
import 'package:redux/redux.dart';

class AppState {
  final EduState eduState;

  AppState({
    required this.eduState,
  });

  AppState copyWith(EduState eduState) {
    return AppState(eduState: eduState);
  }
}

AppState reducer(AppState state, dynamic action) {
  switch (action.runtimeType) {
    case EduActions:
      eduReducer(state.eduState, action);
      return state.copyWith(state.eduState);
  }

  return state;
}

class Redux {
  static Store<AppState> _store = Store<AppState>(
    reducer,
    initialState: AppState(
      eduState: EduState.initial(),
    ),
  );

  static Store<AppState> get store => _store;
}
