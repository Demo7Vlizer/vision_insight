import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import './chat_bubble.dart';

class ChatSection extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatSection({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          if (messages.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Chat History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(message: message);
              },
            ),
          ],
        ],
      ),
    );
  }
}
