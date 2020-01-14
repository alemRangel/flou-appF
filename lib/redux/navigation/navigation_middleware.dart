import 'package:learning/config.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is NavigateAction) {
      if (action.replaceAll) {
        navigatorKey.currentState.pushNamedAndRemoveUntil(
          action.route,
          (var route) => false,
        );
      } else if (action.replace) {
        navigatorKey.currentState.pushReplacementNamed(action.route);
      } else {
        navigatorKey.currentState.pushNamed(action.route);
      }
    } else if (action is NavigateUrlAction) {
      launch(action.url);
    } else if (action is PopAction) {
      navigatorKey.currentState.pop();
    }
    next(action);
  }
}
