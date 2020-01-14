import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/endpoint/base.dart';
import 'package:learning/api/mapper/author.dart';
import 'package:learning/api/mapper/chapter.dart';
import 'package:learning/api/mapper/enrollment.dart';
import 'package:learning/api/mapper/enrollment_status.dart';
import 'package:learning/api/mapper/resource.dart';
import 'package:learning/api/mapper/resource_type.dart';
import 'package:learning/data/data.dart';

class EnrollmentEndpoint extends Base<Enrollment> {
  EnrollmentEndpoint()
      : super(
            'enrollments',
            EnrollmentMapper(
              ResourceMapper(AuthorMapper(), ResourceTypeMapper()),
              ChapterMapper(),
              EnrollmentStatusMapper(),
            ));

  Future<List<Enrollment>> listWithType(String userId, ResourceType type) {
    return listWithQuery((Query query) => query
        .where('type', isEqualTo: type.queryString())
        .where('userId', isEqualTo: userId));
  }

  Future<Enrollment> getByResource(String userId, String resourceId) {
    return getWithQuery((Query query) => query
        .where('userId', isEqualTo: userId)
        .where('resourceId', isEqualTo: resourceId));
  }

  Future<void> addCompletedChapter(String id, String chapterId) {
    //return update(id, {'completedChapters': FieldValue.arrayUnion([chapterId]),});
    return updateTest('Enrollment1', {'completedChapters':  ["chap1", "chap2"],});
  }

  Future<void> updateProgress(String id, num progress) {
    //return update(id, {'progress': progress});
    return updateTest("Enrollment1", {'progress': 0});
  }
}
