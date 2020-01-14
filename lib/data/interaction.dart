class Interaction {
  final String id;
  final String chapterId;
  final String resourceId;
  final String userId;
  final String action;
  final DateTime happenedAt;

  const Interaction({
    this.id,
    this.chapterId,
    this.resourceId,
    this.userId,
    this.action,
    this.happenedAt,
  });

  factory Interaction.fromJson(Map<String, dynamic> json) {
    return Interaction(
      id: json['id'],
      chapterId: json['chapterId'],
      resourceId: json['resourceId'],
      userId: json['userId'],
      action: json['action'],
      happenedAt: json['happenedAt'],
    );
  }
}
