import 'instruction.dart';

class ExecutionPlan {
  final List<BrainInstruction> instructions;

  const ExecutionPlan({
    required this.instructions,
  });

  bool get isEmpty =>
      instructions.isEmpty;
}