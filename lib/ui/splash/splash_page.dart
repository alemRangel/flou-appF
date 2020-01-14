import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_actions.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/splash/splash_view_model.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashPageViewModel>(
      onInit: (store) {
        store.dispatch(InitAuthAction());
      },
      distinct: true,
      converter: (store) => SplashPageViewModel.fromStore(store),
      builder: (_, viewModel) => SplashPageContent(viewModel),
    );
  }
}

class SplashPageContent extends StatelessWidget {
  final SplashPageViewModel viewModel;

  SplashPageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingView(
        status: viewModel.signInStatus,
        loadingContent: const PlatformAdaptiveProgressIndicator(),
        idleContent: _buildContent(context),
        successContent: _buildContent(context),
        errorContent: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: new Column(
        children: <Widget>[
          _buildLogo(),
          SizedBox(height: 130.0),
          _buildSignUpButton(context),
          SizedBox(height: 30.0),
          _buildSignInButton(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: EdgeInsets.only(top: 250.0, left: 80.0, right: 80.0),
      child: Center(
        child: Image.asset('assets/images/logo_white.png'),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: OutlineButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Theme.of(context).accentColor,
        highlightedBorderColor: Colors.white,
        onPressed: viewModel.navigateToSignUp,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Text(
            'REGISTRARME',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        onPressed: viewModel.navigateToSignIn,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Text(
            'INICIAR SESIÓN',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
