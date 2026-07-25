import '../working_memory.dart';
import 'attention_policy.dart';

class AttentionEngine {
  final AttentionPolicy _policy = AttentionPolicy();

  void update(WorkingMemory memory) {
    memory.sortBy((a, b) {
      final pa = _policy.calculatePriority(a);
      final pb = _policy.calculatePriority(b);

      return pb.compareTo(pa);
    });
  }
}