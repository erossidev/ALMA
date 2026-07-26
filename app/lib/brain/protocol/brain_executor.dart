import '../memory/brain_memory_manager.dart';
import '../semantics/semantic_result.dart';

class BrainExecutor {
  final BrainMemoryManager brainMemoryManager;

  const BrainExecutor({
    required this.brainMemoryManager,
  });

  Future<void> executeSemantic(
    SemanticResult semantic,
  ) async {
    await brainMemoryManager.updateSemantic(
      semantic,
    );
  }
}