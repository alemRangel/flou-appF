import 'package:flutter/material.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_state.dart';
import 'package:learning/redux/notification/notification_actions.dart';
import 'package:learning/redux/referral/referral_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ReferralPageViewModel {
  ReferralPageViewModel({
    @required this.authState,
    @required this.share,
    @required this.copyToClipboard,
  });

  final AuthState authState;
  final Function share;
  final Function copyToClipboard;

  static ReferralPageViewModel fromStore(Store<AppState> store) {
    var referralCode = store.state.authState.user.referralCode;
    return ReferralPageViewModel(
      authState: store.state.authState,
      share: () => store.dispatch(ShareContentAction(referralCode)),
      copyToClipboard: () {
        store.dispatch(CopyToClipboardAction(referralCode));
        store.dispatch(ShowSnackBarAction('Código copiado'));
      },
    );
  }

  get referralCode => authState.user.referralCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReferralPageViewModel &&
          runtimeType == other.runtimeType &&
          authState == other.authState &&
          share == other.share &&
          copyToClipboard == other.copyToClipboard;

  @override
  int get hashCode =>
      authState.hashCode ^ share.hashCode ^ copyToClipboard.hashCode;
}
