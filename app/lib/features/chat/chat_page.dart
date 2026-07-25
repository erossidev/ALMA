import 'package:flutter/material.dart';

import '../../shared/models/chat_message.dart';
import '../../shared/widgets/alma_button.dart';
import '../../shared/widgets/alma_scaffold.dart';
import '../../shared/widgets/alma_text_field.dart';
import '../../shared/widgets/chat_bubble.dart';
import '../../shared/widgets/typing_indicator.dart';
import '../../core/services/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final ChatService _chatService = ChatService();

  final List<ChatMessage> _messages = [];

  bool _isTyping = false;

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
        ),
      );

      _isTyping = true;
    });

    _controller.clear();

    _scrollToBottom();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    final response = await _chatService.sendMessage(text);

    if (!mounted) return;

    setState(() {
      _isTyping = false;

      _messages.add(
        ChatMessage(
          text: response.reply,
          isUser: false,
          provider: response.provider,
          model: response.model,
        ),
      );
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaScaffold(
      title: 'Chat con ALMA',
      child: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text(
                      '👋\n\nCiao!\nSono ALMA.\n\nCome posso aiutarti oggi?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (_isTyping && index == _messages.length) {
                        return const TypingIndicator();
                      }

                      final message = _messages[index];

                      return ChatBubble(
                        text: message.text,
                        isUser: message.isUser,
                        provider: message.provider,
                        model: message.model,
                      );
                    },
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: AlmaTextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  hintText: 'Scrivi un messaggio...',
                  onSubmitted: _sendMessage,
                ),
              ),
              const SizedBox(width: 12),
              AlmaButton(
                text: 'Invia',
                width: 100,
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}