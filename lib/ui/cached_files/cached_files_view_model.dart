import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/cached_files/cached_files_actions.dart';
import 'package:learning/redux/cached_files/cached_files_state.dart';
import 'package:learning/redux/spotlight/spotlight_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class CachedFilesPageViewModel {
  CachedFilesPageViewModel({
    @required this.cachedFilesState,
    @required this.refreshCachedFiles,
    @required this.downloadAction,
    @required this.deleteFile,
  });

  final CachedFilesState cachedFilesState;
  final Function refreshCachedFiles;
  final Function downloadAction;
  final Function deleteFile;

  static CachedFilesPageViewModel fromStore(Store<AppState> store) {
    return CachedFilesPageViewModel(
      cachedFilesState: store.state.cachedFilesState,
      refreshCachedFiles: () => store.dispatch(FetchSpotlightsAction()),
      downloadAction: (DownloadTask task, DownloadAction action) =>
          store.dispatch(EnqueueDownloadAction(task.taskId, action)),
      deleteFile: (DownloadTask task) =>
          store.dispatch(DeleteFileAction(task.url)),
    );
  }

  get cachedFiles => cachedFilesState.cachedFiles;
  get loadingStatus => cachedFilesState.filesLoadingStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedFilesPageViewModel &&
          runtimeType == other.runtimeType &&
          refreshCachedFiles == other.refreshCachedFiles &&
          downloadAction == other.downloadAction;

  @override
  int get hashCode => refreshCachedFiles.hashCode ^ downloadAction.hashCode;
}
