import '../brain.dart';
import '../neuron.dart';
import '../synapse.dart';

import '../repositories/brain_repository.dart';

import '../semantics/semantic_mapper.dart';
import '../semantics/semantic_result.dart';

import '../language/concept.dart';
import '../language/extracted_relation.dart';

class BrainMemoryManager {
  final Brain brain;

  final BrainRepository repository;

  final SemanticMapper _mapper = SemanticMapper();

  BrainMemoryManager({
    required this.brain,
    required this.repository,
  });

  // =====================================================
  // VECCHIO SISTEMA (TEMPORANEO)
  // =====================================================

  Future<void> update({
    required List<Concept> concepts,
    required List<ExtractedRelation> relations,
  }) async {
    print(">>> BrainMemoryManager.update()");

    // ===================================
    // CREA NEURONI
    // ===================================

    for (final concept in concepts) {
      if (brain.containsNeuron(concept.id)) {
        continue;
      }

      final neuron = Neuron(
        id: concept.id,
        label: concept.label,
        type: concept.type,
      );

      brain.addNeuron(neuron);

      await repository.saveNeuron(neuron);
    }

    // ===================================
    // CREA SINAPSI
    // ===================================

    for (final relation in relations) {
      final from = brain.getNeuron(relation.from);
      final to = brain.getNeuron(relation.to);

      if (from == null || to == null) {
        continue;
      }

      final id =
          '${relation.from}_${relation.relationship.name}_${relation.to}';

      if (brain.containsSynapse(id)) {
        continue;
      }

      final synapse = Synapse(
        id: id,
        from: from,
        to: to,
        relationship: relation.relationship,
      );

      brain.connect(synapse);

      await repository.saveSynapse(synapse);
    }

    _debugBrain();

    print(brain);
  }

  // =====================================================
  // NUOVO SISTEMA SEMANTICO
  // =====================================================

  Future<void> updateSemantic(
    SemanticResult semantic,
  ) async {
    print(">>> BrainMemoryManager.updateSemantic()");

    // ===================================
    // CREA NEURONI
    // ===================================

    for (final entity in semantic.entities) {
      if (brain.containsNeuron(entity.id)) {
        continue;
      }

      final neuron = _mapper.toNeuron(entity);

      brain.addNeuron(neuron);

      await repository.saveNeuron(neuron);

      print(">>> SALVO NEURONE: ${neuron.id}");
    }

    // ===================================
    // CREA SINAPSI
    // ===================================

    for (final relation in semantic.relations) {
      final from = brain.getNeuron(relation.from);
      final to = brain.getNeuron(relation.to);

      if (from == null || to == null) {
        continue;
      }

      final synapse = _mapper.toSynapse(
        relation: relation,
        from: from,
        to: to,
      );

      if (brain.containsSynapse(synapse.id)) {
        continue;
      }

      brain.connect(synapse);

      await repository.saveSynapse(synapse);

      print(">>> SALVO SINAPSI: ${synapse.id}");
    }

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
      print("${neuron.id} (${neuron.type.name})");
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