import 'package:flutter/material.dart';
import 'package:learning/ui/common/custom_dialog.dart';
import 'package:meta/meta.dart';

enum EnrollmentDialogAction {
  disagree,
  agree,
}

class EnrollmentDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onAgree;

  EnrollmentDialog(
      {@required this.title, @required this.content, @required this.onAgree});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      content: content,
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCELAR'),
          onPressed: () {
            Navigator.pop(context, EnrollmentDialogAction.disagree);
          },
        ),
        FlatButton(
          child: const Text('ACEPTAR'),
          onPressed: () {
            onAgree();
            Navigator.pop(context, EnrollmentDialogAction.agree);
          },
        ),
      ],
    );
  }
}
