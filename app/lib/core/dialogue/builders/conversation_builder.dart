import '../models/conversation_model.dart';

abstract class ConversationBuilder {
  Future<ConversationModel> update({
    required String message,
    required ConversationModel conversation,
  });
}