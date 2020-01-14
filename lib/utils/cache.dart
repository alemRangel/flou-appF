import 'dart:async';
import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class Cache {
  static Future<File> getCacheFile(String url) async {
    var task = await _getTaskByUrl(url);
    if (task == null) return Future.value(null);
    File file = File('${task.savedDir}/${task.filename}');
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  static Future<void> deleteFile(String url) async {
    File file = await getCacheFile(url);
    if (file != null && await file.exists()) {
      await file.delete();
    }
    await FlutterDownloader.loadTasksWithRawQuery(
        query: "DELETE FROM task WHERE url='$url'");
  }

  static Future<String> getDirectoryPath() async {
    String documentsPath = (await getApplicationDocumentsDirectory()).path;
    String fullPath = '$documentsPath/cached_files';
    final savedDir = Directory(fullPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    return fullPath;
  }

  static Future<DownloadTask> _getTaskByUrl(String url) async {
    final tasks = await FlutterDownloader.loadTasksWithRawQuery(
        query: "SELECT * FROM task WHERE url='$url' AND status=3");
    if (tasks.isNotEmpty) {
      return tasks.first;
    }
    return null;
  }
}
