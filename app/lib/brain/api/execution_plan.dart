import 'instruction.dart';

class ExecutionPlan {
  final List<BrainInstruction> _instructions = [];

  ExecutionPlan();

  List<BrainInstruction> get instructions =>
      List.unmodifiable(_instructions);

  bool get isEmpty => _instructions.isEmpty;

  bool get isNotEmpty => _instructions.isNotEmpty;

  int get length => _instructions.length;

  void add(
    BrainInstruction instruction,
  ) {
    _instructions.add(instruction);
  }

  void addAll(
    Iterable<BrainInstruction> instructions,
  ) {
    _instructions.addAll(instructions);
  }
}