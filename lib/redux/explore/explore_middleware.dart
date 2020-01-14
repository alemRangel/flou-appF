import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/explore/explore_actions.dart';
import 'package:redux/redux.dart';

class ExploreMiddleware<T extends ResourceType>
    extends MiddlewareClass<AppState> {
  final ResourceEndpoint resourceEndpoint;
  final CategoryEndpoint categoryEndpoint;
  final EnrollmentEndpoint enrollmentEndpoint;

  ExploreMiddleware(
      this.resourceEndpoint, this.categoryEndpoint, this.enrollmentEndpoint);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is FetchFeaturedAction<T>) {
      resourceEndpoint
          .listFeatured(action.type)
          .then((List<LResource> featured) {
        store.dispatch(FetchFeaturedSucceededAction<T>(action.type, featured));
      }).catchError((error) {
        store.dispatch(FetchFeaturedFailedAction<T>(action.type, error));
      });
    } else if (action is FetchRecentAction<T>) {
      resourceEndpoint.listRecent(action.type).then((List<LResource> recent) {
        store.dispatch(FetchRecentSucceededAction<T>(action.type, recent));
      }).catchError((error) {
        store.dispatch(FetchRecentFailedAction<T>(action.type, error));
      });
    } else if (action is FetchCategoriesAction<T>) {
      categoryEndpoint
          .listWithType(action.type)
          .then((List<Category> categories) {
        store.dispatch(
            FetchCategoriesSucceededAction<T>(action.type, categories));
      }).catchError((error) {
        store.dispatch(FetchCategoriesFailedAction<T>(action.type, error));
      });
    } else if (action is FetchEnrollmentsAction<T>) {
      enrollmentEndpoint
          .listWithType(store.state.authState.user?.uid ?? '', action.type)
          .then((List<Enrollment> enrollments) {
        store.dispatch(
            FetchEnrollmentsSucceededAction<T>(action.type, enrollments));
      }).catchError((error) {
        store.dispatch(FetchEnrollmentsFailedAction<T>(action.type, error));
      });
    }
    next(action);
  }
}
