import '../models/conversation_model.dart';
import '../protocols/conversation_update_protocol.dart';

abstract class ConversationBuilder {

  Future<ConversationUpdateProtocol> update({

    required String message,

    required ConversationModel conversation,

  });

}