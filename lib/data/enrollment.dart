import 'package:learning/data/chapter.dart';
import 'package:learning/data/enrollment_status.dart';
import 'package:learning/data/l_resource.dart';

class Enrollment {
  final String id;
  final String userId;
  final String resourceId;
  final EnrollmentStatus status;
  final LResource resource;
  final Chapter lastChapter;
  final List<String> completedChapters;
  final num progress;

  const Enrollment({
    this.id,
    this.userId,
    this.resourceId,
    this.resource,
    this.status,
    this.lastChapter,
    this.completedChapters,
    this.progress,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['id'],
      userId: json['userId'],
      resourceId: json['resourceId'],
      status: json['status'],
      resource: json['resource'],
      lastChapter: json['lastChapter'],
      completedChapters: json['completedChapters'],
      progress: json['progress'],
    );
  }

}
