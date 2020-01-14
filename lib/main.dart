import 'package:flutter/material.dart';
import 'package:learning/app.dart';
import 'package:learning/redux/store.dart';
import 'dart:async';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isInDebugMode = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    dynamic store = await createStore();
    runApp(App(store));
  }, onError: (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);
  });
}