import 'package:learning/data/data.dart';

class InitAuthAction {}

class UserUpdatedAction {
  final User user;

  UserUpdatedAction(this.user);
}

class InitAuthFailedAction {}

class SignInWithProviderAction {
  SignInProvider provider;

  SignInWithProviderAction(this.provider);
}

class SignInWithPasswordAction {
  String email;
  String password;

  SignInWithPasswordAction(this.email, this.password);
}

class SignUpWithPasswordAction {
  String email;
  String password;

  SignUpWithPasswordAction(this.email, this.password);
}

class SignInSucceededAction {
  final User user;

  SignInSucceededAction(this.user);
}

class SignInFailedAction {
  final Exception error;

  SignInFailedAction(this.error);
}

class SignOutAction {}

class ResetPasswordAction {
  final String email;

  ResetPasswordAction(this.email);
}

class SubscribeUserAction {
  final String id;

  SubscribeUserAction(this.id);
}
