import 'package:learning/data/resource_type.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final ResourceType type;

  const Category(
      {this.id, this.name, this.description, this.imageUrl, this.type});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      type: json['type'],
    );
  }
}
