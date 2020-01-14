import 'package:learning/data/author.dart';
import 'package:learning/data/resource_type.dart';

class LResource {
  final String id;
  final String imageUrl;
  final String landscapeImageUrl;
  final String previewVideoUrl;
  final String shortSynopsis;
  final String synopsis;
  final String title;
  final List<String> topics;
  final ResourceType type;
  final int chaptersCount;
  final String categoryId;
  final Author author;

  const LResource({
    this.id,
    this.imageUrl,
    this.landscapeImageUrl,
    this.shortSynopsis,
    this.previewVideoUrl,
    this.synopsis,
    this.title,
    this.topics,
    this.type,
    this.chaptersCount,
    this.categoryId,
    this.author,
  });

  factory LResource.fromJson(Map<String, dynamic> json) {
    return LResource(
      id: json['id'],
      imageUrl: json['imageUrl'],
      landscapeImageUrl: json['landscapeImageUrl'],
      shortSynopsis: json['shortSynopsis'],
      previewVideoUrl: json['previewVideoUrl'],
      synopsis: json['synopsis'],
      title: json['title'],
      topics: json['topics'],
      type: json['type'],
      chaptersCount: json['chaptersCount'],
      categoryId: json['categoryId'],
      author: json['author'],
    );
  }
}
