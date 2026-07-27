import 'conversation_builder.dart';
import '../models/conversation_model.dart';
import '../protocols/conversation_update_protocol.dart';
import '../../ai/ai_manager.dart';

class AIConversationBuilder
    implements ConversationBuilder {

  final AIManager ai;

  const AIConversationBuilder({
    required this.ai,
  });

  @override
  Future<ConversationUpdateProtocol> update({

    required String message,

    required ConversationModel conversation,

  }) async {

    throw UnimplementedError();

  }

}