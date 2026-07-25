import '../working_memory.dart';
import 'consolidation_policy.dart';

class Hippocampus {

  final ConsolidationPolicy _policy =
      ConsolidationPolicy();

  void consolidate(WorkingMemory memory) {

    if (!_policy.shouldConsolidate(memory)) {
      return;
    }

    for (final item in memory.items) {

      item.neuron.state.reinforce();

      item.neuron.state.consolidate();

    }

  }

}