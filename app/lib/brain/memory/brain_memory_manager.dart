import '../brain.dart';
import '../brain_vocabulary.dart';
import '../neuron.dart';
import '../synapse.dart';

import '../protocol/brain_instruction.dart';
import '../protocol/brain_result.dart';

import '../repositories/brain_repository.dart';

import '../conflict/brain_conflict.dart';
import '../conflict/brain_conflict_detector.dart';

import '../reasoning/brain_clarifier.dart';

class BrainMemoryManager {
  final Brain brain;

  final BrainRepository repository;

  final BrainConflictDetector
      _conflictDetector =
          const BrainConflictDetector();

  final BrainClarifier
    _clarifier =
        const BrainClarifier();

  BrainMemoryManager({
    required this.brain,
    required this.repository,
  });

  // =====================================================
  // STORE
  // =====================================================

  Future<BrainResult> store(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.store()");

 final conflict =
    await _detectConflict(
  instruction,
  );

  if (conflict != null) {
    print(
      ">>> CONFLITTO RILEVATO",
    );

    final question =
        await _clarifier.generate(
      conflict,
    );

    return BrainResult.clarification(
      question: question,
      reason: "Single relation conflict",
    );
  }

  await _storeEntities(
    instruction,
  );

  await _storeRelations(
    instruction,
  );

    await _storeRelations(
      instruction,
    );
    

    await _storeRelations(
      instruction,
    );

    _debugBrain();

    print(brain);

    return _success(
      BrainOperation.store,
    );
  }

  // =====================================================
  // REPLACE
  // =====================================================

  Future<BrainResult> replace(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.replace()");

    // -------------------------------------------------
    // CREA EVENTUALI NUOVI NEURONI
    // -------------------------------------------------

    await _storeEntities(
      instruction,
    );

    // -------------------------------------------------
    // ELIMINA LE RELAZIONI PRECEDENTI
    // -------------------------------------------------

    for (final relation in instruction.relations) {
      final removed =
          brain.removeConnections(
        from: relation.from,
        relationship: relation.type,
      );

      for (final synapse in removed) {
        await repository.deleteSynapse(
          synapse.id,
        );

        print(
          ">>> RIMOSSA SINAPSI: ${synapse.id}",
        );
      }
    }

    // -------------------------------------------------
    // CREA LE NUOVE RELAZIONI
    // -------------------------------------------------

    await _storeRelations(
      instruction,
    );

    _debugBrain();

    print(brain);

    return _success(
      BrainOperation.replace,
    );
  }

  // =====================================================
  // MERGE
  // =====================================================

  Future<BrainResult> merge(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.merge()");

    // TODO

    _debugBrain();

    return _success(
      BrainOperation.merge,
    );
  }

  // =====================================================
  // DELETE
  // =====================================================

  Future<BrainResult> delete(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.delete()");

    // TODO

    _debugBrain();

    return _success(
      BrainOperation.delete,
    );
  }

  // =====================================================
  // REINFORCE
  // =====================================================

  Future<BrainResult> reinforce(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.reinforce()");

    // TODO

    _debugBrain();

    return _success(
      BrainOperation.reinforce,
    );
  }

  // =====================================================
  // CLARIFY
  // =====================================================

  Future<BrainResult> clarify(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.clarify()");

    return BrainResult.clarification(
      question:
          instruction.question ?? "",
      reason:
          instruction.reason,
    );
  }

// =====================================================
// RILEVAMENTO CONFLITTI
// =====================================================

  Future<BrainConflict?> _detectConflict(
  BrainInstruction instruction,
) async {
  for (final relation in instruction.relations) {
    final conflict =
        _conflictDetector.detect(
      brain: brain,
      fromId: relation.from,
      relationship: relation.type,
      toId: relation.to,
    );

if (conflict != null) {
  return conflict;
}
  }

  return null;
}

  // =====================================================
  // CREA NEURONI
  // =====================================================

  Future<void> _storeEntities(
    BrainInstruction instruction,
  ) async {
    for (final entity in instruction.entities) {
      if (brain.containsNeuron(
        entity.id,
      )) {
        continue;
      }

      final neuron = Neuron(
        id: entity.id,
        label: entity.label,
        type: entity.type,
      );

      brain.addNeuron(
        neuron,
      );

      await repository.saveNeuron(
        neuron,
      );

      print(
        ">>> SALVO NEURONE: ${neuron.id}",
      );
    }
  }

  // =====================================================
  // CREA SINAPSI
  // =====================================================

  Future<void> _storeRelations(
    BrainInstruction instruction,
  ) async {
    for (final relation in instruction.relations) {
      final from =
          brain.getNeuron(
        relation.from,
      );

      final to =
          brain.getNeuron(
        relation.to,
      );

      if (from == null ||
          to == null) {
        continue;
      }

      final synapse = Synapse(
        id:
            "${relation.from}_${relation.type.name}_${relation.to}",
        from: from,
        to: to,
        relationship:
            relation.type,
      );

      if (brain.containsSynapse(
        synapse.id,
      )) {
        continue;
      }

      brain.connect(
        synapse,
      );

      await repository.saveSynapse(
        synapse,
      );

      print(
        ">>> SALVO SINAPSI: ${synapse.id}",
      );
    }
  }

  // =====================================================
  // SUCCESS
  // =====================================================

  BrainResult _success(
    BrainOperation operation,
  ) {
    return BrainResult.success(
      operation,
    );
  }

  // =====================================================
  // DEBUG
  // =====================================================

  void _debugBrain() {
    print("");

    print("===== NEURONI =====");

    for (final neuron
        in brain.neurons) {
      print(
        "${neuron.id} (${neuron.type.name})",
      );
    }

    print("");

    print("===== SINAPSI =====");

    for (final synapse
        in brain.synapses) {
      print(
        "${synapse.id}"
        " -> ${synapse.relationship.name}"
        " (${synapse.from.label} -> ${synapse.to.label})",
      );
    }

    print("===================");
    print("");
  }
}