import 'package:learning/data/data.dart';

class FetchChapterAction {
  final String chapterKey;

  FetchChapterAction(this.chapterKey);
}

class FetchChapterSucceededAction {
  final Chapter chapter;

  FetchChapterSucceededAction(this.chapter);
}

class FetchChapterFailedAction {
  final Exception error;

  FetchChapterFailedAction(this.error);
}
