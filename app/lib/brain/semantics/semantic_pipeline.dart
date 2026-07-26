import '../../core/ai/ai_manager.dart';

import '../protocol/brain_executor.dart';
import '../protocol/brain_instruction.dart';
import '../protocol/brain_instruction_parser.dart';

import 'semantic_extractor.dart';
import 'semantic_normalizer.dart';
import 'semantic_prompt.dart';

class SemanticPipeline {
  final AIManager aiManager;

  final BrainExecutor brainExecutor;

  final BrainInstructionParser instructionParser =
      const BrainInstructionParser();

  final SemanticExtractor extractor =
      const SemanticExtractor();

  final SemanticNormalizer normalizer =
      const SemanticNormalizer();

  SemanticPipeline({
    required this.aiManager,
    required this.brainExecutor,
  });

  Future<void> process(
    String message,
  ) async {
    // ==========================
    // COSTRUISCE IL PROMPT
    // ==========================

    final prompt =
        SemanticPrompt.build(message);

    print("===== PROMPT SEMANTICO =====");
    print(prompt);

    // ==========================
    // CHIEDE IL JSON ALL'AI
    // ==========================

    final json =
        await aiManager.extractKnowledge(
      prompt,
    );

    print("===== JSON AI =====");
    print(json);

    // ==========================
    // PARSA IL JSON
    // ==========================

    final semantic =
        extractor.parse(json);

    // ==========================
    // NORMALIZZA
    // ==========================

    final normalized =
        normalizer.normalize(
      semantic,
    );

    print("===== SEMANTIC RESULT =====");
    print("Entities : ${normalized.entities.length}");
    print("Relations: ${normalized.relations.length}");
    print("Facts    : ${normalized.facts.length}");

    // ==========================
    // CONVERTE NEL PROTOCOLLO DEL BRAIN
    // ==========================

    final BrainInstruction instruction =
        instructionParser.fromSemantic(
      normalized,
    );

    // ==========================
    // ESEGUE L'ISTRUZIONE
    // ==========================

    await brainExecutor.execute(
      instruction,
    );
  }
}