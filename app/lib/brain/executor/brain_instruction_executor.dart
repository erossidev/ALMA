import '../api/execution_plan.dart';
import '../context/brain_context.dart';

class BrainInstructionExecutor {
  const BrainInstructionExecutor();

  void execute(
    ExecutionPlan plan,
    BrainContext context,
  ) {
    for (final instruction in plan.instructions) {
      instruction.execute(context);
    }
  }
}