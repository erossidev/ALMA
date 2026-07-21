class ChatMessage {
  final String text;
  final bool isUser;
  final String? provider;
  final String? model;

  const ChatMessage({
    required this.text,
    required this.isUser,
    this.provider,
    this.model,
  });
}