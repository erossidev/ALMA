import '../../core/ai/ai_manager.dart';

import 'learning_decision.dart';
import 'learning_extractor.dart';
import 'learning_prompt.dart';

import '../semantic/learning/semantic_learning_engine.dart';
import '../semantic/learning/semantic_advisor.dart';

class LearningPipeline {
  final AIManager aiManager;

  final LearningExtractor extractor =
      const LearningExtractor();

  LearningPipeline({
    required this.aiManager,
  });

  Future<LearningDecision> process(
    String message,
  ) async {

    // ==========================
    // COSTRUISCE IL PROMPT
    // ==========================

    final prompt =
        LearningPrompt.build(message);

    print("===== LEARNING PROMPT =====");
    print(prompt);

    // ==========================
    // CHIEDE LA DECISIONE ALL'AI
    // ==========================

    final json =
        await aiManager.classifyLearning(
      prompt,
    );

    print("===== LEARNING JSON =====");
    print(json);

    // ==========================
    // PARSE
    // ==========================

    final decision =
        extractor.parse(json);

    print("===== LEARNING RESULT =====");
    print(
      "Should Learn : ${decision.shouldLearn}",
    );
    print(
      "Reason       : ${decision.reason}",
    );

    return decision;
  }
}