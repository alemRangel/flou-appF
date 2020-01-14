import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:meta/meta.dart';

import 'cached_file_list_item.dart';

class CachedFileList extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  CachedFileList({
    @required this.cachedFiles,
    @required this.onReloadCallback,
    @required this.onItemSelected,
    @required this.onItemDeleted,
  });

  final List<DownloadTask> cachedFiles;
  final VoidCallback onReloadCallback;
  final Function onItemSelected;
  final Function onItemDeleted;

  Widget _buildContent(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: cachedFiles.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return CachedFileListItem(
            cachedFile: cachedFiles[index],
            onTapped: (DownloadAction action) =>
                onItemSelected(cachedFiles[index], action),
            onDeleted: () => onItemDeleted(cachedFiles[index]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cachedFiles.isEmpty) {
      return InfoMessageView(
        key: emptyViewKey,
        title: 'Vacío',
        description: 'No has descargado ningún\ncurso`. ¯\\_(ツ)_/¯',
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _buildContent(context);
  }
}
