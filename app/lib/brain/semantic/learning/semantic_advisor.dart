import 'semantic_learning_request.dart';
import 'semantic_proposal.dart';

abstract class SemanticAdvisor {

  Future<SemanticProposal> advise(
    SemanticLearningRequest request,
  );

}