import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/page/dashboard.dart';

final dashboardHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DashboardPage();
});
