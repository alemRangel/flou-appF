import 'package:learning/data/data.dart';
import 'package:learning/redux/search/search_actions.dart';
import 'package:learning/redux/search/search_state.dart';
import 'package:redux/redux.dart';

class SearchReducer<T> {
  Function reducer;

  SearchReducer() {
    reducer = combineReducers<SearchState<T>>([
      TypedReducer<SearchState<T>, FetchSearchAction<T>>(_fetchSearch),
      TypedReducer<SearchState<T>, FetchSearchSucceededAction<T>>(
          _setSearchResult),
      TypedReducer<SearchState<T>, FetchSearchFailedAction<T>>(_setSearchError),
    ]);
  }

  SearchState<T> _fetchSearch(
      SearchState<T> state, FetchSearchAction<T> action) {
    return state.copyWith(
      searchLoadingStatus: LoadingStatus.loading,
      lastQuery: action.query,
    );
  }

  SearchState<T> _setSearchResult(
      SearchState<T> state, FetchSearchSucceededAction<T> action) {
    return state.copyWith(
      searchResult: action.result,
      searchLoadingStatus: LoadingStatus.success,
    );
  }

  SearchState<T> _setSearchError(
      SearchState<T> state, FetchSearchFailedAction<T> action) {
    return state.copyWith(
      searchResult: null,
      searchLoadingStatus: LoadingStatus.error,
    );
  }
}
