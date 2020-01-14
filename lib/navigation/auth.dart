import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/ui/auth/auth_page.dart';

final authHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  var showSignup = params['signup']?.first == 'true';
  return AuthPage(displaySignUp: showSignup ?? false);
});
