import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/chapter/chapter_actions.dart';
import 'package:learning/redux/chapter/chapter_state.dart';
import 'package:learning/redux/resource/resource_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ChapterPageViewModel {
  ChapterPageViewModel({
    @required this.resourceState,
    @required this.chapterState,
    @required this.refreshChapter,
  });

  final ResourceState resourceState;
  final ChapterState chapterState;
  final Function refreshChapter;

  static ChapterPageViewModel fromStore(Store<AppState> store) {
    return ChapterPageViewModel(
      resourceState: store.state.resourceState,
      chapterState: store.state.chapterState,
      refreshChapter: (String key) => store.dispatch(FetchChapterAction(key)),
    );
  }

  static onInit(Store<AppState> store, String chapterId) {
    store.dispatch(FetchChapterAction(chapterId));
  }

  List<Chapter> get chapters => resourceState.chapters;
  Chapter get chapter => chapterState.chapter;
  LResource get resource => resourceState.resource;
  LoadingStatus get chapterLoadingStatus => chapterState.chapterLoadingStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterPageViewModel &&
          runtimeType == other.runtimeType &&
          resourceState == other.resourceState &&
          chapterState == other.chapterState &&
          chapterLoadingStatus == other.chapterLoadingStatus;

  @override
  int get hashCode =>
      resourceState.hashCode ^
      chapterState.hashCode ^
      chapterLoadingStatus.hashCode;
}
