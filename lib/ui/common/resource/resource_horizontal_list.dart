import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:meta/meta.dart';

class ResourceHorizontalList extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  ResourceHorizontalList({
    @required this.resources,
    @required this.onReloadCallback,
    @required this.onItemSelected,
  });

  final List<LResource> resources;
  final VoidCallback onReloadCallback;
  final Function onItemSelected;

  Widget _buildContent(BuildContext context) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        itemCount: resources.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ResourceItem(
              resource: resources[index],
              onTapped: () => onItemSelected(resources[index]),
            ),
          );
        },
      ),
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
