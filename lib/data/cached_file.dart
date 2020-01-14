import 'package:flutter_downloader/flutter_downloader.dart';

class CachedFile {
  final String name;
  final String link;

  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  CachedFile({this.name, this.link});
}

class ItemHolder {
  final String name;
  final CachedFile task;

  ItemHolder({this.name, this.task});

  factory ItemHolder.fromJson(Map<String, dynamic> json) {
    return ItemHolder(
      name: json['name'],
      task: json['task'],
    );
  }
}
