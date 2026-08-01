import 'instruction_result.dart';
import '../context/brain_context.dart';

abstract class BrainInstruction {
  const BrainInstruction();
  
Future<InstructionResult<void>> execute(
  BrainContext context,
);
}