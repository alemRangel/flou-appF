import 'package:learning/search/search_result.dart';

abstract class Mapper<T> {
  SearchResult<T> transform(dynamic data) {
    if (data != null) {
      return SearchResult(
        params: data['params'],
        nbPages: data['nbPages'],
        hitsPerPage: data['hitsPerPage'],
        processingTimeMs: data['processingTimeMS'],
        page: data['page'],
        query: data['query'],
        parsedQuery: data['parsedQuery'],
        hits: data['hits'].map(transformData).toList().cast<T>(),
      );
    }
    return null;
  }

  T transformData(dynamic data) {
    return null;
  }
}
