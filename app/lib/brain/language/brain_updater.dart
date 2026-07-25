import '../brain.dart';
import '../neuron.dart';
import '../synapse.dart';

import 'concept.dart';
import 'extracted_relation.dart';

class BrainUpdater {
  final Brain brain;

  BrainUpdater(this.brain);

  void update({
    required List<Concept> concepts,
    required List<ExtractedRelation> relations,
  }) {
    // Crea i neuroni
    for (final concept in concepts) {
      if (brain.containsNeuron(concept.id)) continue;

      brain.addNeuron(
        Neuron(
          id: concept.id,
          label: concept.label,
          type: concept.type,
        ),
      );
    }

    // Crea le sinapsi
    for (final relation in relations) {
      final from = brain.getNeuron(relation.from);
      final to = brain.getNeuron(relation.to);

      if (from == null || to == null) continue;

      final id =
          '${relation.from}_${relation.relationship.name}_${relation.to}';

      brain.connect(
        Synapse(
          id: id,
          from: from,
          to: to,
          relationship: relation.relationship,
        ),
      );
    }
  }
}