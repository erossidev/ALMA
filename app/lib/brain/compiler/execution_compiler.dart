import '../api/execution_plan.dart';
import '../brain_vocabulary.dart';
import '../instructions/store_neuron_instruction.dart';
import '../instructions/store_synapse_instruction.dart';
import '../neuron.dart';
import '../protocol/brain_instruction.dart';
import '../synapse.dart';

class ExecutionCompiler {
  const ExecutionCompiler();

  ExecutionPlan compileStore(
    BrainInstruction instruction,
  ) {
    final plan = ExecutionPlan();

    // ==========================================
    // Tabella temporanea dei neuroni
    // ==========================================

    final neurons = <String, Neuron>{};

    // ==========================================
    // Compila i neuroni
    // ==========================================

    for (final entity in instruction.entities) {
      final neuron = Neuron(
        id: entity.id,
        label: entity.label,
        type: entity.type,
      );

      neurons[entity.id] = neuron;

      plan.add(
        StoreNeuronInstruction(
          neuron: neuron,
        ),
      );
    }

    // ==========================================
    // Compila le sinapsi
    // ==========================================

    for (final relation in instruction.relations) {
      final from = neurons[relation.from];
      final to = neurons[relation.to];

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

      plan.add(
        StoreSynapseInstruction(
          synapse: synapse,
        ),
      );
    }

    return plan;
  }
}