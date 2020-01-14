import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class CachedFilesState {
  final List<DownloadTask> cachedFiles;
  final LoadingStatus filesLoadingStatus;

  CachedFilesState({
    @required this.filesLoadingStatus,
    @required this.cachedFiles,
  });

  factory CachedFilesState.initial() {
    return CachedFilesState(
      filesLoadingStatus: LoadingStatus.loading,
      cachedFiles: <DownloadTask>[],
    );
  }

  CachedFilesState copyWith({
    LoadingStatus loadingStatus,
    List<DownloadTask> cachedFiles,
  }) {
    return CachedFilesState(
      filesLoadingStatus: loadingStatus ?? this.filesLoadingStatus,
      cachedFiles: cachedFiles ?? this.cachedFiles,
    );
  }

  @override
  int get hashCode => filesLoadingStatus.hashCode ^ cachedFiles.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedFilesState &&
          runtimeType == other.runtimeType &&
          filesLoadingStatus == other.filesLoadingStatus &&
          cachedFiles == other.cachedFiles;

  @override
  String toString() {
    return 'CachedFilesState{loadingStatus: $filesLoadingStatus, cachedFiles: $cachedFiles}';
  }
}
