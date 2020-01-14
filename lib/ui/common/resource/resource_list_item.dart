import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

class ResourceListItem extends StatelessWidget {
  final LResource resource;
  final VoidCallback onTapped;
  final VoidCallback onDownload;

  ResourceListItem({@required this.resource, this.onTapped, this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Hero(
          tag: resource.id ?? '',
          child: Image.network(
            resource.imageUrl,
            width: 55.0,
            height: 55.0,
          ),
        ),
        title: Text(
          resource.title,
          maxLines: 1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          resource.author.name,
          maxLines: 1,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
        onTap: onTapped,
      ),
    );
  }
}
