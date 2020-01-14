import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class SubscriptionState {
  final List<IAPItem> subscriptions;
  final LoadingStatus loadingStatus;
  final String navigateTo;

  SubscriptionState({
    @required this.loadingStatus,
    @required this.subscriptions,
    @required this.navigateTo,
  });

  factory SubscriptionState.initial() {
    return SubscriptionState(
      loadingStatus: LoadingStatus.loading,
      subscriptions: <IAPItem>[],
      navigateTo: null,
    );
  }

  SubscriptionState copyWith({
    LoadingStatus loadingStatus,
    List<IAPItem> subscriptions,
    String navigateTo,
  }) {
    return SubscriptionState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      subscriptions: subscriptions ?? this.subscriptions,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }

  @override
  int get hashCode => loadingStatus.hashCode ^ subscriptions.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          subscriptions == other.subscriptions &&
          navigateTo == other.navigateTo;

  @override
  String toString() {
    return 'SubscriptionState{loadingStatus: $loadingStatus, subsriptions: $subscriptions, navigateTo: $navigateTo}';
  }
}
