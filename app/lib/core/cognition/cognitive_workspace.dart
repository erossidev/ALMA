import '../../brain/working_memory.dart';
import '../dialogue/models/conversation_model.dart';

import 'thought.dart';

class CognitiveWorkspace {
  final List<Thought> thoughts = [];

  Thought? activeThought;

  Thought createThought(
    Thought thought,
  ) {
    thoughts.add(thought);

    activeThought = thought;

    return thought;
  }

  void activate(
    Thought thought,
  ) {
    activeThought = thought;

    thought.lastAccess = DateTime.now();
  }

  Thought getOrCreateThought({
    required ConversationModel conversation,
    required WorkingMemory workingMemory,
  }) {
    if (activeThought != null) {
      return activeThought!;
    }

    final thought = Thought(
      id: "thought_1",
      conversation: conversation,
      workingMemory: workingMemory,
      lastAccess: DateTime.now(),
    );

    createThought(thought);

    return thought;
  }
}