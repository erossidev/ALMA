import '../knowledge/knowledge_model.dart';
import 'ontology.dart';

class OntologyValidator {
  final Ontology ontology;

  const OntologyValidator(
    this.ontology,
  );

  List<String> validate(
    KnowledgeModel knowledge,
  ) {
    final unknown = <String>{};

    // ==========================
    // ENTITY TYPES
    // ==========================

    for (final entity in knowledge.entities) {
      if (!ontology.containsEntityType(
        entity.type,
      )) {
        unknown.add(entity.type);
      }
    }

    // ==========================
    // RELATION TYPES
    // ==========================

    for (final relation in knowledge.relations) {
      if (!ontology.containsRelation(
        relation.type,
      )) {
        unknown.add(relation.type);
      }
    }

    // ==========================
    // FACT TYPES
    // ==========================

    for (final fact in knowledge.facts) {
      if (!ontology.containsFactType(
        fact.type,
      )) {
        unknown.add(fact.type);
      }
    }

    return unknown.toList();
  }
}