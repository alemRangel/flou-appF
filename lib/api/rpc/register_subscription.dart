import 'dart:async';

import 'rpc.dart';

class RegisterSubscription extends Rpc {
  Future<bool> call(String subscriptionId, String purchaseToken) async {
    try {
      dynamic data = await callFunction('registerSubscription', {
        'subscriptionId': subscriptionId,
        'token': purchaseToken,
      });
      return data['isValid'];
    } catch (e) {
      print(e);
      return null;
    }
  }
}
