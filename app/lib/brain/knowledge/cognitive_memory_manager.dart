import '../protocol/brain_instruction.dart';
import 'knowledge_model.dart';

class CognitiveMemoryManager {
  const CognitiveMemoryManager();

  BrainInstruction build(
    KnowledgeModel knowledge,
  ) {
    if (knowledge.isEmpty) {
      return const BrainInstruction(
        operation: BrainOperation.ignore,
      );
    }

    return BrainInstruction(
      operation: BrainOperation.store,
      entities: knowledge.entities,
      relations: knowledge.relations,
      facts: knowledge.facts,
    );
  }
}