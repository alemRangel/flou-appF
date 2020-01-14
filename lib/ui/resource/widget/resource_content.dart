import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/resource/widget/resource_description.dart';
import 'package:learning/ui/resource/widget/resource_stats.dart';
import 'package:learning/ui/resource/widget/resource_thumbnail.dart';
import 'package:meta/meta.dart';

class ResourceContent extends StatelessWidget {
  final LResource resource;
  final Category category;
  final Enrollment enrollment;
  final LoadingStatus enrollmentLoadingStatus;
  final VoidCallback onActionTap;

  ResourceContent({
    @required this.resource,
    @required this.enrollment,
    @required this.enrollmentLoadingStatus,
    this.category,
    this.onActionTap,
  });

  Widget _buildThumbnail(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          child: ResourceThumbnail(
            imageUrl: resource?.imageUrl,
            tag: resource?.id,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (resource == null) return Container();

    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            margin: EdgeInsets.only(top: 30.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: _buildThumbnail(context),
                  title: Text(
                    resource.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(resource.author.name),
                      ),
                      Text('${resource.chaptersCount} cápitulos'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      _buildHeader(context),
                      Divider(height: 40.0),
                      ResourceStats(
                          category: category, topics: resource.topics),
                      Divider(height: 40.0),
                      SizedBox(height: 20.0),
                      ResourceDescription(
                        title: resource.title,
                        description: resource.synopsis,
                      ),
                    ].where((o) => o != null).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _buildAction(context),
            SizedBox(height: 10.0),
            Text(
              'Contiene video - audio',
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAction(BuildContext context) {
    return LoadingView(
      status: enrollmentLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: _buildActionButton(context),
      successContent: _buildActionButton(context),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    String label = enrollment == null ? _buildStart() : 'Continuar';
    return RaisedButton(
      elevation: 0.0,
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(label),
      onPressed: onActionTap,
    );
  }

  String _buildStart() {
    if (resource.type is BookResource) {
      return 'Empezar libro';
    } else if (resource.type is MeditationResource) {
      return 'Empezar meditación';
    } else {
      return 'Empezar curso';
    }
  }
}
