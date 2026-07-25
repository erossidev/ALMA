import '../brain_vocabulary.dart';
import '../neuron.dart';
import '../synapse.dart';

import 'semantic_entity.dart';
import 'semantic_relation.dart';

class SemanticMapper {
  SemanticMapper();

  // ==========================================================
  // ENTITY -> NEURON
  // ==========================================================

  Neuron toNeuron(
    SemanticEntity entity,
  ) {
    return Neuron(
      id: entity.id,
      label: entity.label,
      type: _mapEntityType(entity.type),
    );
  }

  // ==========================================================
  // RELATION -> SYNAPSE
  // ==========================================================

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

  // ==========================================================
  // ENTITY TYPE
  // ==========================================================

  EntityType _mapEntityType(
    SemanticEntityType type,
  ) {
    switch (type) {
      case SemanticEntityType.person:
        return EntityType.person;

      case SemanticEntityType.place:
        return EntityType.place;

      case SemanticEntityType.organization:
        return EntityType.organization;

      case SemanticEntityType.company:
        return EntityType.company;

      case SemanticEntityType.project:
        return EntityType.project;

      case SemanticEntityType.product:
        return EntityType.product;

      case SemanticEntityType.technology:
        return EntityType.technology;

      case SemanticEntityType.document:
        return EntityType.document;

      case SemanticEntityType.date:
        return EntityType.date;

      case SemanticEntityType.event:
        return EntityType.event;

      case SemanticEntityType.preference:
        return EntityType.preference;

      case SemanticEntityType.goal:
        return EntityType.goal;

      case SemanticEntityType.emotion:
        return EntityType.emotion;

      case SemanticEntityType.concept:
        return EntityType.concept;
    }
  }

  // ==========================================================
  // RELATION TYPE
  // ==========================================================

  RelationshipType _mapRelationship(
    String relation,
  ) {
    switch (relation) {
      case "hasName":
        return RelationshipType.hasName;

      case "alias":
      case "hasNickname":
        return RelationshipType.hasNickname;

      case "hasFather":
        return RelationshipType.hasFather;

      case "hasMother":
        return RelationshipType.hasMother;

      case "hasBrother":
        return RelationshipType.hasBrother;

      case "hasSister":
        return RelationshipType.hasSister;

      case "hasSon":
        return RelationshipType.hasSon;

      case "hasDaughter":
        return RelationshipType.hasDaughter;

      case "marriedTo":
      case "spouse":
        return RelationshipType.spouse;

      case "birthDate":
        return RelationshipType.birthDate;

      case "birthPlace":
        return RelationshipType.birthPlace;

      case "livesIn":
        return RelationshipType.livesIn;

      case "worksAt":
        return RelationshipType.worksAt;

      case "studiedAt":
        return RelationshipType.studiedAt;

      case "owns":
        return RelationshipType.owns;

      case "hasPet":
        return RelationshipType.hasPet;

      case "likes":
        return RelationshipType.likes;

      case "dislikes":
        return RelationshipType.dislikes;

      case "loves":
        return RelationshipType.loves;

      case "hates":
        return RelationshipType.hates;

      case "uses":
        return RelationshipType.uses;

      case "createdBy":
        return RelationshipType.createdBy;

      case "relatedTo":
        return RelationshipType.relatedTo;

      default:
        return RelationshipType.relatedTo;
    }
  }
}