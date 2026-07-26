import '../brain.dart';

import 'activation_propagator.dart';
import 'memory_result.dart';


class MemoryRetriever {
  final Brain brain;

  late final ActivationPropagator _propagator =
      ActivationPropagator(brain);


  MemoryRetriever(
    this.brain,
  );


  MemoryResult retrieve(
    List<String> startNeuronIds,
  ) {

    // ==========================
    // NEURONI DI PARTENZA
    // ==========================

    final start = <String>[];


    for (final id in startNeuronIds) {

      if (brain.containsNeuron(id)) {
        start.add(id);
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
        _propagator.propagate(
      start,
    );


    // ==========================
    // SINAPSI COINVOLTE
    // ==========================

    final synapseMap =
        <String, dynamic>{};


    for (final neuron in neurons) {

      for (final synapse
          in brain.getConnections(neuron.id)) {

        synapseMap[synapse.id] = synapse;

      }

    }


    final synapses =
        synapseMap.values.toList();


    return MemoryResult(
      neurons: neurons,
      synapses: synapses.cast(),
    );
  }
}