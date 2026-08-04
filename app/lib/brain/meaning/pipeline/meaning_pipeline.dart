import '../../core/ai/ai_manager.dart';

import '../knowledge/knowledge_model.dart';

import '../meaning/interpreter/meaning_interpreter.dart';
import '../meaning/model/semantic_parsing_request.dart';
import '../meaning/parser/meaning_parser.dart';
import '../meaning/prompt/semantic_parsing_prompt.dart';

class MeaningPipeline {
  final AIManager aiManager;

  const MeaningPipeline({
    required this.aiManager,
  });

  Future<KnowledgeModel> process(
    String message,
  ) async {

    //--------------------------------------------------
    // Prompt
    //--------------------------------------------------

    final prompt =
        const SemanticParsingPrompt().build(
      SemanticParsingRequest(
        message: message,
      ),
    );

    //--------------------------------------------------
    // AI
    //--------------------------------------------------

    final raw =
        await aiManager.extractMeaning(
      prompt,
    );

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

    return knowledge;
  }
}