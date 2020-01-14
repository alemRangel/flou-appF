import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class ChapterMapper extends Mapper<Chapter> {
  @override
  Chapter transformData(dynamic data) {
    return Chapter(
      id: data['id'],
      title: data['title'],
      content: data['content'],
      wistiaVideoId: data['wistiaVideoId'],
      videoRatio: data['videoRatio'] ?? 1.7777,
      audioUrl: data['audioUrl'],
      resourceId: data['resourceId'],
      downloadVideoUrl: data['downloadVideoUrl'],
    );
  }
  @override
  Chapter transformTest(dynamic data) {
    return Chapter.fromJson(data);
  }
}
