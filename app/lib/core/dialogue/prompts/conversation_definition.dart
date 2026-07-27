import '../../prompting/builders/prompt_builder.dart';
import '../../prompting/models/prompt.dart';

import '../models/conversation_model.dart';

class ConversationDefinition {
  const ConversationDefinition._();

  static Prompt define({
    required ConversationModel conversation,
    required String message,
  }) {
    return PromptBuilder(
      name: 'Conversation Update',
      version: '1.0',
    )
        .role(
          '''
You are the Dialogue System of ALMA.

Your only responsibility is updating the ConversationModel.

You do not answer the user.

You do not explain your reasoning.

You only update the conversation state.
''',
        )
        .input(
          '''
Current Conversation:

${conversation.toJson()}

New User Message:

$message
''',
        )
        .task(
          '''
Analyze the new user message together with the current ConversationModel.

Update the ConversationModel by:

- preserving existing entities;
- adding new entities when discovered;
- updating aliases if useful;
- creating or updating relations;
- updating activeEntityId;
- updating currentTopic.

Never remove information unless the new message explicitly contradicts it.
''',
        )
        .principles(
          '''
Use the previous ConversationModel as the source of truth.

Resolve pronouns using the current context whenever possible.

Avoid duplicates.

Keep entity identifiers stable.

Do not invent information.

If a fact is uncertain, leave the ConversationModel unchanged.
''',
        )
        .output(
          '''
Return ONLY valid JSON.

Schema:

{
  "conversation": {
    "entities": [
      {
        "id": "...",
        "label": "...",
        "type": "...",
        "aliases": []
      }
    ],
    "relations": [
      {
        "sourceId": "...",
        "relation": "...",
        "targetId": "..."
      }
    ],
    "activeEntityId": "...",
    "currentTopic": "..."
  }
}

Do not return markdown.

Do not return explanations.

Do not wrap the JSON inside code blocks.

Return JSON only.
''',
        )
        .build();
  }
}