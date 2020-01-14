import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class EnrollmentMapper extends Mapper<Enrollment> {
  Mapper<LResource> resourceMapper;
  Mapper<Chapter> chapterMapper;
  Mapper<EnrollmentStatus> statusMapper;

  EnrollmentMapper(this.resourceMapper, this.chapterMapper, this.statusMapper);

  @override
  Enrollment transformData(dynamic data) {
    return Enrollment(
      id: data['id'],
      userId: data['userId'],
      resourceId: data['resourceId'],
      status: statusMapper.transform(data['status']),
      progress: data['progress'] ?? 0.0,
      completedChapters: data['completedChapters']?.cast<String>() ?? [],
      resource: resourceMapper.transform(
        data['resource'],
      ),
      lastChapter: chapterMapper.transform(
        data['chapter'],
      ),
    );
  }

  @override
  Enrollment transformTest(dynamic json) {
    return Enrollment.fromJson(json);
  }
}
