import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/cached_files/cached_files_actions.dart';
import 'package:learning/redux/cached_files/cached_files_state.dart';
import 'package:redux/redux.dart';

final cachedFilesReducer = combineReducers<CachedFilesState>([
  TypedReducer<CachedFilesState, FetchFilesAction>(_fetchFiles),
  TypedReducer<CachedFilesState, FetchFilesSucceededAction>(_setFiles),
  TypedReducer<CachedFilesState, FetchFilesFailedAction>(_setError),
  TypedReducer<CachedFilesState, UpdateDownloadProgressAction>(_updateProgress),
  TypedReducer<CachedFilesState, UpdateDownloadTaskIdAction>(_updateTaskId),
  TypedReducer<CachedFilesState, DeleteFileAction>(_deleteFile),
]);

CachedFilesState _fetchFiles(CachedFilesState state, FetchFilesAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

CachedFilesState _setFiles(
    CachedFilesState state, FetchFilesSucceededAction action) {
  return state.copyWith(
    cachedFiles: action.cachedFiles,
    loadingStatus: LoadingStatus.success,
  );
}

CachedFilesState _setError(
    CachedFilesState state, FetchFilesFailedAction action) {
  return state.copyWith(
    cachedFiles: const [],
    loadingStatus: LoadingStatus.error,
  );
}

CachedFilesState _updateProgress(
    CachedFilesState state, UpdateDownloadProgressAction action) {
  List<DownloadTask> cachedFiles = state.cachedFiles.map((DownloadTask task) {
    if (task.taskId == action.taskId) {
      return DownloadTask(
        taskId: action.taskId,
        status: action.status,
        progress: action.progress,
        url: task.url,
        savedDir: task.savedDir,
        filename: task.filename,
      );
    } else {
      return task;
    }
  }).toList();

  return state.copyWith(
    cachedFiles: cachedFiles,
  );
}

CachedFilesState _updateTaskId(
    CachedFilesState state, UpdateDownloadTaskIdAction action) {
  List<DownloadTask> cachedFiles = state.cachedFiles.map((DownloadTask task) {
    if (task.taskId == action.oldTaskId) {
      return DownloadTask(
        taskId: action.newTaskId,
        status: task.status,
        progress: task.progress,
        url: task.url,
        savedDir: task.savedDir,
        filename: task.filename,
      );
    } else {
      return task;
    }
  }).toList();

  return state.copyWith(
    cachedFiles: cachedFiles,
  );
}

CachedFilesState _deleteFile(CachedFilesState state, DeleteFileAction action) {
  List<DownloadTask> newFiles = state.cachedFiles
      .where((DownloadTask task) => task.url != action.url)
      .toList();
  return state.copyWith(
    cachedFiles: newFiles,
  );
}
