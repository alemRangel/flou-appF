import 'package:learning/data/data.dart';
import 'package:learning/redux/chapter/chapter_actions.dart';
import 'package:learning/redux/chapter/chapter_state.dart';
import 'package:redux/redux.dart';

final chapterReducer = combineReducers<ChapterState>([
  TypedReducer<ChapterState, FetchChapterAction>(_fetchChapters),
  TypedReducer<ChapterState, FetchChapterSucceededAction>(_setChapter),
  TypedReducer<ChapterState, FetchChapterFailedAction>(_setChapterError),
]);

ChapterState _fetchChapters(ChapterState state, FetchChapterAction action) {
  return state.copyWith(
    chapterLoadingStatus: LoadingStatus.loading,
  );
}

ChapterState _setChapter(
    ChapterState state, FetchChapterSucceededAction action) {
  return state.copyWith(
    chapter: action.chapter,
    chapterLoadingStatus: LoadingStatus.success,
  );
}

ChapterState _setChapterError(
    ChapterState state, FetchChapterFailedAction action) {
  return state.copyWith(
    chapter: null,
    chapterLoadingStatus: LoadingStatus.error,
  );
}
