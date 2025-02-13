import 'package:flutter/material.dart';
import 'package:project_t/models/chat_message.dart';
import 'package:project_t/app/widgets/chat_bubble.dart';

class ChatSection extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatSection({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return ChatBubble(message: message);
      },
    );
  }
}
