import '../dialogue/models/conversation_model.dart';
import '../../brain/working_memory.dart';

class Thought {
  final String id;

  ConversationModel conversation;

  WorkingMemory workingMemory;

  DateTime lastAccess;

  Thought({
    required this.id,
    required this.conversation,
    required this.workingMemory,
    required this.lastAccess,
  });
}