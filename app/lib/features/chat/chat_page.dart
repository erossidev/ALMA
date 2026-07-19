import 'package:flutter/material.dart';

import '../../shared/widgets/alma_button.dart';
import '../../shared/widgets/alma_scaffold.dart';
import '../../shared/widgets/alma_text_field.dart';
import '../../shared/models/chat_message.dart';
import '../../shared/widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  
  final List<ChatMessage> _messages = [];
  
	 void _sendMessage() {
	  final text = _controller.text.trim();

	  if (text.isEmpty) return;

	  setState(() {
		_messages.add(
		  ChatMessage(
			text: text,
			isUser: true,
		  ),
		);

		_messages.add(
		  const ChatMessage(
			text: 'Sto ancora imparando 😊',
			isUser: false,
		  ),
		);
	  });

	  _controller.clear();
	}

  @override
  void dispose() {
    _controller.dispose();
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
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            final message = _messages[index];

            return ChatBubble(
			text: message.text,
			isUser: message.isUser,
			);
          },
        ),
),

          Row(
            children: [
              Expanded(
                child: AlmaTextField(
                  controller: _controller,
                  hintText: 'Scrivi un messaggio...',
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