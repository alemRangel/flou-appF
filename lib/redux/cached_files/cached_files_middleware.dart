import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_actions.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/cached_files/cached_files_actions.dart';
import 'package:learning/utils/cache.dart';
import 'package:redux/redux.dart';

class CachedFilesMiddleware extends MiddlewareClass<AppState> {
  final ResourceEndpoint resourceEndpoint;
  final ChapterEndpoint chapterEndpoint;

  CachedFilesMiddleware(this.resourceEndpoint, this.chapterEndpoint);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is InitAction) {
      FlutterDownloader.registerCallback((id, status, progress) {
        store.dispatch(UpdateDownloadProgressAction(id, status, progress));
      });
    } else if (action is FetchFilesAction) {
      FlutterDownloader.loadTasks().then((List<DownloadTask> tasks) {
        store.dispatch(FetchFilesSucceededAction(tasks));
      }).catchError((error) {
        store.dispatch(FetchFilesFailedAction(error));
      });
    } else if (action is EnqueueResourceAction) {
      _enqueueResource(resourceEndpoint, chapterEndpoint, action.resourceId);
    } else if (action is EnqueueDownloadAction) {
      _enqueueDownloadAction(store, action);
    } else if (action is DeleteFileAction) {
      _deleteFile(store, action.url);
    }
    next(action);
  }
}

Future<void> _enqueueResource(ResourceEndpoint resourceEndpoint,
    ChapterEndpoint endpoint, String resourceId) async {
  LResource resource = await resourceEndpoint.get(resourceId);
  List<Chapter> chapters = await endpoint.listByResource(resourceId);
  var taskFutures = chapters.map((Chapter chapter) async {
    return Future.wait([
      _enqueueTask(chapter.audioUrl, 'Audio - ${chapter.title} - ${resource.title}.mp3'),
      _enqueueTask(chapter.downloadVideoUrl, 'Video - ${chapter.title} - ${resource.title}.mp4'),
    ]);
  });
  return Future.wait(taskFutures);
}

Future<void> _enqueueTask(String url, String filename) async {
  if (url == null || url.isEmpty) return null;
  FlutterDownloader.enqueue(
    url: url,
    fileName: filename,
    savedDir: await Cache.getDirectoryPath(),
    showNotification: true,
    openFileFromNotification: false,
  );
}

Future<void> _enqueueDownloadAction(
    Store<AppState> store, EnqueueDownloadAction action) async {
  if (action.action == DownloadAction.resume) {
    String newTaskId = await FlutterDownloader.resume(taskId: action.taskId);
    store.dispatch(UpdateDownloadTaskIdAction(action.taskId, newTaskId));
  } else if (action.action == DownloadAction.pause) {
    return FlutterDownloader.pause(taskId: action.taskId);
  } else if (action.action == DownloadAction.cancel) {
    await FlutterDownloader.cancel(taskId: action.taskId);
  } else if (action.action == DownloadAction.retry) {
    String newTaskId = await FlutterDownloader.retry(taskId: action.taskId);
    store.dispatch(UpdateDownloadTaskIdAction(action.taskId, newTaskId));
  }
}

Future<void> _deleteFile(Store<AppState> store, String url) async {
  await Cache.deleteFile(url);
  store.dispatch(FetchFilesAction());
}
