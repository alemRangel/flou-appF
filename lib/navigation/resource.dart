import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/ui/resource/resource_page.dart';

final resourceHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ResourcePage(id: params["id"][0]);
});
