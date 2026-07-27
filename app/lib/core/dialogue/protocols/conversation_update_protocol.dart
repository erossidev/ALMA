import '../models/conversation_model.dart';

class ConversationUpdateProtocol {
  final ConversationModel conversation;

  const ConversationUpdateProtocol({
    required this.conversation,
  });

  factory ConversationUpdateProtocol.fromJson(
    Map<String, dynamic> json,
  ) {
    return ConversationUpdateProtocol(
      conversation: ConversationModel.fromJson(
        json["conversation"] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "conversation": conversation.toJson(),
    };
  }
}