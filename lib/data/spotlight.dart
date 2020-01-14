class Spotlight {
  final String actionUrl;
  final String content;
  final DateTime displayUntil;
  final String photoUrl;
  final DateTime publishedAt;
  final String title;

  const Spotlight(
      {this.actionUrl,
      this.content,
      this.displayUntil,
      this.photoUrl,
      this.publishedAt,
      this.title});

  factory Spotlight.fromJson(Map<String, dynamic> json) {
    return Spotlight(
      actionUrl: json['actionUrl'],
      content: json['content'],
      displayUntil: json['displayUntil'],
      photoUrl: json['photoUrl'],
      publishedAt: json['publishedAt'],
      title: json['title'],
    );
  }
}
