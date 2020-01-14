import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class ResourceMapper extends Mapper<LResource> {
  Mapper<Author> authorMapper;
  Mapper<ResourceType> resourceTypeMapper;

  ResourceMapper(this.authorMapper, this.resourceTypeMapper);

  @override
  LResource transformData(dynamic data) {
    return LResource(
      id: data['id'] ?? data['objectID'],
      imageUrl: data['imageUrl'],
      landscapeImageUrl: data['landscapeImageUrl'],
      previewVideoUrl: data['previewVideoUrl'],
      shortSynopsis: data['shortSynopsis'],
      synopsis: data['synopsis'],
      title: data['title'],
      topics: data['topics']?.cast<String>() ?? [],
      type: resourceTypeMapper.transform(data['type']),
      chaptersCount: data['chaptersCount'] ?? 0,
      categoryId: data['categoryId'],
      author: authorMapper.transform(
        data['author'],
      ),
    );
  }

  @override
  LResource transformTest(dynamic json) {
    return LResource.fromJson(json);
  }
}
