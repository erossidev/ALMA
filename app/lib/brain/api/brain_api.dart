import '../neuron.dart';
import '../synapse.dart';

import 'instruction.dart';
import 'instruction_result.dart';

abstract interface class BrainAPI {

  InstructionResult<Neuron> findNeuron(
    String id,
  );

  InstructionResult<Synapse> findSynapse({
    required String sourceId,
    required String relationId,
    required String targetId,
  });

  InstructionResult<void> execute(
    Instruction instruction,
  );

}