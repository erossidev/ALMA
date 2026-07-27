import 'conversation_entity.dart';
import 'conversation_relation.dart';

class ConversationModel {
  final List<ConversationEntity> entities;

  final List<ConversationRelation> relations;

  final String? currentFocus;

  final String? currentTopic;

  const ConversationModel({
    this.entities = const [],
    this.relations = const [],
    this.currentFocus,
    this.currentTopic,
  });

  static const empty = ConversationModel();

  ConversationModel copyWith({
    List<ConversationEntity>? entities,
    List<ConversationRelation>? relations,
    String? currentFocus,
    String? currentTopic,
  }) {
    return ConversationModel(
      entities: entities ?? this.entities,
      relations: relations ?? this.relations,
      currentFocus: currentFocus ?? this.currentFocus,
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

      currentFocus: json["currentFocus"] as String?,

      currentTopic: json["currentTopic"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "entities": entities.map((e) => e.toJson()).toList(),
      "relations": relations.map((e) => e.toJson()).toList(),
      "currentFocus": currentFocus,
      "currentTopic": currentTopic,
    };
  }
}