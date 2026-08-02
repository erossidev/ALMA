import '../../../core/ai/ai_manager.dart';

import 'semantic_advisor.dart';
import 'semantic_learning_request.dart';
import 'semantic_proposal.dart';

class AISemanticAdvisor implements SemanticAdvisor {

  final AIManager aiManager;

  const AISemanticAdvisor({
    required this.aiManager,
  });

  @override
  Future<SemanticProposal> advise(
    SemanticLearningRequest request,
  ) async {
    throw UnimplementedError();
  }

}