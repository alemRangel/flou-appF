import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_actions.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';


class AchievementsPageViewModel{

  AchievementsPageViewModel({
    @required this.view,
  });

  final Function view;

  static AchievementsPageViewModel fromStore(Store<AppState> store){
    return AchievementsPageViewModel(
      view: () => store.dispatch(SignOutAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AchievementsPageViewModel &&
              view == other.view;

  @override
  int get hashCode => view.hashCode;


}
