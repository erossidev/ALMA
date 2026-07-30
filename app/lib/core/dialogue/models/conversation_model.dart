import 'conversation_entity.dart';
import 'conversation_relation.dart';

class ConversationModel {
  final List<ConversationEntity> entities;

  final List<ConversationRelation> relations;

  final String? activeEntityId;

  final String? currentTopic;

  const ConversationModel({
    this.entities = const [],
    this.relations = const [],
    this.activeEntityId,
    this.currentTopic,
  });

  static const empty = ConversationModel();

  ConversationModel copyWith({
    List<ConversationEntity>? entities,
    List<ConversationRelation>? relations,
    String? activeEntityId,
    String? currentTopic,
  }) {
    return ConversationModel(
      entities: entities ?? this.entities,
      relations: relations ?? this.relations,
      activeEntityId: activeEntityId ?? this.activeEntityId,
      currentTopic: currentTopic ?? this.currentTopic,
    );
  }

  factory ConversationModel.fromJson(
  Map<String, dynamic> json,
) {
  return ConversationModel(
    entities: (json["entities"] as List<dynamic>? ?? [])
        .map(
          (e) => ConversationEntity.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList(),

    relations: (json["relations"] as List<dynamic>? ?? [])
        .map(
          (e) => ConversationRelation.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList(),

    activeEntityId:
        json["activeEntityId"]?.toString(),

    currentTopic:
        json["currentTopic"]?.toString(),
  );
}

  Map<String, dynamic> toJson() {
    return {
      "entities": entities.map((e) => e.toJson()).toList(),
      "relations": relations.map((e) => e.toJson()).toList(),
      "activeEntityId": activeEntityId,
      "currentTopic": currentTopic,
    };
  }
}