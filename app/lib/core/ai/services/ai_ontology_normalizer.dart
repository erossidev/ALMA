import '../../../brain/knowledge/knowledge_json_mapper.dart';
import '../../../brain/knowledge/knowledge_model.dart';
import '../../../brain/knowledge/knowledge_parser.dart';
import '../../../brain/ontology/ontology_normalization_prompt.dart';
import '../../../brain/ontology/ontology_normalizer.dart';
import '../ai_manager.dart';

class OntologyNormalizerService
    implements OntologyNormalizer {

  final AIManager aiManager;

  final KnowledgeParser parser;

  final KnowledgeJsonMapper codec;

  const OntologyNormalizerService({
    required this.aiManager,
    required this.parser,
    required this.codec,
  });

  @override
Future<KnowledgeModel> normalize(
  KnowledgeModel knowledge,
) async {

  final knowledgeJson =
      codec.toJson(
    knowledge,
  );

  final prompt =
      await OntologyNormalizationPrompt.build(
    knowledgeJson,
  );

  print(">>> PRIMA normalizeOntology");

  final normalizedJson =
      await aiManager.normalizeOntology(
    prompt,
  );

  print(">>> DOPO normalizeOntology");

  print("");
  print("===== NORMALIZED JSON =====");
  print(normalizedJson);
  print("===========================");

  print(">>> PRIMA parser");

  final result = parser.parse(
    normalizedJson,
  );

  print(">>> DOPO parser");

  return result;
}
}