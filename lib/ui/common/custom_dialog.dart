import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  CustomDialog({
    @required this.title,
    @required this.content,
    @required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return AlertDialog(
      title: Text(title),
      content: Text(content, style: dialogTextStyle),
      actions: actions,
    );
  }
}
