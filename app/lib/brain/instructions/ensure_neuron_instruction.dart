import '../api/instruction.dart';
import '../api/instruction_result.dart';
import '../context/brain_context.dart';
import '../neuron.dart';

class EnsureNeuronInstruction extends BrainInstruction {
  final Neuron neuron;

  const EnsureNeuronInstruction({
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

      print(
        ">>> EXECUTOR REPLACE CREA NEURONE: ${neuron.id}",
      );

    } else {

      print(
        ">>> EXECUTOR REPLACE NEURONE GIÀ ESISTENTE: ${neuron.id}",
      );

    }

    return InstructionResult.success();
  }
}