import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:learning/data/data.dart';

class FetchFilesAction {}

class FetchFilesSucceededAction {
  final List<DownloadTask> cachedFiles;

  FetchFilesSucceededAction(this.cachedFiles);
}

class FetchFilesFailedAction {
  final Exception error;

  FetchFilesFailedAction(this.error);
}

class DeleteFileAction {
  final String url;

  DeleteFileAction(this.url);
}

class EnqueueDownloadAction {
  final DownloadAction action;
  final String taskId;

  EnqueueDownloadAction(this.taskId, this.action);
}

class EnqueueResourceAction {
  final String resourceId;

  EnqueueResourceAction(this.resourceId);
}

class UpdateDownloadProgressAction {
  final String taskId;
  final DownloadTaskStatus status;
  final int progress;

  UpdateDownloadProgressAction(this.taskId, this.status, this.progress);
}

class UpdateDownloadTaskIdAction {
  final String oldTaskId;
  final String newTaskId;

  UpdateDownloadTaskIdAction(this.oldTaskId, this.newTaskId);
}
