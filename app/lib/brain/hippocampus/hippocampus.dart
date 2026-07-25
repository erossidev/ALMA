import '../working_memory.dart';
import 'consolidation_policy.dart';
import '../dynamics/neuron_dynamics.dart';

class Hippocampus {

  final ConsolidationPolicy _policy =
      ConsolidationPolicy();

  void consolidate(WorkingMemory memory) {

    if (!_policy.shouldConsolidate(memory)) {
      return;
    }

    for (final item in memory.items) {

      NeuronDynamics.reinforce(
        item.neuron,
      );

      NeuronDynamics.consolidate(
        item.neuron,
      );

    }

  }

}