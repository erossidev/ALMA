import 'semantic_entity.dart';
import 'semantic_relation.dart';
import 'semantic_fact.dart';

class SemanticResult {
  final List<SemanticEntity> entities;
  final List<SemanticRelation> relations;
  final List<SemanticFact> facts;

  const SemanticResult({
    required this.entities,
    required this.relations,
    required this.facts,
  });

  bool get isEmpty =>
      entities.isEmpty &&
      relations.isEmpty &&
      facts.isEmpty;
}