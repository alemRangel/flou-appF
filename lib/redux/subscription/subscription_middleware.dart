import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:learning/api/api.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:learning/redux/notification/notification_actions.dart';
import 'package:learning/redux/subscription/subscription_actions.dart';
import 'package:learning/utils/subscription.dart';
import 'package:redux/redux.dart';

class SubscriptionMiddleware extends MiddlewareClass<AppState> {
  final RegisterSubscription registerSubscription;
  final UseActivationCode useActivationCode;

  SubscriptionMiddleware(this.registerSubscription, this.useActivationCode);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is FetchSubscriptionsAction) {
      _fetchSubscriptions(store, action);
    } else if (action is BuySubscriptionAction) {
      _buySubscription(store, action);
    } else if (action is BuySubscriptionSucceededAction) {
      _registerSubscription(store, action, registerSubscription);
    } else if (action is UseActivationCodeAction) {
      useActivationCode.call(action.code).then((wasSuccessful) {
        if (wasSuccessful) {
          store.dispatch(
              ShowSnackBarAction('¡Disfuta del contenido de Flou Academy!'));
          store.dispatch(PopAction());
        } else {
          store.dispatch(ShowSnackBarAction(
              'Código invalido. Si crees que esto es un error contáctanos.'));
        }
      }).catchError((dynamic error) {
        store.dispatch(ShowSnackBarAction(
            'No pudimos validar el código, vuelve a intentarlo.'));
      });
    }
    next(action);
  }
}

void _fetchSubscriptions(
    Store<AppState> store, FetchSubscriptionsAction action) async {
  await FlutterInappPurchase.initConnection;
  try {
    List<IAPItem> subscriptions = await FlutterInappPurchase.getSubscriptions(
        [Subscription.getAnnualSubscription()]);
    if (subscriptions.isEmpty) throw Exception();
    store.dispatch(FetchSubscriptionsSucceededAction(subscriptions));
  } catch (error) {
    store.dispatch(FetchSubscriptionsFailedAction(error));
  }
  await FlutterInappPurchase.endConnection;
}

void _buySubscription(
    Store<AppState> store, BuySubscriptionAction action) async {
  try {
    await FlutterInappPurchase.initConnection;
    PurchasedItem item = await FlutterInappPurchase.buySubscription(action.sku);
    store.dispatch(BuySubscriptionSucceededAction(item));
    await FlutterInappPurchase.endConnection;
  } catch (error) {
    store.dispatch(BuySubscriptionFailedAction(error));
  }
}

void _registerSubscription(
    Store<AppState> store,
    BuySubscriptionSucceededAction action,
    RegisterSubscription registerSubscription) async {
  if (action.purchasedItem == null) return;
  store.dispatch(PopAction());
  await registerSubscription.call(
      action.purchasedItem.productId, action.purchasedItem.purchaseToken);
  /*if (isValid) {
    store.dispatch(PopAction());
  } else {
    store.dispatch(BuySubscriptionFailedAction(
        Exception('No pudimos validar la compra.')));
  }*/
}
