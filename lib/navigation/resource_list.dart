import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/ui/resource_list/resource_list_page.dart';
import 'package:learning/api/mapper/resource_type.dart';

final resourceListHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  var resourceType = ResourceTypeMapper().transform(params["type"][0]);
  var categoryId = params["categoryId"][0];
  return ResourceListPage(
    type: resourceType,
    categoryId: categoryId,
  );
});
