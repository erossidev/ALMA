import '../models/conversation_model.dart';

class ConversationUpdateProtocol {
  final ConversationModel conversation;

  const ConversationUpdateProtocol({
    required this.conversation,
  });

  factory ConversationUpdateProtocol.fromJson(
    Map<String, dynamic> json,
  ) {
    throw UnimplementedError();
  }
}