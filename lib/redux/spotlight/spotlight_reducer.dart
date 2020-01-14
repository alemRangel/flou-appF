import 'package:learning/data/data.dart';
import 'package:learning/redux/spotlight/spotlight_actions.dart';
import 'package:learning/redux/spotlight/spotlight_state.dart';
import 'package:redux/redux.dart';

final spotlightReducer = combineReducers<SpotlightState>([
  TypedReducer<SpotlightState, FetchSpotlightsAction>(_fetchSpotlights),
  TypedReducer<SpotlightState, FetchSpotlightsSucceededAction>(_setSpotlights),
  TypedReducer<SpotlightState, FetchSpotlightsFailedAction>(_setError),
]);

SpotlightState _fetchSpotlights(
    SpotlightState state, FetchSpotlightsAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

SpotlightState _setSpotlights(
    SpotlightState state, FetchSpotlightsSucceededAction action) {
  return state.copyWith(
    spotlights: action.spotlights,
    loadingStatus: LoadingStatus.success,
  );
}

SpotlightState _setError(
    SpotlightState state, FetchSpotlightsFailedAction action) {
  return state.copyWith(
    spotlights: const [],
    loadingStatus: LoadingStatus.error,
  );
}
