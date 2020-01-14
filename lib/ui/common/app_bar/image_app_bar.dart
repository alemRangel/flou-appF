import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ImageAppBar extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final String label;

  ImageAppBar({@required this.imageUrl, this.label, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.width,
      forceElevated: false,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: heroTag,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildGradientBackground(),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(140, 45, 177, 226),
            Color.fromARGB(140, 50, 12, 63),
          ], // whitish to gray
        ),
      ),
    );
  }
}
