import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/ui/subscription/subscription_page.dart';

final subscriptionHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SubscriptionPage(params["navigateTo"][0]);
});
