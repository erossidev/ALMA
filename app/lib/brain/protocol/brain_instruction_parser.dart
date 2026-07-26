import '../brain_vocabulary.dart';
import '../semantics/semantic_entity.dart';
import '../semantics/semantic_result.dart';

import 'brain_instruction.dart';

class BrainInstructionParser {
  const BrainInstructionParser();

  BrainInstruction fromSemantic(
    SemanticResult semantic,
  ) {
    return BrainInstruction(
      operation: BrainOperation.store,
      memoryType: MemoryType.semantic,
      confidence: 1.0,
      importance: 1.0,
      reason: "semantic_import",

      entities: semantic.entities
          .map(
            (e) => BrainEntity(
              id: e.id,
              label: e.label,
              type: _mapEntityType(e.type),
            ),
          )
          .toList(),

      relations: semantic.relations
          .map(
            (r) => BrainRelation(
              from: r.from,
              to: r.to,
              type: _mapRelation(r.relation),
            ),
          )
          .toList(),

      facts: semantic.facts
        .map(
          (f) => BrainFact(
            id: "${f.subject}_${f.predicate}",
            entityId: f.subject,
            type: _mapFact(f.predicate),
            value: f.value.toString(),
          ),
        )
        .toList(),
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
  // RELATION
  // ==========================================================

  RelationshipType _mapRelation(
    String relation,
  ) {
    return RelationshipType.values.firstWhere(
      (r) => r.name == relation,
      orElse: () => RelationshipType.relatedTo,
    );
  }

  // ==========================================================
  // FACT
  // ==========================================================

  FactType _mapFact(
    String type,
  ) {
    return FactType.values.firstWhere(
      (f) => f.name == type,
      orElse: () => FactType.note,
    );
  }
}