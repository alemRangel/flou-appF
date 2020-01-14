class SearchResult<T> {
  final int page;
  final int nbPages;
  final int hitsPerPage;
  final int processingTimeMs;
  final String query;
  final String parsedQuery;
  final String params;
  final List<T> hits;

  const SearchResult({
    this.page,
    this.nbPages,
    this.hitsPerPage,
    this.processingTimeMs,
    this.query,
    this.parsedQuery,
    this.params,
    this.hits,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult<T>(
      page: json['page'],
      nbPages: json['nbPages'],
      hitsPerPage: json['hitsPerPage'],
      processingTimeMs: json['processingTimeMs'],
      query: json['query'],
      parsedQuery: json['parsedQuery'],
      params: json['params'],
      hits: json['hits'],
    );
  }
}
