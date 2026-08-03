import '../../ai/ai_manager.dart';

import '../../prompting/models/prompt.dart';
import '../../prompting/renderers/prompt_renderer.dart';

import '../codecs/conversation_protocol_codec.dart';
import '../models/conversation_model.dart';
import '../prompts/conversation_definition.dart';
import '../protocols/conversation_update_protocol.dart';

import 'conversation_builder.dart';

class AIConversationBuilder implements ConversationBuilder {
  final AIManager ai;

  final PromptRenderer renderer;

  final ConversationProtocolCodec codec;

  const AIConversationBuilder({
    required this.ai,
    this.renderer = const PromptRenderer(),
    this.codec = const ConversationProtocolCodec(),
  });

  @override
Future<ConversationModel> update({
  required ConversationModel conversation,
  required String message,
}) async {

  final prompt = _buildPrompt(
    conversation: conversation,
    message: message,
  );

  final json = await _executePrompt(prompt);

  final trimmed = json.trim();

  if (trimmed == "{}") {
    return conversation;
  }

  try {

    final protocol = _parseProtocol(json);

    if (protocol.conversation == null) {
      return conversation;
    }

    return protocol.conversation;

  } catch (e) {

    print("===== DIALOGUE PARSE ERROR =====");
    print(e);
    print("Raw JSON:");
    print(json);
    print("===============================");

    return conversation;

  }

}

  Prompt _buildPrompt({
    required ConversationModel conversation,
    required String message,
  }) {
    return ConversationDefinition.define(
      conversation: conversation,
      message: message,
    );
  }

  Future<String> _executePrompt(
    Prompt prompt,
  ) async {
    final renderedPrompt = renderer.render(prompt);

    final response = await ai.generateResponse(
      renderedPrompt,
    );

  print("========== RAW DIALOGUE ==========");
  print(response.reply);
  print("=================================");


    return response.reply;
  }

  ConversationUpdateProtocol _parseProtocol(
    String json,
  ) {
    return codec.decode(json);
  }
}