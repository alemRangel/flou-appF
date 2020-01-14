import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:learning/redux/search/search_actions.dart';
import 'package:learning/redux/search/search_state.dart';
import 'package:learning/search/search.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SearchPageViewModel {
  SearchPageViewModel({
    @required this.searchState,
    @required this.search,
    @required this.resourceSelected,
  });

  final SearchState<LResource> searchState;
  final Function search;
  final Function resourceSelected;

  static SearchPageViewModel fromStore(Store<AppState> store) {
    return SearchPageViewModel(
      searchState: store.state.searchState,
      search: (String query) {
        if (store.state.searchState.lastQuery != query) {
          store.dispatch(FetchSearchAction<LResource>(query));
        }
      },
      resourceSelected: (String resourceId) =>
          store.dispatch(NavigateAction('/resources/$resourceId')),
    );
  }

  SearchResult get searchResult => searchState.searchResult;
  LoadingStatus get searchLoadingStatus => searchState.searchLoadingStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchPageViewModel &&
          runtimeType == other.runtimeType &&
          searchState == other.searchState &&
          search == other.search &&
          resourceSelected == other.resourceSelected;

  @override
  int get hashCode =>
      searchState.hashCode ^ search.hashCode ^ resourceSelected.hashCode;
}
