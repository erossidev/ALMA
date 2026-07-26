import '../brain.dart';
import '../brain_vocabulary.dart';
import '../neuron.dart';
import '../synapse.dart';

import '../protocol/brain_instruction.dart';

import '../repositories/brain_repository.dart';

class BrainMemoryManager {
  final Brain brain;

  final BrainRepository repository;

  BrainMemoryManager({
    required this.brain,
    required this.repository,
  });

  // =====================================================
  // STORE
  // =====================================================

  Future<void> store(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.store()");

    await _storeEntities(
      instruction,
    );

    await _storeRelations(
      instruction,
    );

    _debugBrain();

    print(brain);
  }

   // =====================================================
  // REPLACE
  // =====================================================

  Future<void> replace(
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
    // RIMUOVE LE VECCHIE RELAZIONI
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
  }
  
  // =====================================================
  // MERGE
  // =====================================================

  Future<void> merge(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.merge()");

    // TODO

    _debugBrain();
  }

  // =====================================================
  // DELETE
  // =====================================================

  Future<void> delete(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.delete()");

    // TODO

    _debugBrain();
  }

  // =====================================================
  // REINFORCE
  // =====================================================

  Future<void> reinforce(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.reinforce()");

    // TODO

    _debugBrain();
  }

  // =====================================================
  // CREA NEURONI
  // =====================================================

  Future<void> _storeEntities(
    BrainInstruction instruction,
  ) async {
    for (final entity in instruction.entities) {
      if (brain.containsNeuron(entity.id)) {
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
      final from = brain.getNeuron(
        relation.from,
      );

      final to = brain.getNeuron(
        relation.to,
      );

      if (from == null || to == null) {
        continue;
      }

      final synapse = Synapse(
        id:
            "${relation.from}_${relation.type.name}_${relation.to}",
        from: from,
        to: to,
        relationship: relation.type,
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
  // DEBUG
  // =====================================================

  void _debugBrain() {
    print("");

    print("===== NEURONI =====");

    for (final neuron in brain.neurons) {
      print(
        "${neuron.id} (${neuron.type.name})",
      );
    }

    print("");

    print("===== SINAPSI =====");

    for (final synapse in brain.synapses) {
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