import '../models/conversation_model.dart';

class ConversationUpdatePrompt {
  const ConversationUpdatePrompt._();

  static String build({
    required ConversationModel conversation,
    required String message,
  }) {
    return '''
You are the Dialogue System of ALMA.

Your ONLY task is to update the Conversation Model.

You receive:

1. The current Conversation Model.
2. The new user message.

You must understand the message in the context of the existing conversation.

Return ONLY valid JSON.

Current Conversation:

${conversation.toJson()}

User Message:

$message
''';
  }
}