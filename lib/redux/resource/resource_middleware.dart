import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:learning/redux/resource/resource_actions.dart';
import 'package:redux/redux.dart';

class ResourceMiddleware extends MiddlewareClass<AppState> {
  ResourceEndpoint resourceEndpoint;
  ChapterEndpoint chapterEndpoint;
  CategoryEndpoint categoryEndpoint;
  EnrollmentEndpoint enrollmentEndpoint;
  CreateEnrollment createEnrollment;

  ResourceMiddleware(
    this.resourceEndpoint,
    this.chapterEndpoint,
    this.categoryEndpoint,
    this.enrollmentEndpoint,
    this.createEnrollment,
  );

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is FetchResourceAction) {
      //resourceEndpoint.getTest("id1").then((LResource resource) {
       resourceEndpoint.get(action.resourceId).then((LResource resource) {
          store.dispatch(FetchResourceSucceededAction(resource));
        store.dispatch(FetchCategoryAction(resource.categoryId));
      }).catchError((error) {
        store.dispatch(FetchResourceFailedAction(error));
      });
    } else if (action is FetchChaptersAction) {
      chapterEndpoint
          .listByResource(action.resourceId)
          .then((List<Chapter> chapters) {
        store.dispatch(FetchChaptersSucceededAction(chapters));
      }).catchError((error) {
        store.dispatch(FetchChaptersFailedAction(error));
      });
    } else if (action is FetchCategoryAction) {
      //categoryEndpoint.getTest("Category1").then((Category category) {
        categoryEndpoint.get(action.categoryId).then((Category category) {
          store.dispatch(FetchCategorySucceededAction(category));
      }).catchError((error) {
        store.dispatch(FetchCategoryFailedAction(error));
      });
    } else if (action is FetchEnrollmentAction) {
      enrollmentEndpoint
          .getByResource(store.state.authState.user.uid, action.resourceId)
          .then((Enrollment enrollment) {
        store.dispatch(FetchEnrollmentSucceededAction(enrollment));
      }).catchError((error) {
        store.dispatch(FetchEnrollmentFailedAction(error));
      });
    } else if (action is EnrollToResourceAction) {
      createEnrollment.call(action.resourceId).then((Enrollment enrollment) {
        store.dispatch(FetchEnrollmentSucceededAction(enrollment));
        if (store.state.resourceState.chapters.isNotEmpty) {
          String chapterId = store.state.resourceState.chapters.first.id;
          store.dispatch(NavigateAction('chapters/$chapterId'));
        }
      }).catchError((error) {
        store.dispatch(FetchEnrollmentFailedAction(error));
      });
    }
    next(action);
  }
}
