import 'package:learning/data/data.dart';
import 'package:learning/redux/explore/explore_actions.dart';
import 'package:learning/redux/explore/explore_state.dart';
import 'package:redux/redux.dart';

class ExploreReducer<T extends ResourceType> {
  Function reducer;

  ExploreReducer() {
    reducer = combineReducers<ExploreState<T>>([
      TypedReducer<ExploreState<T>, FetchCategoriesAction<T>>(_fetchCategories),
      TypedReducer<ExploreState<T>, FetchCategoriesSucceededAction<T>>(
          _setCategories),
      TypedReducer<ExploreState<T>, FetchCategoriesFailedAction<T>>(
          _setCategoriesError),
      TypedReducer<ExploreState<T>, FetchEnrollmentsAction<T>>(
          _fetchEnrollments),
      TypedReducer<ExploreState<T>, FetchEnrollmentsSucceededAction<T>>(
          _setEnrollments),
      TypedReducer<ExploreState<T>, FetchEnrollmentsFailedAction<T>>(
          _setEnrollmentsError),
      TypedReducer<ExploreState<T>, FetchFeaturedAction<T>>(_fetchFeatured),
      TypedReducer<ExploreState<T>, FetchFeaturedSucceededAction<T>>(
          _setFeatured),
      TypedReducer<ExploreState<T>, FetchFeaturedFailedAction<T>>(
          _setFeaturedError),
      TypedReducer<ExploreState<T>, FetchRecentAction<T>>(_fetchRecent),
      TypedReducer<ExploreState<T>, FetchRecentSucceededAction<T>>(_setRecent),
      TypedReducer<ExploreState<T>, FetchRecentFailedAction<T>>(
          _setRecentError),
    ]);
  }

  ExploreState<T> _fetchCategories(
      ExploreState<T> state, FetchCategoriesAction<T> action) {
    return state.copyWith(
      categories: [],
      categoriesLoadingStatus: LoadingStatus.loading,
      type: action.type,
    );
  }

  ExploreState<T> _setCategories(
      ExploreState<T> state, FetchCategoriesSucceededAction<T> action) {
    return state.copyWith(
      categories: action.categories,
      categoriesLoadingStatus: LoadingStatus.success,
    );
  }

  ExploreState<T> _setCategoriesError(
      ExploreState<T> state, FetchCategoriesFailedAction<T> action) {
    return state.copyWith(
      categories: [],
      categoriesLoadingStatus: LoadingStatus.error,
    );
  }

  ExploreState<T> _fetchEnrollments(
      ExploreState<T> state, FetchEnrollmentsAction<T> action) {
    return state.copyWith(
      enrollments: [],
      enrollmentsLoadingStatus: LoadingStatus.loading,
      type: action.type,
    );
  }

  ExploreState<T> _setEnrollments(
      ExploreState<T> state, FetchEnrollmentsSucceededAction<T> action) {
    return state.copyWith(
      enrollments: action.enrollments,
      enrollmentsLoadingStatus: LoadingStatus.success,
    );
  }

  ExploreState<T> _setEnrollmentsError(
      ExploreState<T> state, FetchEnrollmentsFailedAction<T> action) {
    return state.copyWith(
      enrollments: [],
      enrollmentsLoadingStatus: LoadingStatus.error,
    );
  }

  ExploreState<T> _fetchFeatured(
      ExploreState<T> state, FetchFeaturedAction<T> action) {
    return state.copyWith(
      featured: [],
      featuredLoadingStatus: LoadingStatus.loading,
      type: action.type,
    );
  }

  ExploreState<T> _setFeatured(
      ExploreState<T> state, FetchFeaturedSucceededAction<T> action) {
    return state.copyWith(
      featured: action.featured,
      featuredLoadingStatus: LoadingStatus.success,
    );
  }

  ExploreState<T> _setFeaturedError(
      ExploreState<T> state, FetchFeaturedFailedAction<T> action) {
    return state.copyWith(
      featured: [],
      featuredLoadingStatus: LoadingStatus.error,
    );
  }

  ExploreState<T> _fetchRecent(
      ExploreState<T> state, FetchRecentAction<T> action) {
    return state.copyWith(
      recent: [],
      recentLoadingStatus: LoadingStatus.loading,
      type: action.type,
    );
  }

  ExploreState<T> _setRecent(
      ExploreState<T> state, FetchRecentSucceededAction<T> action) {
    return state.copyWith(
      recent: action.recent,
      recentLoadingStatus: LoadingStatus.success,
    );
  }

  ExploreState<T> _setRecentError(
      ExploreState<T> state, FetchRecentFailedAction<T> action) {
    return state.copyWith(
      recent: [],
      recentLoadingStatus: LoadingStatus.error,
    );
  }
}
