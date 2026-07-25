import 'semantic_entity.dart';
import 'semantic_fact.dart';
import 'semantic_relation.dart';
import 'semantic_result.dart';

class SemanticNormalizer {
  const SemanticNormalizer();

  SemanticResult normalize(
    SemanticResult semantic,
  ) {
    final entities =
        semantic.entities.map(_normalizeEntity).toList();

    final relations =
        semantic.relations.map(_normalizeRelation).toList();

    final facts =
        semantic.facts.map(_normalizeFact).toList();

    return SemanticResult(
      entities: entities,
      relations: relations,
      facts: facts,
    );
  }

  // =====================================================
  // ENTITY
  // =====================================================

  SemanticEntity _normalizeEntity(
    SemanticEntity entity,
  ) {
    return SemanticEntity(
      id: entity.id.toLowerCase().trim(),
      label: entity.label.trim(),
      type: entity.type,
    );
  }

  // =====================================================
  // RELATION
  // =====================================================

  SemanticRelation _normalizeRelation(
    SemanticRelation relation,
  ) {
    return SemanticRelation(
      from: relation.from.toLowerCase().trim(),
      to: relation.to.toLowerCase().trim(),
      relation: _normalizeRelationName(
        relation.relation,
      ),
    );
  }

  // =====================================================
  // FACT
  // =====================================================

  SemanticFact _normalizeFact(
    SemanticFact fact,
  ) {
    return SemanticFact(
      subject: fact.subject.toLowerCase().trim(),
      predicate: fact.predicate.trim(),
      value: fact.value,
    );
  }

  // =====================================================
  // RELATION NAME
  // =====================================================

  String _normalizeRelationName(
    String relation,
  ) {
    switch (relation.toLowerCase()) {
      case "nome":
      case "name":
      case "is named":
        return "hasName";

      case "lives":
      case "lives in":
      case "resides in":
        return "livesIn";

      case "works":
      case "works at":
        return "worksAt";

      default:
        return relation;
    }
  }
}