import '../memory/brain_memory_manager.dart';

import 'brain_instruction.dart';
import 'brain_result.dart';

class BrainExecutor {
  final BrainMemoryManager brainMemoryManager;

  const BrainExecutor({
    required this.brainMemoryManager,
  });

  Future<BrainResult> execute(
    BrainInstruction instruction,
  ) async {
    switch (instruction.operation) {
      case BrainOperation.store:
        return await brainMemoryManager.store(
          instruction,
        );

      case BrainOperation.replace:
        return await brainMemoryManager.replace(
          instruction,
        );

      case BrainOperation.merge:
        return await brainMemoryManager.merge(
          instruction,
        );

      case BrainOperation.delete:
        return await brainMemoryManager.delete(
          instruction,
        );

      case BrainOperation.reinforce:
        return await brainMemoryManager.reinforce(
          instruction,
        );

      case BrainOperation.clarify:
        return await brainMemoryManager.clarify(
          instruction,
        );

      case BrainOperation.ignore:
        return BrainResult.ignored();
    }
  }
}