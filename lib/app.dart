import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/config.dart';
import 'package:learning/navigation/router.dart';
import 'package:learning/redux/app/app_actions.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/splash/splash_page.dart';
import 'package:learning/utils/theme.dart';
import 'package:redux/redux.dart';

class App extends StatefulWidget {
  final Store<AppState> store;

  App(this.store);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(InitAction());
    defineRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: router.generator,
        home: SplashPage(),
        theme: appTheme,
      ),
    );
  }
}
