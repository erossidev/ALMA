import '../api/instruction.dart';
import '../api/instruction_result.dart';
import '../api/instruction_status.dart';
import '../context/brain_context.dart';

class CreateNeuronInstruction extends BrainInstruction {
  const CreateNeuronInstruction();

  @override
    Future<InstructionResult<void>> execute(
      BrainContext context,
    ) async {
      throw UnimplementedError();
    }
}