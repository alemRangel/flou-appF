import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/chapter/chapter_actions.dart';
import 'package:learning/redux/chapter/chapter_state.dart';
import 'package:learning/redux/resource/resource_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ChapterListViewModel {
  ChapterListViewModel({
    @required this.resourceState,
    @required this.chapterState,
    @required this.refreshChapter,
  });

  final ResourceState resourceState;
  final ChapterState chapterState;
  final Function refreshChapter;

  static ChapterListViewModel fromStore(Store<AppState> store) {
    return ChapterListViewModel(
      resourceState: store.state.resourceState,
      chapterState: store.state.chapterState,
      refreshChapter: (String key) => store.dispatch(FetchChapterAction(key)),
    );
  }

  List<Chapter> get chapters => resourceState.chapters;
  Chapter get currentChapter => chapterState.chapter;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterListViewModel &&
          runtimeType == other.runtimeType &&
          resourceState == other.resourceState &&
          chapterState == other.chapterState;

  @override
  int get hashCode => resourceState.hashCode ^ chapterState.hashCode;
}
