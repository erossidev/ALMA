import '../ontology/ontology_reasoner.dart';
import '../protocol/brain_instruction.dart';

import 'brain_mapper.dart';
import 'knowledge_model.dart';

class CognitiveMemoryManager {
  const CognitiveMemoryManager();

  BrainInstruction build({
    required KnowledgeModel knowledge,
    required List<OntologyHypothesis> hypotheses,
  }) {
    if (knowledge.isEmpty) {
      return const BrainInstruction(
        operation: BrainOperation.ignore,
      );
    }

    if (hypotheses.any((h) => h.candidate == null)) {
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