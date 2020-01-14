import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:meta/meta.dart';

class ResourceList extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  ResourceList({
    @required this.resources,
    @required this.onReloadCallback,
    @required this.onItemSelected,
    this.onDownload,
  });

  final List<LResource> resources;
  final VoidCallback onReloadCallback;
  final Function onItemSelected;
  final Function onDownload;

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: resources.length,
      itemBuilder: (BuildContext context, int index) {
        return ResourceListItem(
          resource: resources[index],
          onTapped: () => onItemSelected(resources[index]),
          onDownload: () => onDownload(resources[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (resources.isEmpty) {
      return InfoMessageView(
        key: emptyViewKey,
        title: 'Vacío',
        description: 'No encontramos ningún\nrecurso. ¯\\_(ツ)_/¯',
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _buildContent(context);
  }
}
