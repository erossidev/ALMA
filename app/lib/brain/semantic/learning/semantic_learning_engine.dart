import 'semantic_advisor.dart';
import 'semantic_learning_request.dart';
import 'semantic_proposal.dart';

class SemanticLearningEngine {

  final SemanticAdvisor advisor;

  const SemanticLearningEngine({
    required this.advisor,
  });

  Future<SemanticProposal> learn(
  SemanticLearningRequest request,
) async {

  final proposal = await advisor.advise(
    request,
  );

  return proposal;

}

}