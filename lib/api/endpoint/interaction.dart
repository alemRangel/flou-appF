import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/endpoint/base.dart';
import 'package:learning/api/mapper/interaction.dart';
import 'package:learning/data/interaction.dart';

class InteractionEndpoint extends Base<Interaction> {
  InteractionEndpoint() : super('interactions', InteractionMapper());

  Future<List<Interaction>> listByResource(String userId, String resourceId) {
    return listWithQuery((Query query) => query
        .where('resourceId', isEqualTo: resourceId)
        .where('userId', isEqualTo: userId)
        .where('action', isEqualTo: 'chapter:open'));
  }

  Future<List<Interaction>> listByChapter(String userId, String chapterId) {
    return listWithQuery((Query query) => query
        .where('chapterId', isEqualTo: chapterId)
        .where('userId', isEqualTo: userId));
  }
}
