import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/auth/auth_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:learning/redux/resource/resource_actions.dart';
import 'package:learning/redux/resource/resource_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ResourcePageViewModel {
  ResourcePageViewModel({
    @required this.authState,
    @required this.resourceState,
    @required this.refreshResource,
    @required this.refreshChapters,
    @required this.enroll,
    @required this.subscribe,
  });

  final AuthState authState;
  final ResourceState resourceState;
  final Function refreshResource;
  final Function refreshChapters;
  final Function enroll;
  final Function subscribe;

  static ResourcePageViewModel fromStore(Store<AppState> store) {
    return ResourcePageViewModel(
      authState: store.state.authState,
      resourceState: store.state.resourceState,
      refreshResource: (String key) => store.dispatch(FetchResourceAction(key)),
      refreshChapters: (String key) => store.dispatch(FetchChaptersAction(key)),
      enroll: (String id) => store.dispatch(EnrollToResourceAction(id)),
      subscribe: () => store.dispatch(NavigateAction(
          '/subscription?navigateTo=%2Fchapters%2F${store.state.resourceState.chapters.first.id}')),
    );
  }

  bool get hasSubscription => authState.user.hasActiveSubscription;
  List<Chapter> get chapters => resourceState.chapters;
  LoadingStatus get chaptersLoadingStatus =>
      resourceState.chaptersLoadingStatus;
  LResource get resource => resourceState.resource;
  LoadingStatus get resourceLoadingStatus =>
      resourceState.resourceLoadingStatus;
  Category get category => resourceState.category;
  Enrollment get enrollment => resourceState.enrollment;
  LoadingStatus get enrollmentLoadingStatus =>
      resourceState.enrollmentLoadingStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResourcePageViewModel &&
          runtimeType == other.runtimeType &&
          resourceState == other.resourceState &&
          refreshResource == other.refreshResource &&
          enroll == other.enroll &&
          refreshChapters == other.refreshChapters;

  @override
  int get hashCode =>
      resourceState.hashCode ^
      enroll.hashCode ^
      refreshResource.hashCode ^
      refreshChapters.hashCode;
}
