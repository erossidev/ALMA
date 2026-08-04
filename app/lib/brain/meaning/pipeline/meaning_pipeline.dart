import '../../../core/ai/ai_manager.dart';

import '../../knowledge/knowledge_model.dart';

import '../interpreter/meaning_interpreter.dart';
import '../parser/meaning_parser.dart';
import '../prompt/semantic_parsing_prompt.dart';
import '../prompt/semantic_parsing_request.dart';

class MeaningPipeline {
  final AIManager aiManager;

  const MeaningPipeline({
    required this.aiManager,
  });

  Future<KnowledgeModel> process(
    String message,
  ) async {
    try {
      //--------------------------------------------------
      // Prompt
      //--------------------------------------------------

      final prompt =
          const SemanticParsingPrompt().build(
        SemanticParsingRequest(
          message: message,
        ),
      );

      print("");
      print("===== MEANING PROMPT =====");
      print(prompt);
      print("==========================");
      print("");

      //--------------------------------------------------
      // AI
      //--------------------------------------------------

      final raw =
          await aiManager.extractMeaning(
        prompt,
      );

      print("");
      print("===== MEANING JSON =====");
      print(raw);
      print("========================");
      print("");

      final json = raw
          .replaceAll("```json", "")
          .replaceAll("```", "")
          .trim();

      //--------------------------------------------------
      // Parser
      //--------------------------------------------------

      final meaning =
          const MeaningParser().parse(
        json,
      );

      //--------------------------------------------------
      // Interpreter
      //--------------------------------------------------

      final knowledge =
          const MeaningInterpreter().interpret(
        meaning,
      );

      //--------------------------------------------------
      // Debug
      //--------------------------------------------------

      print("");
      print("===== MEANING PIPELINE =====");
      print("Entities : ${knowledge.entities.length}");
      print("Relations: ${knowledge.relations.length}");
      print("Facts    : ${knowledge.facts.length}");
      print("============================");
      print("");

      return knowledge;
    } catch (e, stackTrace) {
      print("");
      print("===== MEANING PIPELINE ERROR =====");
      print(e);
      print(stackTrace);
      print("=================================");
      print("");

      rethrow;
    }
  }
}