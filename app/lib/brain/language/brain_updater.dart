import '../brain.dart';
import '../neuron.dart';
import '../synapse.dart';

import '../repositories/brain_repository.dart';

import 'concept.dart';
import 'extracted_relation.dart';

class BrainUpdater {
  final Brain brain;

  final BrainRepository repository;

  BrainUpdater({
    required this.brain,
    required this.repository,
  });

  Future<void> update({
    required List<Concept> concepts,
    required List<ExtractedRelation> relations,
  }) async {

    print(">>> BrainUpdater.update()");
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

      print(">>> Prima di saveNeuron");
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

      print(">>> Prima di saveSynapse");
      await repository.saveSynapse(synapse);
    }
  }
}