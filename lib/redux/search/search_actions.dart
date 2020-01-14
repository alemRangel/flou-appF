import 'package:learning/search/search.dart';

class FetchSearchAction<T> {
  String query;

  FetchSearchAction(this.query);
}

class FetchSearchSucceededAction<T> {
  final SearchResult<T> result;

  FetchSearchSucceededAction(this.result);
}

class FetchSearchFailedAction<T> {
  final Exception error;

  FetchSearchFailedAction(this.error);
}
