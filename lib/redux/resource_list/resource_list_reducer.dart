import 'package:learning/data/data.dart';
import 'package:learning/redux/resource_list/resource_list_actions.dart';
import 'package:learning/redux/resource_list/resource_list_state.dart';
import 'package:redux/redux.dart';

var resourceListReducer = combineReducers<ResourceListState>([
  TypedReducer<ResourceListState, FetchCategoryAction>(_fetchCategory),
  TypedReducer<ResourceListState, FetchCategorySucceededAction>(_setCategory),
  TypedReducer<ResourceListState, FetchCategoryFailedAction>(_setCategoryError),
  TypedReducer<ResourceListState, FetchResourcesAction>(_fetchResources),
  TypedReducer<ResourceListState, FetchResourcesSucceededAction>(_setResources),
  TypedReducer<ResourceListState, FetchResourcesFailedAction>(
      _setResourcesError),
]);

ResourceListState _fetchCategory(
    ResourceListState state, FetchCategoryAction action) {
  return state.copyWith(
    category: null,
    categoryLoadingStatus: LoadingStatus.loading,
  );
}

ResourceListState _setCategory(
    ResourceListState state, FetchCategorySucceededAction action) {
  return state.copyWith(
    category: action.category,
    categoryLoadingStatus: LoadingStatus.success,
  );
}

ResourceListState _setCategoryError(
    ResourceListState state, FetchCategoryFailedAction action) {
  return state.copyWith(
    category: null,
    categoryLoadingStatus: LoadingStatus.error,
  );
}

ResourceListState _fetchResources(
    ResourceListState state, FetchResourcesAction action) {
  return state.copyWith(
    resources: [],
    resourcesLoadingStatus: LoadingStatus.loading,
    type: action.type,
  );
}

ResourceListState _setResources(
    ResourceListState state, FetchResourcesSucceededAction action) {
  return state.copyWith(
    resources: action.resources,
    resourcesLoadingStatus: LoadingStatus.success,
  );
}

ResourceListState _setResourcesError(
    ResourceListState state, FetchResourcesFailedAction action) {
  return state.copyWith(
    resources: [],
    resourcesLoadingStatus: LoadingStatus.error,
  );
}
