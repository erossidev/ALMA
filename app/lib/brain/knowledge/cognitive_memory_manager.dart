import '../semantic/learning/semantic_proposal.dart';
import '../protocol/brain_instruction.dart';

import 'brain_mapper.dart';
import 'knowledge_model.dart';

class CognitiveMemoryManager {
  const CognitiveMemoryManager();

Future<BrainInstruction> build({
  required KnowledgeModel knowledge,
  required List<SemanticProposal> proposals,
}) async {
    if (knowledge.isEmpty) {
      return const BrainInstruction(
        operation: BrainOperation.ignore,
      );
    }

    if (proposals.any((p) => p.bestCandidate == null)) {
      return const BrainInstruction(
        operation: BrainOperation.clarify,
      );
    }

    const mapper = BrainMapper();

    return mapper.map(
      operation: BrainOperation.store,
      knowledge: knowledge,
    );
  }
}