import '../api/execution_plan.dart';
import '../neuron.dart';
import '../instructions/store_neuron_instruction.dart';
import '../protocol/brain_instruction.dart';

class ExecutionCompiler {
  const ExecutionCompiler();

  ExecutionPlan compileStore(
    BrainInstruction instruction,
  ) {
    final plan = ExecutionPlan();

    for (final entity in instruction.entities) {
      final neuron = Neuron(
        id: entity.id,
        label: entity.label,
        type: entity.type,
      );

      plan.add(
        StoreNeuronInstruction(
          neuron: neuron,
        ),
      );
    }

    return plan;
  }
}