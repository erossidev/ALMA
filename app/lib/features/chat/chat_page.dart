import 'package:flutter/material.dart';

import '../../shared/widgets/alma_button.dart';
import '../../shared/widgets/alma_scaffold.dart';
import '../../shared/widgets/alma_text_field.dart';
import '../../shared/models/chat_message.dart';

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

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Align(
                alignment: message.isUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: message.isUser
                        ? const Color(0xFF00D5FF)
                        : const Color(0xFF1C2541),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
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