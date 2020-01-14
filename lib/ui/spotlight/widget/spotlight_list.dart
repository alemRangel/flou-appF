import 'package:flutter/material.dart';
import 'package:learning/data/spotlight.dart';
import 'package:learning/utils/assets.dart';
import 'package:meta/meta.dart';

class SpotlightList extends StatelessWidget {
  final List<Spotlight> spotlights;
  final Function onItemSelected;

  SpotlightList({@required this.spotlights, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: spotlights.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(12.0),
            child: MediaListItem(
              spotlight: spotlights[index],
              onTap: () => onItemSelected(spotlights[index]),
            ),
          );
        },
      ),
    );
  }
}

class MediaListItem extends StatelessWidget {
  final Spotlight spotlight;
  final VoidCallback onTap;

  MediaListItem({this.spotlight, this.onTap});

  Widget _getTitleSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              spotlight.title,
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              spotlight.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.body1,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: ImageAssets.transparentImage,
              image: spotlight.photoUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
              fadeInDuration: Duration(milliseconds: 50),
            ),
            _getTitleSection(context),
          ],
        ),
      ),
    );
  }
}
