import 'instruction.dart';

class ExecutionPlan {
  final List<Instruction> instructions;

  const ExecutionPlan({
    required this.instructions,
  });

  bool get isEmpty =>
      instructions.isEmpty;
}