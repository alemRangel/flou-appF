import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/cached_files/cached_files_actions.dart';
import 'package:learning/redux/explore/explore_actions.dart';
import 'package:learning/redux/explore/explore_selectors.dart';
import 'package:learning/redux/explore/explore_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class LibraryTabViewModel<T extends ResourceType> {
  LibraryTabViewModel({
    @required this.exploreState,
    @required this.refreshEnrollments,
    @required this.enrollmentSelected,
    @required this.downloadFiles,
  });

  final ExploreState exploreState;
  final Function refreshEnrollments;
  final Function enrollmentSelected;
  final Function downloadFiles;

  static LibraryTabViewModel<E> fromStore<E extends ResourceType>(
      Store<AppState> store, E type) {
    return LibraryTabViewModel(
      exploreState: exploreSelector(store.state, type),
      refreshEnrollments: (ResourceType key) =>
          store.dispatch(FetchEnrollmentsAction(key)),
      enrollmentSelected: (String resourceId) =>
          store.dispatch(NavigateAction('/resources/$resourceId')),
      downloadFiles: (String resourceId) =>
          store.dispatch(EnqueueResourceAction(resourceId)),
    );
  }

  List<Enrollment> get enrollments => exploreState.enrollments;
  LoadingStatus get enrollmentsLoadingStatus =>
      exploreState.enrollmentsLoadingStatus;
  T get type => exploreState.type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibraryTabViewModel &&
          runtimeType == other.runtimeType &&
          exploreState == other.exploreState &&
          refreshEnrollments == other.refreshEnrollments;

  @override
  int get hashCode => exploreState.hashCode ^ refreshEnrollments.hashCode;
}
