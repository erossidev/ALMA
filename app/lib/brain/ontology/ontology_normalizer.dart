import '../knowledge/knowledge_model.dart';

abstract class OntologyNormalizer {
  const OntologyNormalizer();

  Future<KnowledgeModel> normalize(
    KnowledgeModel knowledge,
  );
}