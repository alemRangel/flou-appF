import 'package:flutter/material.dart';
import 'package:learning/ui/resource/widget/resource_description_dialog.dart';

class ResourceDescription extends StatelessWidget {
  final String title;
  final String description;

  ResourceDescription({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    if (description == null) return Container();
    return Column(
      children: <Widget>[
        _buildDescription(),
        SizedBox(height: 20.0),
        _buildMore(context),
      ],
    );
  }

  Widget _buildDescription() {
    return Row(
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMore(BuildContext context) {
    return FlatButton(
      child: Text(
        'VER MÁS',
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      textColor: Theme.of(context).primaryColor,
      onPressed: () => _launchDialog(context),
    );
  }

  void _launchDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<DismissDialogAction>(
        builder: (BuildContext context) {
          return ResourceDescriptionDialog(
            title: title,
            description: description,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }
}
