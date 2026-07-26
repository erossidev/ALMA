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

    // ===================================
    // CREA NEURONI
    // ===================================

    for (final entity in instruction.entities) {
      if (brain.containsNeuron(entity.id)) {
        continue;
      }

      final neuron = Neuron(
        id: entity.id,
        label: entity.label,
        type: entity.type,
      );

      brain.addNeuron(neuron);

      await repository.saveNeuron(
        neuron,
      );

      print(
        ">>> SALVO NEURONE: ${neuron.id}",
      );
    }

    // ===================================
    // CREA SINAPSI
    // ===================================

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

    // ===================================
    // TODO
    // ===================================
    //
    // replace()
    // merge()
    // delete()
    // reinforce()
    //
    // saranno implementati qui.

    _debugBrain();

    print(brain);
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