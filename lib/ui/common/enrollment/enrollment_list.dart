import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:meta/meta.dart';

import 'enrollment_list_item.dart';

class EnrollmentList extends StatelessWidget {
  static const Key emptyViewKey = const Key('emptyView');
  static const Key contentKey = const Key('content');

  EnrollmentList({
    @required this.enrollments,
    @required this.onReloadCallback,
    @required this.onItemSelected,
    this.onDownload,
  });

  final List<Enrollment> enrollments;
  final VoidCallback onReloadCallback;
  final Function onItemSelected;
  final Function onDownload;

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: enrollments.length,
      itemBuilder: (BuildContext context, int index) {
        return EnrollmentListItem(
          enrollment: enrollments[index],
          onTapped: () => onItemSelected(enrollments[index]),
          onDownload: () => onDownload(enrollments[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (enrollments.isEmpty) {
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
