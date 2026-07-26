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
        await brainMemoryManager.replace(
          instruction,
        );
        break;

      case BrainOperation.merge:
        await brainMemoryManager.merge(
          instruction,
        );
        break;

      case BrainOperation.delete:
        await brainMemoryManager.delete(
          instruction,
        );
        break;

      case BrainOperation.reinforce:
        await brainMemoryManager.reinforce(
          instruction,
        );
        break;

      case BrainOperation.ignore:
        print(">>> Brain: ignore");
        break;
    }
  }
}