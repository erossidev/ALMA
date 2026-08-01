import '../brain.dart';
import '../memory/brain_memory_manager.dart';

class BrainContext {
  final Brain brain;

  final BrainMemoryManager memoryManager;

  const BrainContext({
    required this.brain,
    required this.memoryManager,
  });
}