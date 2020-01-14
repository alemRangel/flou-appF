import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_state.dart';
import 'package:learning/redux/subscription/subscription_actions.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:learning/redux/subscription/subscription_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SubscriptionPageViewModel {
  SubscriptionPageViewModel({
    @required this.authState,
    @required this.subscriptionState,
    @required this.subscribe,
    @required this.refreshSubscription,
    @required this.useActivationCode,
    @required this.navigateToUrl,
  });

  final AuthState authState;
  final SubscriptionState subscriptionState;
  final Function subscribe;
  final Function refreshSubscription;
  final Function useActivationCode;
  final Function navigateToUrl;

  static SubscriptionPageViewModel fromStore(Store<AppState> store) {
    return SubscriptionPageViewModel(
      subscriptionState: store.state.subscriptionState,
      authState: store.state.authState,
      subscribe: (String id) => store.dispatch(BuySubscriptionAction(id)),
      refreshSubscription: () => store.dispatch(FetchSubscriptionsAction()),
      useActivationCode: (String code) =>
          store.dispatch(UseActivationCodeAction(code)),
      navigateToUrl: (String actionUrl) =>
        store.dispatch(NavigateUrlAction(actionUrl)),
    );
  }

  static onInit(Store<AppState> store, String navigateTo) {
    store.dispatch(SetNavigateToAction(navigateTo));
    store.dispatch(FetchSubscriptionsAction());
  }

  IAPItem get subscription => subscriptionState.subscriptions
      ?.firstWhere((item) => true, orElse: () => null);

  String get navigateTo => subscriptionState.navigateTo;
  LoadingStatus get loadingStatus => subscriptionState.loadingStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionPageViewModel &&
          runtimeType == other.runtimeType &&
          authState == other.authState &&
          subscriptionState == other.subscriptionState &&
          subscribe == other.subscribe &&
          refreshSubscription == other.refreshSubscription &&
          useActivationCode == other.useActivationCode;

  @override
  int get hashCode =>
      authState.hashCode ^
      subscriptionState.hashCode ^
      subscribe.hashCode ^
      refreshSubscription.hashCode ^
      useActivationCode.hashCode;
}
