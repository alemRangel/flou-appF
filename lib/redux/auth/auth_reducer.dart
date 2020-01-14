import 'package:learning/data/data.dart';
import 'package:learning/redux/auth/auth_actions.dart';
import 'package:learning/redux/auth/auth_state.dart';
import 'package:learning/redux/subscription/subscription_actions.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, InitAuthAction>(_initAuth),
  TypedReducer<AuthState, UserUpdatedAction>(_setUser),
  TypedReducer<AuthState, InitAuthFailedAction>(_setError),
  TypedReducer<AuthState, SignInWithProviderAction>(_signInWithGoogle),
  TypedReducer<AuthState, SignInWithPasswordAction>(_signInWithPassword),
  TypedReducer<AuthState, SignUpWithPasswordAction>(_signUpWithPassword),
  TypedReducer<AuthState, SignInSucceededAction>(_setProviderUser),
  TypedReducer<AuthState, SignInFailedAction>(_setProviderError),
  TypedReducer<AuthState, BuySubscriptionSucceededAction>(_setHasSubscription),
]);

AuthState _initAuth(AuthState state, InitAuthAction action) {
  return state.copyWith(
    signInStatus: LoadingStatus.loading,
  );
}

AuthState _setUser(AuthState state, UserUpdatedAction action) {
  return state.copyWith(
    user: action.user,
    signInStatus: LoadingStatus.idle,
  );
}

AuthState _setError(AuthState state, InitAuthFailedAction action) {
  return state.copyWith(
    user: null,
    signInStatus: LoadingStatus.idle,
  );
}

AuthState _signInWithGoogle(AuthState state, SignInWithProviderAction action) {
  return state.copyWith(
    signInStatus: LoadingStatus.loading,
  );
}

AuthState _signInWithPassword(
    AuthState state, SignInWithPasswordAction action) {
  return state.copyWith(
    signInStatus: LoadingStatus.loading,
  );
}

AuthState _signUpWithPassword(
    AuthState state, SignUpWithPasswordAction action) {
  return state.copyWith(
    signInStatus: LoadingStatus.loading,
  );
}

AuthState _setProviderUser(AuthState state, SignInSucceededAction action) {
  return state.copyWith(
    user: action.user,
    signInStatus: LoadingStatus.idle,
  );
}

AuthState _setProviderError(AuthState state, SignInFailedAction action) {
  return state.copyWith(
    user: null,
    signInStatus: LoadingStatus.idle,
  );
}

AuthState _setHasSubscription(
    AuthState state, BuySubscriptionSucceededAction action) {
  User newUser = state.user.copyWith(hasActiveSubscription: true);
  return state.copyWith(
    user: newUser,
  );
}
