import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

class CachedFileListItem extends StatelessWidget {
  CachedFileListItem({
    @required this.cachedFile,
    @required this.onTapped,
    @required this.onDeleted,
  });

  final DownloadTask cachedFile;
  final Function onTapped;
  final Function onDeleted;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      customSemanticsActions: <CustomSemanticsAction, VoidCallback>{
        //const CustomSemanticsAction(label: 'Delete'): _handleDelete,
      },
      child: Dismissible(
        key: ObjectKey(cachedFile),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) => onDeleted(),
        background: Container(
          color: Colors.redAccent,
          child: const ListTile(
            leading: Icon(Icons.delete, color: Colors.white, size: 36.0),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.redAccent,
          child: const ListTile(
            trailing: Icon(Icons.delete, color: Colors.white, size: 36.0),
          ),
        ),
        child: _buildItem(context),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 64.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    cachedFile.filename ?? '...',
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _buildAction(),
                ),
              ],
            ),
          ),
          cachedFile.status == DownloadTaskStatus.running ||
                  cachedFile.status == DownloadTaskStatus.paused
              ? _buildProgress(cachedFile.progress)
              : Container()
        ].where((child) => child != null).toList(),
      ),
    );
  }

  Widget _buildProgress(int progress) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: LinearProgressIndicator(
        value: progress / 100,
      ),
    );
  }

  Widget _buildAction() {
    if (cachedFile.status == DownloadTaskStatus.running) {
      return RawMaterialButton(
        onPressed: () => onTapped(DownloadAction.pause),
        child: Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (cachedFile.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () => onTapped(DownloadAction.resume),
        child: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (cachedFile.status == DownloadTaskStatus.complete) {
      return Text(
        'Descargado',
        style: TextStyle(color: Colors.grey),
      );
    } else if (cachedFile.status == DownloadTaskStatus.canceled) {
      return Text('Cancelado', style: TextStyle(color: Colors.red));
    } else if (cachedFile.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Error', style: TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () => onTapped(DownloadAction.retry),
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else {
      return null;
    }
  }
}
