import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/chapter_list/chapter_list_view_model.dart';
import 'package:meta/meta.dart';

class ChapterList extends StatelessWidget {
  ChapterList({
    @required this.header,
    @required this.onChapterTapped,
  });

  final Widget header;
  final VoidCallback onChapterTapped;

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.vertical;

    return Transform(
      // FIXME: A hack for drawing behind the status bar, find a proper solution.
      transform: Matrix4.translationValues(0.0, -statusBarHeight, 0.0),
      child: StoreConnector<AppState, ChapterListViewModel>(
        distinct: true,
        converter: (store) => ChapterListViewModel.fromStore(store),
        builder: (BuildContext context, ChapterListViewModel viewModel) {
          return ChapterListContent(
            header: header,
            onChapterTapped: onChapterTapped,
            viewModel: viewModel,
          );
        },
      ),
    );
  }
}

class ChapterListContent extends StatelessWidget {
  ChapterListContent({
    @required this.header,
    @required this.onChapterTapped,
    @required this.viewModel,
  });

  final Widget header;
  final VoidCallback onChapterTapped;
  final ChapterListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.chapters.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return header;
        }

        var chapter = viewModel.chapters[index - 1];
        var isSelected = viewModel.currentChapter.id == chapter.id;
        var backgroundColor = isSelected
            ? const Color(0xFFEEEEEE)
            : Theme.of(context).canvasColor;

        return Material(
          color: backgroundColor,
          child: ListTile(
            onTap: () {
              viewModel.refreshChapter(chapter.id);
              onChapterTapped();
            },
            selected: isSelected,
            title: Text(chapter.title),
          ),
        );
      },
    );
  }
}
