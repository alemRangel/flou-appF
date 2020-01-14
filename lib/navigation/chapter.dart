import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/ui/chapter/chapter_page.dart';

final chapterHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ChapterPage(id: params["id"][0]);
});
