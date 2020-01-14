import 'dart:async';

import 'package:learning/api/mapper/author.dart';
import 'package:learning/api/mapper/chapter.dart';
import 'package:learning/api/mapper/enrollment.dart';
import 'package:learning/api/mapper/enrollment_status.dart';
import 'package:learning/api/mapper/resource.dart';
import 'package:learning/api/mapper/resource_type.dart';
import 'package:learning/data/data.dart';

import 'rpc.dart';

class CreateEnrollment extends Rpc {
  Future<Enrollment> call(String resourceId) async {
    try {
      dynamic data = await callFunction('createEnrollment', {
        'resourceId': resourceId,
      });
      return EnrollmentMapper(
        ResourceMapper(AuthorMapper(), ResourceTypeMapper()),
        ChapterMapper(),
        EnrollmentStatusMapper(),
      ).transform(data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
