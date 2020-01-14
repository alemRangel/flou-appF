import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class ResourceTypeMapper extends Mapper<ResourceType> {
  @override
  ResourceType transformData(dynamic data) {
    switch (data) {
      case 'Course':
        return CourseResource();
      case 'Book':
        return BookResource();
      default:
        return MeditationResource();
    }
  }
}
