import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Ask something about the image...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                enabled: !isLoading,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          const SizedBox(width: 12),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isLoading ? Colors.grey.shade300 : Colors.blue.shade500,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isLoading 
                    ? Colors.grey.shade200 
                    : Colors.blue.shade200,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: isLoading ? null : onSend,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isLoading ? Icons.hourglass_empty : Icons.send_rounded,
                  key: ValueKey(isLoading),
                  color: Colors.white,
                ),
              ),
              splashRadius: 24,
            ),
          ),
        ],
      ),
    );
  }
} 