class ConversationRelation {

  final String sourceId;

  final String relation;

  final String targetId;

  const ConversationRelation({
    required this.sourceId,
    required this.relation,
    required this.targetId,
  });

  factory ConversationRelation.fromJson(
    Map<String, dynamic> json,
  ) {
    return ConversationRelation(
      sourceId: json["sourceId"] as String,
      relation: json["relation"] as String,
      targetId: json["targetId"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sourceId": sourceId,
      "relation": relation,
      "targetId": targetId,
    };
  }
}