import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_actions.dart';
import 'package:learning/redux/auth/auth_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AuthPageViewModel {
  AuthPageViewModel({
    @required this.authState,
    @required this.signInWith,
    @required this.signInWithPassword,
    @required this.signUpWithPassword,
    @required this.resetPassword,
    @required this.navigateToSignIn,
  });

  final AuthState authState;
  final Function signInWith;
  final Function signUpWithPassword;
  final Function signInWithPassword;
  final Function resetPassword;
  final Function navigateToSignIn;

  static AuthPageViewModel fromStore(Store<AppState> store) {
    return AuthPageViewModel(
      authState: store.state.authState,
      signInWith: (SignInProvider provider) =>
          store.dispatch(SignInWithProviderAction(provider)),
      signInWithPassword: (String email, String password) =>
          store.dispatch(SignInWithPasswordAction(email, password)),
      signUpWithPassword: (String email, String password) =>
          store.dispatch(SignUpWithPasswordAction(email, password)),
      resetPassword: (String email) =>
          store.dispatch(ResetPasswordAction(email)),
      navigateToSignIn: () =>
          store.dispatch(NavigateAction('/auth', replace: true)),
    );
  }

  get signInStatus => authState.signInStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthPageViewModel &&
          runtimeType == other.runtimeType &&
          authState == other.authState &&
          signInStatus == other.signInStatus &&
          signInWith == other.signInWith &&
          signInWithPassword == other.signInWithPassword &&
          signUpWithPassword == other.signUpWithPassword &&
          navigateToSignIn == other.navigateToSignIn;

  @override
  int get hashCode =>
      authState.hashCode ^
      signInStatus.hashCode ^
      signInWith.hashCode ^
      signInWithPassword.hashCode ^
      signUpWithPassword.hashCode ^
      navigateToSignIn.hashCode;
}
