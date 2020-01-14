import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/endpoint/base.dart';
import 'package:learning/api/mapper/author.dart';
import 'package:learning/api/mapper/resource.dart';
import 'package:learning/api/mapper/resource_type.dart';
import 'package:learning/data/data.dart';

class ResourceEndpoint extends Base<LResource> {
  ResourceEndpoint() : super('resources', ResourceMapper(AuthorMapper(), ResourceTypeMapper()));

  Future<List<LResource>> listByType(ResourceType type) {
    return listWithQuery(
        (Query query) => query.where('type', isEqualTo: type.queryString()));
  }

  Future<List<LResource>> listByTypeAndCategory(
      ResourceType type, String categoryId) {
    return listWithQuery((Query query) => query
        .where('type', isEqualTo: type.queryString())
        .where('categoryId', isEqualTo: categoryId));
  }

  Future<List<LResource>> listFeatured(ResourceType type) async {
    return listWithQuery((Query query) => query
        .where('type', isEqualTo: type.queryString())
        .where('featured', isEqualTo: true)
        .orderBy('featuredPriority'));
  }

  Future<List<LResource>> listRecent(ResourceType type) async {
    return listWithQuery((Query query) => query
        .where('type', isEqualTo: type.queryString())
        .orderBy('publishedAt', descending: true)
        .limit(20));
  }
}
