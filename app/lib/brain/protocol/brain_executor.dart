import '../memory/brain_memory_manager.dart';
import 'brain_instruction.dart';

class BrainExecutor {
  final BrainMemoryManager brainMemoryManager;

  const BrainExecutor({
    required this.brainMemoryManager,
  });

  Future<void> execute(
    BrainInstruction instruction,
  ) async {
    switch (instruction.operation) {
      case BrainOperation.store:
        await brainMemoryManager.store(
          instruction,
        );
        break;

      case BrainOperation.replace:
        throw UnimplementedError(
          "replace not implemented",
        );

      case BrainOperation.merge:
        throw UnimplementedError(
          "merge not implemented",
        );

      case BrainOperation.delete:
        throw UnimplementedError(
          "delete not implemented",
        );

      case BrainOperation.reinforce:
        throw UnimplementedError(
          "reinforce not implemented",
        );

      case BrainOperation.ignore:
        break;
    }
  }
}