import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class SetNavigateToAction {
  final String navigateTo;

  SetNavigateToAction(this.navigateTo);
}

class FetchSubscriptionsAction {}

class FetchSubscriptionsSucceededAction {
  final List<IAPItem> subscriptions;

  FetchSubscriptionsSucceededAction(this.subscriptions);
}

class FetchSubscriptionsFailedAction {
  final Exception error;

  FetchSubscriptionsFailedAction(this.error);
}

class BuySubscriptionAction {
  final String sku;

  BuySubscriptionAction(this.sku);
}

class BuySubscriptionSucceededAction {
  final PurchasedItem purchasedItem;

  BuySubscriptionSucceededAction(this.purchasedItem);
}

class BuySubscriptionFailedAction {
  final Exception error;

  BuySubscriptionFailedAction(this.error);
}

class UseActivationCodeAction {
  final String code;

  UseActivationCodeAction(this.code);
}
