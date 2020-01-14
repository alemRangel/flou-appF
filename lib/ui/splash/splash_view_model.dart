import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SplashPageViewModel {
  SplashPageViewModel({
    @required this.authState,
    @required this.navigateToSignIn,
    @required this.navigateToSignUp,
  });

  final AuthState authState;
  final Function navigateToSignIn;
  final Function navigateToSignUp;

  static SplashPageViewModel fromStore(Store<AppState> store) {
    return SplashPageViewModel(
      authState: store.state.authState,
      navigateToSignIn: () => store.dispatch(NavigateAction('/auth')),
      navigateToSignUp: () =>
          store.dispatch(NavigateAction('/auth?signup=true')),
    );
  }

  get signInStatus => authState.signInStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashPageViewModel &&
          runtimeType == other.runtimeType &&
          authState == other.authState;

  @override
  int get hashCode => authState.hashCode;
}
