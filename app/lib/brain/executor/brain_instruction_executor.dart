import '../api/brain_api.dart';
import '../api/execution_plan.dart';

class BrainInstructionExecutor {

  final BrainAPI api;

  const BrainInstructionExecutor({
    required this.api,
  });

  void execute(
    ExecutionPlan plan,
  ) {

    for (final instruction
        in plan.instructions) {

      api.execute(
        instruction,
      );

    }

  }

}