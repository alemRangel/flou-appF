import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/spotlight/spotlight_actions.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SpotlightPageViewModel {
  SpotlightPageViewModel({
    @required this.status,
    @required this.spotlights,
    @required this.refreshSpotlights,
    @required this.navigateTo,
  });

  final LoadingStatus status;
  final List<Spotlight> spotlights;
  final Function refreshSpotlights;
  final Function navigateTo;

  static SpotlightPageViewModel fromStore(Store<AppState> store) {
    return SpotlightPageViewModel(
      status: store.state.spotlightState.loadingStatus,
      spotlights: store.state.spotlightState.spotlights,
      refreshSpotlights: () => store.dispatch(FetchSpotlightsAction()),
      navigateTo: (String actionUrl) =>
          store.dispatch(NavigateUrlAction(actionUrl)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpotlightPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          spotlights == other.spotlights &&
          refreshSpotlights == other.refreshSpotlights &&
          navigateTo == other.navigateTo;

  @override
  int get hashCode =>
      status.hashCode ^
      spotlights.hashCode ^
      refreshSpotlights.hashCode ^
      navigateTo.hashCode;
}
