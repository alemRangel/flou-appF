import 'dart:async';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_actions.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:learning/redux/notification/notification_actions.dart';
import 'package:learning/utils/auth.dart';
import 'package:learning/utils/subscription.dart';
import 'package:redux/redux.dart';

class AuthMiddleware extends MiddlewareClass<AppState> {
  final UserEndpoint userEndpoint;
  final Auth auth;

  AuthMiddleware(this.auth, this.userEndpoint);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is InitAuthAction) {
      auth.getCurrentUser().then((User user) {
        if (user != null) {
          _checkForSubscription(store);
          store.dispatch(SubscribeUserAction(user.uid));
          store.dispatch(UserUpdatedAction(user));
          store.dispatch(SignInSucceededAction(user));
        } else {
          store.dispatch(InitAuthFailedAction());
        }
      }).catchError((dynamic error) {
        store.dispatch(InitAuthFailedAction());
      });
    } else if (action is SignInWithProviderAction) {
      _signInWithProvider(action.provider).then((User user) {
        store.dispatch(SubscribeUserAction(user.uid));
        store.dispatch(SignInSucceededAction(user));
      }).catchError((dynamic error) {
        store.dispatch(SignInFailedAction(error));
      });
    } else if (action is SignUpWithPasswordAction) {
      auth
          .signUpWithEmailAndPassword(action.email, action.password)
          .then((User user) {
        store.dispatch(SubscribeUserAction(user.uid));
        store.dispatch(SignInSucceededAction(user));
      }).catchError((dynamic error) {
        store.dispatch(SignInFailedAction(error));
      });
    } else if (action is SignInWithPasswordAction) {
      auth
          .signInWithEmailAndPassword(action.email, action.password)
          .then((User user) {
        store.dispatch(SubscribeUserAction(user.uid));
        store.dispatch(SignInSucceededAction(user));
      }).catchError((dynamic error) {
        store.dispatch(SignInFailedAction(error));
      });
    } else if (action is SignInSucceededAction) {
      store.dispatch(NavigateAction('/dashboard', replaceAll: true));
    } else if (action is SignOutAction) {
      auth.signOut();
      store.dispatch(NavigateAction('/', replaceAll: true));
    } else if (action is ResetPasswordAction) {
      auth.firebaseAuth
          .sendPasswordResetEmail(email: action.email)
          .then((_placeholder) {
        store.dispatch(ShowSnackBarAction(
            'Se te envió un email a ${action.email} para restablecer tu contraseña.'));
      }).catchError((dynamic error) {
        store.dispatch(ShowSnackBarAction(
            'No pudimos restablecer tu contraseña, vuelve a intentarlo.'));
      });
    } else if (action is SubscribeUserAction) {
      userEndpoint.subscribe(action.id).listen((User user) {
        store.dispatch(UserUpdatedAction(user));
      });
    }
    next(action);
  }

  Future<User> _signInWithProvider(SignInProvider provider) {
    switch (provider) {
      case SignInProvider.google:
        return auth.signInWithGoogle();
      case SignInProvider.facebook:
        return auth.signInWithFacebook();
      default:
        return null;
    }
  }
}

void _checkForSubscription(Store<AppState> store) async {
  await FlutterInappPurchase.initConnection;
  bool hasSub = await FlutterInappPurchase.checkSubscribed(
    sku: Subscription.getAnnualSubscription(),
    duration: const Duration(days: 365),
  );
  await FlutterInappPurchase.endConnection;
  if (hasSub) {
    //store.dispatch(BuySubscriptionSucceededAction(null));
  }
}
