import '../api/instruction.dart';
import '../api/instruction_result.dart';
import '../context/brain_context.dart';
import '../synapse.dart';

class StoreSynapseInstruction extends BrainInstruction {
  final Synapse synapse;

  const StoreSynapseInstruction({
    required this.synapse,
  });

  @override
  Future<InstructionResult<void>> execute(
    BrainContext context,
  ) async {
    if (!context.brain.containsSynapse(
      synapse.id,
    )) {
      context.brain.connect(
        synapse,
      );

     await context.repository.saveSynapse(
      synapse,
    );

    print(
      ">>> EXECUTOR SALVA SINAPSI: ${synapse.id}",
    );
    }

    return InstructionResult.success();
  }
}