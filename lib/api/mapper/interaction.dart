import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class InteractionMapper extends Mapper<Interaction> {
  @override
  Interaction transformData(dynamic data) {
    return Interaction(
      id: data['id'] ?? data['objectID'],
      userId: data['userId'],
      resourceId: data['resourceId'],
      chapterId: data['userId'],
      action: data['action'],
      happenedAt: data['happenedAt'],
    );
  }
  @override
  Interaction transformTest(dynamic json) {
    return Interaction.fromJson(json);
  }
}
