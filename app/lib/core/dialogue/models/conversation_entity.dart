import '../../../brain/brain_vocabulary.dart';

class ConversationEntity {
  final String id;

  final String label;

  final EntityType type;

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
    EntityType? type,
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
      id: json["id"].toString(),

      label: json["label"]?.toString() ?? "",

      type: EntityType.values.firstWhere(
        (e) => e.name == json["type"]?.toString(),
        orElse: () => EntityType.unknown,
      ),

      aliases: (json["aliases"] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
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