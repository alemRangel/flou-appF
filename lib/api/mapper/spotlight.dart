import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class SpotlightMapper extends Mapper<Spotlight> {
  @override
  Spotlight transformData(dynamic data) {
    return Spotlight(
      actionUrl: data['actionUrl'],
      content: data['content'],
      displayUntil: data['displayUntil'],
      photoUrl: data['photoUrl'],
      publishedAt: data['publishedAt'],
      title: data['title'],
    );
  }
  @override
  Spotlight transformTest(dynamic json) {
    return Spotlight.fromJson(json);
  }
}
