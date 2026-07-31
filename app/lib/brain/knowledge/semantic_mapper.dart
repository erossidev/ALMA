import '../brain_vocabulary.dart';
import '../ontology/ontology.dart';
import '../protocol/brain_instruction.dart';

import 'knowledge_entity.dart';
import 'knowledge_relation.dart';
import 'knowledge_fact.dart';

class SemanticMapper {
  final Ontology ontology;

  const SemanticMapper(
    this.ontology,
  );

  List<BrainEntity> mapEntities(
    List<KnowledgeEntity> entities,
  ) {
    // Implementeremo dopo
    return const [];
  }

  List<BrainRelation> mapRelations(
    List<KnowledgeRelation> relations,
  ) {
    // Implementeremo dopo
    return const [];
  }

  List<BrainFact> mapFacts(
    List<KnowledgeFact> facts,
  ) {
    // Implementeremo dopo
    return const [];
  }
}