import 'package:learning/redux/app/app_actions.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class AppMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is InitAction) {}
    next(action);
  }
}
