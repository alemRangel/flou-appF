import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListItem({
    @required this.category,
    @required this.onTapped,
    this.size,
  });

  final Category category;
  final VoidCallback onTapped;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      _buildGradientBackground(),
      _buildTextualInfo(),
    ];

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      child: InkResponse(
        child: Container(
          width: size?.width,
          height: size?.height,
          decoration: _buildPosterImage(),
          child: Stack(
            alignment: Alignment.center,
            children: content,
          ),
        ),
        onTap: onTapped,
      ),
    );
  }

  Widget _buildTextualInfo() {
    return Text(
      category.name,
      style: const TextStyle(
        fontSize: 22.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
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

  BoxDecoration _buildPosterImage() {
    if (category.imageUrl == null) {
      return null;
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      image: DecorationImage(
        image: NetworkImage(category.imageUrl),
        fit: BoxFit.cover,
      ),
    );
  }
}
