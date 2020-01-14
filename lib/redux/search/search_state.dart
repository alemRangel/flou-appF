import 'package:learning/data/data.dart';
import 'package:learning/search/search_result.dart';
import 'package:meta/meta.dart';

@immutable
class SearchState<T> {
  final SearchResult searchResult;
  final LoadingStatus searchLoadingStatus;
  final String lastQuery;
  final T type;

  SearchState({
    @required this.searchResult,
    @required this.searchLoadingStatus,
    @required this.lastQuery,
    @required this.type,
  });

  factory SearchState.initial(T type) {
    return SearchState(
      searchResult: null,
      searchLoadingStatus: LoadingStatus.loading,
      lastQuery: null,
      type: type,
    );
  }

  SearchState<T> copyWith({
    SearchResult<T> searchResult,
    LoadingStatus searchLoadingStatus,
    String lastQuery,
    T type,
  }) {
    return SearchState<T>(
      searchResult: searchResult ?? this.searchResult,
      searchLoadingStatus: searchLoadingStatus ?? this.searchLoadingStatus,
      lastQuery: lastQuery ?? this.lastQuery,
      type: type ?? this.type,
    );
  }

  @override
  int get hashCode =>
      searchResult.hashCode ^
      searchLoadingStatus.hashCode ^
      lastQuery.hashCode ^
      type.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchState &&
          runtimeType == other.runtimeType &&
          searchResult == other.searchResult &&
          searchLoadingStatus == other.searchLoadingStatus &&
          lastQuery == other.lastQuery &&
          type == other.type;

  @override
  String toString() {
    return '''SearchState<${type.runtimeType}>{
    searchResult: $searchResult,
    searchLoadingStatus: $searchLoadingStatus,
    lastQuery: $lastQuery,
    type: $type
    }''';
  }
}
