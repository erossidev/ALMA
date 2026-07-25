import '../working_memory_item.dart';

class AttentionPolicy {

  double calculatePriority(WorkingMemoryItem item) {

    final state = item.neuron.state;

    return
        state.activation * 0.40 +
        state.importance * 0.30 +
        state.confidence * 0.20 +
        state.emotionalWeight * 0.10;
  }

}