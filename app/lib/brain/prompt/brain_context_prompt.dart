import '../../core/dialogue/models/conversation_model.dart';

class BrainContextPrompt {
  const BrainContextPrompt._();

  static String build(
    ConversationModel conversation,
  ) {
    return '''
==========================
CONVERSATION CONTEXT
==========================

${conversation.toJson()}
''';
  }
}