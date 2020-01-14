import 'package:learning/data/data.dart';
import 'package:learning/redux/subscription/subscription_actions.dart';
import 'package:learning/redux/subscription/subscription_state.dart';
import 'package:redux/redux.dart';

final subscriptionReducer = combineReducers<SubscriptionState>([
  TypedReducer<SubscriptionState, SetNavigateToAction>(_setNavigateTo),
  TypedReducer<SubscriptionState, FetchSubscriptionsAction>(_fetchSpotlights),
  TypedReducer<SubscriptionState, FetchSubscriptionsSucceededAction>(
      _setSubscriptions),
  TypedReducer<SubscriptionState, FetchSubscriptionsFailedAction>(_setError),
  TypedReducer<SubscriptionState, BuySubscriptionAction>(_buySubscription),
  TypedReducer<SubscriptionState, BuySubscriptionSucceededAction>(
      _setSubscription),
  TypedReducer<SubscriptionState, BuySubscriptionFailedAction>(
      _setPurchaseError),
]);

SubscriptionState _setNavigateTo(
    SubscriptionState state, SetNavigateToAction action) {
  return state.copyWith(
    navigateTo: action.navigateTo,
  );
}

SubscriptionState _fetchSpotlights(
    SubscriptionState state, FetchSubscriptionsAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

SubscriptionState _setSubscriptions(
    SubscriptionState state, FetchSubscriptionsSucceededAction action) {
  return state.copyWith(
    subscriptions: action.subscriptions,
    loadingStatus: LoadingStatus.success,
  );
}

SubscriptionState _setError(
    SubscriptionState state, FetchSubscriptionsFailedAction action) {
  return state.copyWith(
    subscriptions: const [],
    loadingStatus: LoadingStatus.error,
  );
}

SubscriptionState _buySubscription(
    SubscriptionState state, BuySubscriptionAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

SubscriptionState _setSubscription(
    SubscriptionState state, BuySubscriptionSucceededAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
  );
}

SubscriptionState _setPurchaseError(
    SubscriptionState state, BuySubscriptionFailedAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.error,
  );
}
