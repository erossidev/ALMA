import '../../../core/ai/ai_manager.dart';

import 'semantic_advisor.dart';
import 'semantic_learning_prompt.dart';
import 'semantic_learning_request.dart';
import 'semantic_proposal.dart';
import 'semantic_proposal_parser.dart';

class AISemanticAdvisor implements SemanticAdvisor {

  final AIManager aiManager;

  final SemanticLearningPrompt promptBuilder =
      const SemanticLearningPrompt();

  final SemanticProposalParser parser =
      const SemanticProposalParser();

  const AISemanticAdvisor({
    required this.aiManager,
  });

  @override
  Future<SemanticProposal> advise(
    SemanticLearningRequest request,
  ) async {

    // ==========================
    // COSTRUZIONE PROMPT
    // ==========================

    final prompt =
        promptBuilder.build(request);

    print("===== SEMANTIC PROMPT =====");
    print(prompt);

    // ==========================
    // CHIAMATA AI
    // ==========================

    final json =
        await aiManager.classifyLearning(
      prompt,
    );

    print("===== SEMANTIC JSON =====");
    print(json);

    // ==========================
    // PARSING
    // ==========================

    final proposal =
        parser.parse(json);

    return proposal;
  }

}