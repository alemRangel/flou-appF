import 'package:flutter/services.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/referral/referral_actions.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';

class ReferralMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is CopyToClipboardAction) {
      Clipboard.setData(ClipboardData(text: action.content));
    } else if (action is ShareContentAction) {
      Share.share(action.content);
    }
    next(action);
  }
}
