import '../brain_vocabulary.dart';

/// ==========================================================
/// OPERAZIONI DEL BRAIN
/// ==========================================================

enum BrainOperation {
  store,
  replace,
  merge,
  delete,
  reinforce,
  ignore,
}

/// ==========================================================
/// TIPO DI MEMORIA
/// ==========================================================

enum MemoryType {
  semantic,
  episodic,
  working,
  temporary,
  derived,
}

/// ==========================================================
/// PROTOCOLLO DEL BRAIN
///
/// È l'unico formato che il Brain conosce.
/// Qualunque AI deve produrre questo protocollo.
/// ==========================================================

class BrainInstruction {
  /// Versione del protocollo
  final int version;

  /// Operazione richiesta
  final BrainOperation operation;

  /// Tipo di memoria
  final MemoryType memoryType;

  /// Fiducia dell'AI (0.0 - 1.0)
  final double confidence;

  /// Importanza della memoria
  final double importance;

  /// Motivazione dell'operazione
  final String? reason;

  /// Entità coinvolte
  final List<BrainEntity> entities;

  /// Relazioni
  final List<BrainRelation> relations;

  /// Fact
  final List<BrainFact> facts;

  const BrainInstruction({
    this.version = 1,
    required this.operation,
    this.memoryType = MemoryType.semantic,
    this.confidence = 1.0,
    this.importance = 1.0,
    this.reason,
    this.entities = const [],
    this.relations = const [],
    this.facts = const [],
  });
}

/// ==========================================================
/// ENTITY
/// ==========================================================

class BrainEntity {
  final String id;

  final String label;

  final EntityType type;

  const BrainEntity({
    required this.id,
    required this.label,
    required this.type,
  });
}

/// ==========================================================
/// RELATION
/// ==========================================================

class BrainRelation {
  final String from;

  final String to;

  final RelationshipType type;

  const BrainRelation({
    required this.from,
    required this.to,
    required this.type,
  });
}

/// ==========================================================
/// FACT
/// ==========================================================

class BrainFact {
  final String id;

  final String entityId;

  final FactType type;

  final String value;

  const BrainFact({
    required this.id,
    required this.entityId,
    required this.type,
    required this.value,
  });
}