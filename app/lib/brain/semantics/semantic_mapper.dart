import '../neuron.dart';
import '../synapse.dart';

import 'semantic_entity.dart';
import 'semantic_relation.dart';

class SemanticMapper {
  SemanticMapper();

  // ==========================================
  // ENTITY -> NEURON
  // ==========================================

  Neuron toNeuron(
    SemanticEntity entity,
  ) {
    return Neuron(
      id: entity.id,
      label: entity.label,
      type: _mapNodeType(entity.type),
    );
  }

  // ==========================================
  // RELATION -> SYNAPSE
  // ==========================================

  Synapse toSynapse({
    required SemanticRelation relation,
    required Neuron from,
    required Neuron to,
  }) {
    return Synapse(
      id:
          '${relation.from}_${relation.relation}_${relation.to}',
      from: from,
      to: to,
      relationship: _mapRelationship(
        relation.relation,
      ),
    );
  }

  // ==========================================
  // ENTITY TYPE
  // ==========================================

  NodeType _mapNodeType(
    SemanticEntityType type,
  ) {
    switch (type) {
      case SemanticEntityType.person:
        return NodeType.person;

      case SemanticEntityType.place:
        return NodeType.place;

      case SemanticEntityType.organization:
        return NodeType.project;

      case SemanticEntityType.animal:
        return NodeType.concept;

      case SemanticEntityType.object:
        return NodeType.concept;

      case SemanticEntityType.event:
        return NodeType.event;

      case SemanticEntityType.concept:
        return NodeType.concept;
    }
  }

  // ==========================================
  // RELATION TYPE
  // ==========================================

  RelationshipType _mapRelationship(
    String relation,
  ) {
    switch (relation) {
      case "hasName":
        return RelationshipType.hasName;

      case "hasDaughter":
        return RelationshipType.hasDaughter;

      case "hasSon":
        return RelationshipType.hasSon;

      case "hasFather":
        return RelationshipType.hasFather;

      case "hasMother":
        return RelationshipType.hasMother;

      case "likes":
        return RelationshipType.likes;

      case "worksAt":
        return RelationshipType.worksAt;

      case "livesIn":
        return RelationshipType.livesIn;

      case "owns":
        return RelationshipType.owns;

      case "uses":
        return RelationshipType.uses;

      case "createdBy":
        return RelationshipType.createdBy;

      case "marriedTo":
        return RelationshipType.marriedTo;

      default:
        return RelationshipType.relatedTo;
    }
  }
}