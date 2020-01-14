import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';

class ResourceItem extends StatelessWidget {
  final LResource resource;
  final VoidCallback onTapped;

  const ResourceItem({this.resource, this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: InkResponse(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              child: _buildHero(),
            ),
          ],
        ),
        onTap: onTapped,
      ),
    );
  }

  Widget _buildHero() {
    return Image.network(
      resource.imageUrl,
      height: 182.0,
      width: 140.0,
      fit: BoxFit.cover,
    );
  }
}
