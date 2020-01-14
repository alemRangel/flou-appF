import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/explore/widget/category_list_item.dart';
import 'package:meta/meta.dart';

class CategoryList extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  CategoryList({
    @required this.categories,
    @required this.onReloadCallback,
    @required this.onItemSelected,
  });

  final List<Category> categories;
  final VoidCallback onReloadCallback;
  final Function onItemSelected;

  Widget _buildContent(BuildContext context) {
    return Container(
      height: 180.0,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return CategoryListItem(
            category: categories[index],
            onTapped: () => onItemSelected(categories[index]),
            size: Size(200.0, 200.0),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return InfoMessageView(
        key: emptyViewKey,
        title: 'Vacío',
        description: 'No encontramos ninguna\ncategoría. ¯\\_(ツ)_/¯',
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _buildContent(context);
  }
}
