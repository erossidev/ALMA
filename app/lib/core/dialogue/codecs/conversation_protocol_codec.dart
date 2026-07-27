import 'dart:convert';

import '../protocols/conversation_update_protocol.dart';

class ConversationProtocolCodec {
  const ConversationProtocolCodec();

  ConversationUpdateProtocol decode(
    String json,
  ) {
    final map = jsonDecode(json) as Map<String, dynamic>;

    return ConversationUpdateProtocol.fromJson(map);
  }

  String encode(
    ConversationUpdateProtocol protocol,
  ) {
    return jsonEncode(
      protocol.toJson(),
    );
  }
}