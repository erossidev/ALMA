import '../protocol/brain_instruction.dart';

/// ==========================================================
/// KNOWLEDGE MODEL
///
/// Rappresenta la conoscenza estratta dall'LLM.
/// Non contiene decisioni cognitive.
/// Non contiene operazioni del Brain.
/// Contiene solamente:
/// - entità
/// - relazioni
/// - facts
/// ==========================================================

class KnowledgeModel {
  final List<BrainEntity> entities;

  final List<BrainRelation> relations;

  final List<BrainFact> facts;

  const KnowledgeModel({
    this.entities = const [],
    this.relations = const [],
    this.facts = const [],
  });

  bool get isEmpty =>
      entities.isEmpty &&
      relations.isEmpty &&
      facts.isEmpty;

  bool get isNotEmpty => !isEmpty;
}