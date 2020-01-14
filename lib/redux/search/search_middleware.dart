import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/search/search_actions.dart';
import 'package:learning/search/search.dart';
import 'package:redux/redux.dart';

class SearchMiddleware<T> extends MiddlewareClass<AppState> {
  final Index<T> index;

  SearchMiddleware(this.index);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is FetchSearchAction<T>) {
      index.search(action.query).then((SearchResult<T> searchResult) {
        store.dispatch(FetchSearchSucceededAction(searchResult));
      }).catchError((error) {
        store.dispatch(FetchSearchFailedAction(error));
      });
    }
    next(action);
  }
}
