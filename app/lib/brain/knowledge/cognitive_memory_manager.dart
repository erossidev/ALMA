import '../semantic/learning/semantic_proposal.dart';
import '../protocol/brain_instruction.dart';

import 'brain_mapper.dart';
import 'knowledge_model.dart';



class CognitiveMemoryManager {
  const CognitiveMemoryManager();

  static const double semanticThreshold = 0.80;

Future<BrainInstruction> build({
  required KnowledgeModel knowledge,
  required List<SemanticProposal> proposals,
}) async {

  if (knowledge.isEmpty) {
    return const BrainInstruction(
      operation: BrainOperation.ignore,
    );
  }

  for (final proposal in proposals) {

    final candidate = proposal.bestCandidate;

    if (candidate == null) {
      return BrainInstruction(
        operation: BrainOperation.clarify,
        proposal: proposal,
      );
    }

    final semanticCandidate = candidate;

    if (semanticCandidate.type == "unknown") {
      return BrainInstruction(
        operation: BrainOperation.clarify,
        proposal: proposal,
      );
    }

    if (semanticCandidate.confidence < semanticThreshold) {
      return BrainInstruction(
        operation: BrainOperation.clarify,
        proposal: proposal,
      );
    }

  }

  const mapper = BrainMapper();

  return mapper.map(
    operation: BrainOperation.store,
    knowledge: knowledge,
  );

}
}