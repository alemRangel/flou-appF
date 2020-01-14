import 'package:learning/api/api.dart';
import 'package:learning/data/spotlight.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/spotlight/spotlight_actions.dart';
import 'package:redux/redux.dart';

class SpotlightMiddleware extends MiddlewareClass<AppState> {
  final SpotlightEndpoint spotlightEndpoint;

  SpotlightMiddleware(this.spotlightEndpoint);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is FetchSpotlightsAction) {
      //spotlightEndpoint.listTest().then((List<Spotlight> spotlights) {
       spotlightEndpoint.listTest().then((List<Spotlight> spotlights) {
        store.dispatch(FetchSpotlightsSucceededAction(spotlights));
      }).catchError((error) {
        store.dispatch(FetchSpotlightsFailedAction(error));
      });
    }
    next(action);
  }
}
