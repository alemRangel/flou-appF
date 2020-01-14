import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ExplorePageViewModel<T extends ResourceType> {
  ExplorePageViewModel({
    @required this.authState,
    @required this.navigateTo,
  });

  final AuthState authState;
  final Function navigateTo;

  static ExplorePageViewModel<E> fromStore<E extends ResourceType>(
      Store<AppState> store, E type) {
    return ExplorePageViewModel(
      authState: store.state.authState,
      navigateTo: (String route) => store.dispatch(NavigateAction(route)),
    );
  }

  String get avatarUrl => authState.user.photoUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExplorePageViewModel &&
          runtimeType == other.runtimeType &&
          authState == other.authState &&
          navigateTo == other.navigateTo;

  @override
  int get hashCode => authState.hashCode ^ navigateTo.hashCode;
}
