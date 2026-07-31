import 'ontology_entity_type.dart';
import 'ontology_fact_type.dart';
import 'ontology_relation.dart';

class Ontology {
  final int version;

  final List<OntologyEntityType> entityTypes;

  final List<OntologyRelation> relations;

  final List<OntologyFactType> factTypes;

  const Ontology({
    required this.version,
    this.entityTypes = const [],
    this.relations = const [],
    this.factTypes = const [],
  });

  bool containsEntityType(
    String id,
  ) {
    final target = id.trim().toLowerCase();

    return entityTypes.any(
      (e) => e.id.trim().toLowerCase() == target,
    );
  }

  bool containsRelation(
    String id,
  ) {
    final target = id.trim().toLowerCase();

    return relations.any(
      (r) => r.id.trim().toLowerCase() == target,
    );
  }

  bool containsFactType(
    String id,
  ) {
    final target = id.trim().toLowerCase();

    return factTypes.any(
      (f) => f.id.trim().toLowerCase() == target,
    );
  }
}