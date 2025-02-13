import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_t/openai_service.dart';
import 'image_controller.dart';
import 'package:project_t/models/chat_message.dart';

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

    isLoading.value = true;
    messages.add(ChatMessage(
      text: text,
      isUser: true,
    ));

    try {
      final response = await _openAIService.askQuestionAboutImage(
        imageController.image.value!,
        text,
      );
      messages.add(ChatMessage(
        text: response,
        isUser: false,
      ));
    } catch (e) {
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
