import 'package:flutter/material.dart';
import 'package:learning/config.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/notification/notification_actions.dart';
import 'package:redux/redux.dart';

class NotificationMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is ShowSnackBarAction) {
      scaffoldKey.currentState?.removeCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          action.content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ));
    }
    next(action);
  }
}
