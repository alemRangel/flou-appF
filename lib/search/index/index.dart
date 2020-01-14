import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning/search/mapper/mapper.dart';
import 'package:learning/search/search_result.dart';

class Index<T> {
  final String host = 'DT2BCTNL06-dsn.algolia.net';
  final String indexName;
  final Mapper<T> mapper;

  Index(this.indexName, this.mapper);

  Future<SearchResult<T>> search(String query) async {
    try {
      final response = await _post('indexes/$indexName/query', {
        'query': query,
        'hitsPerPage': 20,
      });

      if (response.statusCode == 200) {
        return mapper.transform(json.decode(response.body));
      } else {
        return null; //throw Exception('Failed to load search results');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<http.Response> _post(String path, dynamic body) {
    return http.post(_buildUrl(path), headers: _buildHeaders(), body: json.encode(body));
  }

  String _buildUrl(String path) {
    return 'https://$host/1/$path';
  }

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'X-Algolia-Application-Id': 'DT2BCTNL06',
      'X-Algolia-API-Key': 'e6ca68554e4e9aef179520ecf4f2cc10',
    };
  }
}
