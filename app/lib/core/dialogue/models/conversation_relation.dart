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
    sourceId: json["sourceId"]?.toString() ?? "",
    relation: json["relation"]?.toString() ?? "",
    targetId: json["targetId"]?.toString() ?? "",
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