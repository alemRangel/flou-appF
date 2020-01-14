import 'package:flutter/material.dart';
import 'package:learning/utils/assets.dart';

class ResourceCover extends StatelessWidget {
  final double _appBarHeight = 175.0;
  final String imageUrl;

  ResourceCover(this.imageUrl);

  Widget _cover() {
    return FadeInImage(
      image: imageUrl == null
          ? AssetImage(ImageAssets.placeholderImage)
          : NetworkImage(imageUrl),
      placeholder: AssetImage(ImageAssets.placeholderImage),
      fit: BoxFit.cover,
      height: _appBarHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: _appBarHeight,
      pinned: false,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _cover(),
            const DecoratedBox(
              decoration: const BoxDecoration(
                gradient: const LinearGradient(
                  begin: const Alignment(0.0, -1.0),
                  end: const Alignment(0.0, -0.4),
                  colors: const <Color>[
                    const Color(0x60000000),
                    const Color(0x00000000)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
