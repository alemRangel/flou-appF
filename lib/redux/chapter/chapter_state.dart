import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class ChapterState {
  final Chapter chapter;
  final LoadingStatus chapterLoadingStatus;

  ChapterState({
    @required this.chapter,
    @required this.chapterLoadingStatus,
  });

  factory ChapterState.initial() {
    return ChapterState(
      chapter: null,
      chapterLoadingStatus: LoadingStatus.loading,
    );
  }

  ChapterState copyWith({
    Chapter chapter,
    LoadingStatus chapterLoadingStatus,
  }) {
    return ChapterState(
      chapter: chapter ?? this.chapter,
      chapterLoadingStatus: chapterLoadingStatus ?? this.chapterLoadingStatus,
    );
  }

  @override
  int get hashCode => chapter.hashCode ^ chapterLoadingStatus.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterState &&
          runtimeType == other.runtimeType &&
          chapter == other.chapter &&
          chapterLoadingStatus == other.chapterLoadingStatus;

  @override
  String toString() {
    return 'ChapterState{chapter: $chapter, chapterLoadingStatus: $chapterLoadingStatus}';
  }
}
