import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

class EnrollmentListItem extends StatelessWidget {
  final Enrollment enrollment;
  final VoidCallback onTapped;
  final VoidCallback onDownload;

  EnrollmentListItem(
      {@required this.enrollment, this.onTapped, this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildContent(context),
        _buildProgress(enrollment.progress),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Hero(
          tag: enrollment.id ?? '',
          child: Image.network(
            enrollment.resource.imageUrl,
            width: 55.0,
            height: 55.0,
          ),
        ),
        title: Text(
          enrollment.resource.title,
          maxLines: 1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          enrollment.resource.author.name,
          maxLines: 1,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
        trailing: PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          onSelected: (String value) => onDownload(),
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Preview',
                child: ListTile(
                    leading: Icon(Icons.file_download),
                    title: Text('Descargar')),
              ),
            ];
          },
        ),
        onTap: onTapped,
      ),
    );
  }

  Widget _buildProgress(num progress) {
    return Positioned(
      left: 15.0,
      right: 15.0,
      bottom: 0.0,
      child: LinearProgressIndicator(
        value: progress,
      ),
    );
  }
}
