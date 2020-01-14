import 'package:flutter/material.dart';

class ProgressDrawerHeader extends StatefulWidget {
  final String headerImageUrl;
  final String headerTitle;

  ProgressDrawerHeader({this.headerTitle, this.headerImageUrl});

  @override
  _ProgressDrawerHeaderState createState() => _ProgressDrawerHeaderState();
}

class _ProgressDrawerHeaderState extends State<ProgressDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          widget.headerImageUrl == null ? Theme.of(context).primaryColor : null,
      decoration: widget.headerImageUrl == null
          ? null
          : BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.headerImageUrl),
                fit: BoxFit.cover,
              ),
            ),
      constraints: const BoxConstraints.expand(height: 175.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _buildHeaderInfo(context),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              widget.headerTitle ?? '',
              style: textTheme.display1
                  .copyWith(color: Colors.white, fontSize: 24.0),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
