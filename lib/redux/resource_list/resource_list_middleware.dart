import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/resource_list/resource_list_actions.dart';
import 'package:redux/redux.dart';

class ResourceListMiddleware extends MiddlewareClass<AppState> {
  final ResourceEndpoint resourceEndpoint;
  final CategoryEndpoint categoryEndpoint;

  ResourceListMiddleware(this.resourceEndpoint, this.categoryEndpoint);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is FetchCategoryAction) {
      //categoryEndpoint.getTest("Category1").then((Category category) {
        categoryEndpoint.get(action.categoryId).then((Category category) {
          store.dispatch(FetchCategorySucceededAction(category));
      }).catchError((error) {
        store.dispatch(FetchCategoryFailedAction(error));
      });
    } else if (action is FetchResourcesAction) {
      resourceEndpoint
          .listByTypeAndCategory(action.type, action.categoryId)
          .then((List<LResource> resources) {
        store.dispatch(FetchResourcesSucceededAction(action.type, resources));
      }).catchError((error) {
        store.dispatch(FetchResourcesFailedAction(action.type, error));
      });
    }
    next(action);
  }
}
