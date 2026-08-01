import '../api/instruction.dart';
import '../api/instruction_result.dart';
import '../context/brain_context.dart';
import '../neuron.dart';

class StoreNeuronInstruction extends BrainInstruction {
  final Neuron neuron;

  const StoreNeuronInstruction({
    required this.neuron,
  });

  @override
  Future<InstructionResult<void>> execute(
    BrainContext context,
  ) async {
    if (!context.brain.containsNeuron(
      neuron.id,
    )) {
      context.brain.addNeuron(
        neuron,
      );

      await context.repository.saveNeuron(
        neuron,
      );
    }

    return InstructionResult.success();
  }
}