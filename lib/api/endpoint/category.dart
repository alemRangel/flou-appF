import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/endpoint/base.dart';
import 'package:learning/api/mapper/category.dart';
import 'package:learning/api/mapper/resource_type.dart';
import 'package:learning/data/data.dart';

class CategoryEndpoint extends Base<Category> {
  CategoryEndpoint() : super('categories', CategoryMapper(ResourceTypeMapper()));

  Future<List<Category>> listWithType(ResourceType type) async {
    return listWithQuery(
        (Query query) => query.where('type', isEqualTo: type.queryString()));
  }
}
