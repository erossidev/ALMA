enum ConversationEntityType {
  person,
  place,
  object,
  organization,
  concept,
  unknown,
}

class ConversationEntity {
  final String id;

  final String label;

  final ConversationEntityType type;

  final List<String> aliases;

  const ConversationEntity({
    required this.id,
    required this.label,
    required this.type,
    this.aliases = const [],
  });

  ConversationEntity copyWith({
    String? id,
    String? label,
    ConversationEntityType? type,
    List<String>? aliases,
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      aliases: aliases ?? this.aliases,
    );
  }

  factory ConversationEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return ConversationEntity(
      id: json["id"] as String,

      label: json["label"] as String,

      type: ConversationEntityType.values.firstWhere(
        (e) => e.name == json["type"],
        orElse: () => ConversationEntityType.unknown,
      ),

      aliases: (json["aliases"] as List<dynamic>? ?? [])
          .cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "label": label,
      "type": type.name,
      "aliases": aliases,
    };
  }
}