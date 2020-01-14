import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/ui/cached_files/cached_files_page.dart';

final cachedFilesHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CachedFilesPage(platform: TargetPlatform.android);
});
