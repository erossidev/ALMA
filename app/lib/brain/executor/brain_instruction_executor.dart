import '../api/execution_plan.dart';
import '../context/brain_context.dart';

class BrainInstructionExecutor {
  const BrainInstructionExecutor();

  Future<void> execute(
    ExecutionPlan plan,
    BrainContext context,
  ) async {
    for (final instruction in plan.instructions) {
      await instruction.execute(
        context,
      );
    }
  }
}