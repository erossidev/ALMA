import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final String? provider;
  final String? model;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.provider,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser
              ? const Color(0xFF00D5FF)
              : const Color(0xFF1C2541),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.black : Colors.white,
                fontSize: 16,
              ),
            ),

            if (!isUser && provider != null) ...[
              const SizedBox(height: 10),
              Text(
                "🧠 $provider${model != null && model!.isNotEmpty ? " • $model" : ""}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}