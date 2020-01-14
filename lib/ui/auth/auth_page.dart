import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/config.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/auth/auth_view_model.dart';
import 'package:learning/ui/auth/widget/auth_form.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/field_dialog/field_dialog_page.dart';

import 'widget/social_auth.dart';

class AuthPage extends StatelessWidget {
  final bool displaySignUp;

  AuthPage({this.displaySignUp = true});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthPageViewModel>(
      onInit: (store) {},
      distinct: true,
      converter: (store) => AuthPageViewModel.fromStore(store),
      builder: (_, viewModel) => AuthPageContent(viewModel, displaySignUp),
    );
  }
}

class AuthPageContent extends StatefulWidget {
  final AuthPageViewModel viewModel;
  final bool displaySignUp;

  AuthPageContent(this.viewModel, this.displaySignUp);

  @override
  State createState() => _AuthPageContentState();
}

class _AuthPageContentState extends State<AuthPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/images/mountains.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: _buildLoading(context),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return LoadingView(
      status: widget.viewModel.signInStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      successContent: const PlatformAdaptiveProgressIndicator(),
      idleContent: _buildContent(context),
      errorContent: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildLogo(),
        _buildAuthForm(context),
        SocialAuth(onSignInWithProvider: widget.viewModel.signInWith),
        SizedBox(height: 15.0),
        _termsAndConditions(),
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      padding:
          EdgeInsets.only(top: 80.0, bottom: 50.0, right: 100.0, left: 100.0),
      child: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Widget _buildAuthForm(BuildContext context) {
    return widget.displaySignUp ? _buildSignUp(context) : _buildSignIn(context);
  }

  Widget _buildSignIn(BuildContext context) {
    return AuthForm(
      actionLabel: 'INICIAR SESIÓN',
      onActionPressed: widget.viewModel.signInWithPassword,
      extraActionLabel: 'Olvide mi contraseña',
      onExtraActionPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<DismissDialogAction>(
            builder: (BuildContext context) {
              return FullScreenDialogPage(
                title: 'Olvide mi contraseña',
                label: 'Correo electronico',
                actionLabel: 'CONTINUAR',
                onValueSubmitted: (String email) =>
                    widget.viewModel.resetPassword(email),
              );
            },
            fullscreenDialog: true,
          ),
        );
        //widget.viewModel.forgotPassword,
      },
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return AuthForm(
      actionLabel: 'REGISTRARME',
      onActionPressed: widget.viewModel.signUpWithPassword,
      extraActionLabel: 'Ya tengo cuenta',
      onExtraActionPressed: widget.viewModel.navigateToSignIn,
    );
  }

  Widget _termsAndConditions() {
    final textStyle = new TextStyle(fontSize: 13.0, color: Colors.black38);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Al registrarte indicas que has leído y aceptas nuestros ',
        style: textStyle,
        children: <TextSpan>[
          TextSpan(
            text: 'terminos y condiciones',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}
