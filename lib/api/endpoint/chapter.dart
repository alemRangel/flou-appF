import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/endpoint/base.dart';
import 'package:learning/api/mapper/chapter.dart';
import 'package:learning/data/chapter.dart';

class ChapterEndpoint extends Base<Chapter> {
  ChapterEndpoint() : super('chapters', ChapterMapper());

  Future<List<Chapter>> listByResource(String resourceId) {
    return listWithQuery((Query query) => query.where('resourceId', isEqualTo: resourceId).orderBy('priority'));
  }
}
