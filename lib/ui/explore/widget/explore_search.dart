import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';

class ExploreSearch extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final SearchDelegate<LResource> delegate;
  final VoidCallback onTapped;
  final String avatarUrl;

  ExploreSearch(
      {this.scaffoldKey, this.delegate, this.onTapped, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.only(top: 10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              alignment: Alignment(
                2.4,
                -1.4,
              ),
              children: <Widget>[
                GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                    radius: 14.0,
                  ),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: InkWell(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Buscar...',
                  ),
                  enabled: false,
                ),
                onTap: onTapped,
              ),
            ),
            Icon(
              Icons.mic,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
