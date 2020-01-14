import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_actions.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SettingsPageViewModel {
  SettingsPageViewModel({
    @required this.logout,
    @required this.navigateToReferral,
  });

  final Function logout;
  final Function navigateToReferral;

  static SettingsPageViewModel fromStore(Store<AppState> store) {
    return SettingsPageViewModel(
      logout: () => store.dispatch(SignOutAction()),
      navigateToReferral: () => store.dispatch(NavigateAction('/referral')),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsPageViewModel &&
          runtimeType == other.runtimeType &&
          logout == other.logout;

  @override
  int get hashCode => logout.hashCode;
}
