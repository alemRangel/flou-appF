import 'package:learning/data/data.dart';
import 'package:learning/redux/resource/resource_actions.dart';
import 'package:learning/redux/resource/resource_state.dart';
import 'package:redux/redux.dart';

final resourceReducer = combineReducers<ResourceState>([
  TypedReducer<ResourceState, FetchResourceAction>(_fetchResource),
  TypedReducer<ResourceState, FetchResourceSucceededAction>(_setResource),
  TypedReducer<ResourceState, FetchResourceFailedAction>(_setResourceError),
  TypedReducer<ResourceState, FetchEnrollmentAction>(_fetchEnrollment),
  TypedReducer<ResourceState, FetchEnrollmentSucceededAction>(_setEnrollment),
  TypedReducer<ResourceState, FetchEnrollmentFailedAction>(_setEnrollmentError),
  TypedReducer<ResourceState, FetchCategoryAction>(_fetchCategory),
  TypedReducer<ResourceState, FetchCategorySucceededAction>(_setCategory),
  TypedReducer<ResourceState, FetchCategoryFailedAction>(_setCategoryError),
  TypedReducer<ResourceState, FetchChaptersAction>(_fetchChapters),
  TypedReducer<ResourceState, FetchChaptersSucceededAction>(_setChapters),
  TypedReducer<ResourceState, FetchChaptersFailedAction>(_setChaptersError),
  TypedReducer<ResourceState, EnrollToResourceAction>(_enrollToResource),
]);

ResourceState _fetchResource(ResourceState state, FetchResourceAction action) {
  return state.copyWith(
    resource: null,
    resourceLoadingStatus: LoadingStatus.loading,
  );
}

ResourceState _setResource(
    ResourceState state, FetchResourceSucceededAction action) {
  return state.copyWith(
    resource: action.resource,
    resourceLoadingStatus: LoadingStatus.success,
  );
}

ResourceState _setResourceError(
    ResourceState state, FetchResourceFailedAction action) {
  return state.copyWith(
    resource: null,
    resourceLoadingStatus: LoadingStatus.error,
  );
}

ResourceState _fetchEnrollment(
    ResourceState state, FetchEnrollmentAction action) {
  return state.copyWith(
    enrollmentNull: true,
    enrollment: null,
    enrollmentLoadingStatus: LoadingStatus.loading,
  );
}

ResourceState _setEnrollment(
    ResourceState state, FetchEnrollmentSucceededAction action) {
  return state.copyWith(
    enrollmentNull: action.enrollment == null,
    enrollment: action.enrollment,
    enrollmentLoadingStatus: LoadingStatus.success,
  );
}

ResourceState _setEnrollmentError(
    ResourceState state, FetchEnrollmentFailedAction action) {
  return state.copyWith(
    enrollmentNull: true,
    enrollment: null,
    enrollmentLoadingStatus: LoadingStatus.error,
  );
}

ResourceState _fetchCategory(ResourceState state, FetchCategoryAction action) {
  return state;
}

ResourceState _setCategory(
    ResourceState state, FetchCategorySucceededAction action) {
  return state.copyWith(
    category: action.category,
  );
}

ResourceState _setCategoryError(
    ResourceState state, FetchCategoryFailedAction action) {
  return state.copyWith(
    category: null,
  );
}

ResourceState _fetchChapters(ResourceState state, FetchChaptersAction action) {
  return state.copyWith(
    chaptersLoadingStatus: LoadingStatus.loading,
  );
}

ResourceState _setChapters(
    ResourceState state, FetchChaptersSucceededAction action) {
  return state.copyWith(
    chapters: action.chapters,
    chaptersLoadingStatus: LoadingStatus.success,
  );
}

ResourceState _setChaptersError(
    ResourceState state, FetchChaptersFailedAction action) {
  return state.copyWith(
    chapters: [],
    chaptersLoadingStatus: LoadingStatus.error,
  );
}

ResourceState _enrollToResource(
    ResourceState state, EnrollToResourceAction action) {
  return state.copyWith(
    enrollment: null,
    enrollmentLoadingStatus: LoadingStatus.loading,
  );
}
