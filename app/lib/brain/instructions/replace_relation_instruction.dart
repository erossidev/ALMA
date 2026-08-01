import '../api/instruction.dart';
import '../api/instruction_result.dart';
import '../context/brain_context.dart';
import '../synapse.dart';

class ReplaceRelationInstruction extends BrainInstruction {
  final Synapse synapse;

  const ReplaceRelationInstruction({
    required this.synapse,
  });

  @override
  Future<InstructionResult<void>> execute(
    BrainContext context,
  ) async {

    // Elimina tutte le relazioni dello stesso tipo
    final removed = context.brain.removeConnections(
      from: synapse.from.id,
      relationship: synapse.relationship,
    );

    for (final old in removed) {
      await context.repository.deleteSynapse(
        old.id,
      );

      print(
        ">>> EXECUTOR REMOVE SINAPSI: ${old.id}",
      );
    }

    // Se la nuova non esiste la crea
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
        ">>> EXECUTOR REPLACE SINAPSI: ${synapse.id}",
      );
    }

    return InstructionResult.success();
  }
}