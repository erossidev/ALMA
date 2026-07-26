import '../../core/ai/ai_manager.dart';

import '../protocol/brain_executor.dart';
import '../protocol/brain_instruction.dart';
import '../protocol/brain_instruction_parser.dart';
import '../protocol/brain_instruction_prompt.dart';

class KnowledgePipeline {
  final AIManager aiManager;

  final BrainExecutor brainExecutor;

  final BrainInstructionParser instructionParser =
      const BrainInstructionParser();

  KnowledgePipeline({
    required this.aiManager,
    required this.brainExecutor,
  });

  Future<void> process(
    String message,
  ) async {
    // =====================================================
    // COSTRUISCE IL PROMPT DEL BRAIN
    // =====================================================

    final prompt =
        BrainInstructionPrompt.build(
      message,
    );

    print("");
    print("===== BRAIN PROMPT =====");
    print(prompt);

    // =====================================================
    // CHIEDE ALL'AI UNA BRAIN INSTRUCTION
    // =====================================================

    final rawJson =
        await aiManager.extractKnowledge(
      prompt,
    );

    print("");
    print("===== BRAIN JSON =====");
    print(rawJson);

    // =====================================================
    // RIMUOVE EVENTUALI WRAPPER MARKDOWN
    // =====================================================

    final json = rawJson
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();

    // =====================================================
    // PARSA JSON -> BRAIN INSTRUCTION
    // =====================================================

    try {
      final BrainInstruction instruction =
          instructionParser.parse(
        json,
      );

      print("");
      print("===== BRAIN INSTRUCTION =====");
      print("Operation : ${instruction.operation.name}");
      print("Memory    : ${instruction.memoryType.name}");
      print("Confidence: ${instruction.confidence}");
      print("Importance: ${instruction.importance}");
      print("Entities  : ${instruction.entities.length}");
      print("Relations : ${instruction.relations.length}");
      print("Facts     : ${instruction.facts.length}");
      print("");

      await brainExecutor.execute(
        instruction,
      );
    } catch (e, stackTrace) {
      print("");
      print("===== BRAIN PIPELINE ERROR =====");
      print(e);
      print(stackTrace);
      print("================================");
      print("");
    }
  }
}