enum BrainOperation {
  store,
  replace,
  merge,
  delete,
  ignore,
  reinforce,
}

enum MemoryType {
  semantic,
  episodic,
  working,
  temporary,
  derived,
}

class BrainInstruction {
  final int version;

  final BrainOperation operation;

  final MemoryType memoryType;

  final double confidence;

  final double importance;

  final bool replaceExisting;

  final String reason;

  final List<Map<String, dynamic>> entities;

  final List<Map<String, dynamic>> relations;

  final List<Map<String, dynamic>> facts;

  const BrainInstruction({
    this.version = 1,
    required this.operation,
    required this.memoryType,
    required this.confidence,
    required this.importance,
    required this.replaceExisting,
    required this.reason,
    required this.entities,
    required this.relations,
    required this.facts,
  });
}