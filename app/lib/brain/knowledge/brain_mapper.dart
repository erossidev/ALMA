import '../brain_vocabulary.dart';
import '../protocol/brain_instruction.dart';

import 'knowledge_model.dart';

class BrainMapper {
  const BrainMapper();

  BrainInstruction map({
    required BrainOperation operation,
    required KnowledgeModel knowledge,
  }) {
    return BrainInstruction(
      operation: operation,
      entities: _mapEntities(knowledge),
      relations: _mapRelations(knowledge),
      facts: _mapFacts(knowledge),
    );
  }

  // =====================================================
  // FACT -> ENTITY
  // =====================================================

  List<BrainEntity> _mapFactEntities(
    KnowledgeModel knowledge,
  ) {
    final entities = <BrainEntity>[];

    for (final fact in knowledge.facts) {
      final id = fact.value
          .trim()
          .toLowerCase()
          .replaceAll(" ", "_");

      entities.add(
        BrainEntity(
          id: id,
          label: fact.value,
          type: EntityType.concept,
        ),
      );
    }

    return entities;
  }

  // =====================================================
  // ENTITY
  // =====================================================

  List<BrainEntity> _mapEntities(
    KnowledgeModel knowledge,
  ) {
    final entities =
        knowledge.entities.map((entity) {
      final type =
          entity.type.trim().toLowerCase();

      return BrainEntity(
        id: entity.id,
        label: entity.label,
        type: EntityType.values.firstWhere(
          (e) =>
              e.name.toLowerCase() == type,
          orElse: () => EntityType.unknown,
        ),
      );
    }).toList();

    entities.addAll(
      _mapFactEntities(
        knowledge,
      ),
    );

    return entities;
  }

  // =====================================================
  // FACT -> RELATION
  // =====================================================

  List<BrainRelation> _mapFactRelations(
    KnowledgeModel knowledge,
  ) {
    final relations = <BrainRelation>[];

    for (final fact in knowledge.facts) {
      final targetId = fact.value
          .trim()
          .toLowerCase()
          .replaceAll(" ", "_");

      relations.add(
        BrainRelation(
          from: fact.entityId,
          to: targetId,
          type: RelationshipType.values.firstWhere(
            (e) => e.name == fact.type,
            orElse: () => RelationshipType.relatedTo,
          ),
        ),
      );
    }

    return relations;
  }

  // =====================================================
  // RELATION
  // =====================================================

  List<BrainRelation> _mapRelations(
    KnowledgeModel knowledge,
  ) {
    final relations =
        knowledge.relations.map((relation) {
      final type = relation.type.trim();

      return BrainRelation(
        from: relation.from,
        to: relation.to,
        type: RelationshipType.values.firstWhere(
          (e) => e.name == type,
          orElse: () => RelationshipType.relatedTo,
        ),
      );
    }).toList();

    relations.addAll(
      _mapFactRelations(
        knowledge,
      ),
    );

    return relations;
  }

  // =====================================================
  // FACT
  // =====================================================

  List<BrainFact> _mapFacts(
    KnowledgeModel knowledge,
  ) {
    return knowledge.facts.map((fact) {
      final type = fact.type.trim();

      return BrainFact(
        id: fact.id,
        entityId: fact.entityId,
        value: fact.value,
        type: FactType.values.firstWhere(
          (e) => e.name == type,
          orElse: () => FactType.note,
        ),
      );
    }).toList();
  }
}