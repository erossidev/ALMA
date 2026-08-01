import '../api/execution_plan.dart';
import '../instructions/ensure_neuron_instruction.dart';
import '../instructions/replace_relation_instruction.dart';
import '../instructions/store_neuron_instruction.dart';
import '../instructions/store_synapse_instruction.dart';
import '../neuron.dart';
import '../protocol/brain_instruction.dart';
import '../synapse.dart';

class ExecutionCompiler {
  const ExecutionCompiler();

  // ==========================================================
  // STORE
  // ==========================================================

  ExecutionPlan compileStore(
    BrainInstruction instruction,
  ) {
    final plan = ExecutionPlan();

    final neurons = <String, Neuron>{};

    // -----------------------------
    // Neuroni
    // -----------------------------

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

    // -----------------------------
    // Sinapsi
    // -----------------------------

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

  // ==========================================================
  // REPLACE
  // ==========================================================

  ExecutionPlan compileReplace(
    BrainInstruction instruction,
  ) {
    final plan = ExecutionPlan();

    final neurons = <String, Neuron>{};

    // -----------------------------
    // Assicura i neuroni
    // -----------------------------

    for (final entity in instruction.entities) {
      final neuron = Neuron(
        id: entity.id,
        label: entity.label,
        type: entity.type,
      );

      neurons[entity.id] = neuron;

      plan.add(
        EnsureNeuronInstruction(
          neuron: neuron,
        ),
      );
    }

    // -----------------------------
    // Sostituisce le relazioni
    // -----------------------------

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
        ReplaceRelationInstruction(
          synapse: synapse,
        ),
      );
    }

    return plan;
  }
}