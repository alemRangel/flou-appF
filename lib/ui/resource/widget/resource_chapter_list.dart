import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/chapter/chapter_page.dart';

class ResourceChapterList extends StatelessWidget {
  final Enrollment enrollment;
  final List<Chapter> chapters;

  ResourceChapterList({this.chapters, this.enrollment});

  Widget buildListTile(BuildContext context, Chapter chapter) {
    bool completed = enrollment.completedChapters.contains(chapter.id);
    return ListTile(
      trailing: completed
          ? Icon(Icons.done, color: Theme.of(context).disabledColor)
          : null,
      title: Text(chapter.title),
      onTap: () => _openChapter(context, chapter),
    );
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> listTiles =
        chapters.map((Chapter chapter) => buildListTile(context, chapter));
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: listTiles.toList(),
    );
  }

  void _openChapter(BuildContext context, Chapter chapter) {
    Navigator.push<Null>(
      context,
      MaterialPageRoute(
        builder: (_) => ChapterPage(id: chapter.id),
      ),
    );
  }
}
