import 'package:flutter/material.dart';
import 'package:learning/utils/assets.dart';
import 'package:meta/meta.dart';

class ResourceThumbnail extends StatelessWidget {
  final String imageUrl;
  final String tag;

  ResourceThumbnail({@required this.imageUrl, this.tag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: FadeInImage(
        image: NetworkImage(imageUrl),
        placeholder: AssetImage(ImageAssets.placeholderImage),
        height: 115.0,
        width: 90.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
