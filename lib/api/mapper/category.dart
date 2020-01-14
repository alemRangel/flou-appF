import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class CategoryMapper extends Mapper<Category> {
  Mapper<ResourceType> resourceTypeMapper;

  CategoryMapper(this.resourceTypeMapper);

  @override
  Category transformData(dynamic data) {
    return Category(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      type: resourceTypeMapper.transform(data['type']),
    );
  }

  @override
  Category transformTest(dynamic json) {
    return Category.fromJson(json);
  }
}
