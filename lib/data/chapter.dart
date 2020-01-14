class Chapter {
  final String id;
  final String title;
  final String content;
  final String resourceId;
  final String wistiaVideoId;
  final String downloadVideoUrl;
  final num videoRatio;
  final String audioUrl;
  String offlineAudioPath;
  String offlineVideoPath;

  Chapter({
    this.id,
    this.title,
    this.content,
    this.wistiaVideoId,
    this.downloadVideoUrl,
    this.videoRatio,
    this.audioUrl,
    this.resourceId,
    this.offlineAudioPath,
    this.offlineVideoPath,
  });


  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      resourceId: json['resourceId'],
      wistiaVideoId: json['wistiaVideoId'],
      downloadVideoUrl: json['downloadVideoUrl'],
      videoRatio: json['videoRatio'],
      audioUrl: json['audioUrl'],
      offlineAudioPath: json['offlineAudioPath'],
      offlineVideoPath: json['offlineVideoPath'],
    );
  }

  //To create and update
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["content"] = content;
    map["resourceId"] = resourceId;
    map["wistiaVideoId"] = wistiaVideoId;
    map["downloadVideoUrl"] = downloadVideoUrl;
    map["videoRatio"] = videoRatio;
    map["audioUrl"] = audioUrl;
    map["offlineAudioPath"] = offlineAudioPath;
    map["offlineVideoPath"] = offlineVideoPath;
    return map;
  }
}
