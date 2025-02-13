import 'package:flutter/material.dart';
import 'package:project_t/models/chat_message.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;

  const ChatInput({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Ask anything about the image...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[600],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: isLoading ? null : onSend,
              icon: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.send_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 12,
          left: message.isUser ? 50 : 16,
          right: message.isUser ? 16 : 50,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue[600] : Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 15,
            color: message.isUser ? Colors.white : Colors.black87,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class ChatSection extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatSection({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.blue[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.yellow[100],
                size: 24,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Ask anything about this image!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (messages.isNotEmpty) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: messages.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return ChatBubble(message: messages[index]);
            },
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
