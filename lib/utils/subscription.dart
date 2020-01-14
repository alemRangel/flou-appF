import 'dart:io' show Platform;

class Subscription {
  static String getAnnualSubscription() {
    if (Platform.isIOS) {
      return 'com.flouacademy.subscription.anual';
    } else {
      return 'subscription_anual';
    }
  }
}
