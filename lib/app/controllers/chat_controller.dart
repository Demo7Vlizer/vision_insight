import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/openai_service.dart';
import 'image_controller.dart';
import '../models/chat_message.dart';

class ChatController extends GetxController {
  final imageController = Get.find<ImageController>();
  final OpenAIService _openAIService = OpenAIService();
  final messages = <ChatMessage>[].obs;
  final isLoading = false.obs;
  final textController = TextEditingController();

  void clearChat() {
    messages.clear();
    textController.clear();
    isLoading.value = false;
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty || imageController.image.value == null) return;

    debugPrint('Sending message: $text');
    isLoading.value = true;
    
    messages.add(ChatMessage(
      text: text,
      isUser: true,
    ));
    debugPrint('Added user message. Total messages: ${messages.length}');

    try {
      final response = await _openAIService.askQuestionAboutImage(
        imageController.image.value!,
        text,
      );
      debugPrint('Received AI response: $response');
      
      messages.add(ChatMessage(
        text: response,
        isUser: false,
      ));
      debugPrint('Added AI response. Total messages: ${messages.length}');
    } catch (e) {
      debugPrint('Error in sendMessage: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
      textController.clear();
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
