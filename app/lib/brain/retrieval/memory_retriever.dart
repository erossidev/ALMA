import '../brain.dart';

import '../language/concept_extractor.dart';

import 'activation_propagator.dart';
import 'memory_result.dart';

class MemoryRetriever {
  final Brain brain;

  late final ActivationPropagator _propagator =
      ActivationPropagator(brain);

  final ConceptExtractor _extractor =
      ConceptExtractor();

  MemoryRetriever(this.brain);

  MemoryResult retrieve(String question) {
    // ==========================
    // ESTRAE I CONCETTI
    // ==========================

    final concepts =
        _extractor.extract(question);

    // ==========================
    // CERCA I NEURONI
    // ==========================

    final start = <String>[];

    for (final concept in concepts) {
      if (brain.containsNeuron(concept.id)) {
        start.add(concept.id);
      }
    }

    // fallback importante
    if (start.isEmpty &&
        brain.containsNeuron("user")) {
      start.add("user");
    }

    // ==========================
    // PROPAGAZIONE
    // ==========================

    final neurons =
        _propagator.propagate(start);

    // ==========================
    // SINAPSI COINVOLTE
    // ==========================

    final synapses = <dynamic>[];

    for (final neuron in neurons) {
      synapses.addAll(
        brain.getConnections(neuron.id),
      );
    }

    return MemoryResult(
      neurons: neurons,
      synapses: synapses.cast(),
    );
  }
}