import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/services/openai_service.dart';
import 'dart:io';
import './chat_controller.dart';

class ImageController extends GetxController {
  final OpenAIService _openAIService = OpenAIService();
  final image = Rx<File?>(null);
  final description = Rx<String?>(null);
  final isLoading = false.obs;
  final _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 84,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final imageSize = await imageFile.length();

        if (imageSize > 10 * 1024 * 1024) {
          Get.snackbar(
            'Error',
            'Image is too large. Please choose a smaller image.',
          );
          return;
        }

        description.value = null;
        Get.find<ChatController>().clearChat();
        image.value = imageFile;
        
        await analyzeImage();
      }
    } catch (e) {
      Get.snackbar('Error', 'Error picking image: $e');
    }
  }

  Future<void> analyzeImage() async {
    if (image.value == null) return;

    isLoading.value = true;
    description.value = null;

    try {
      final result = await _openAIService.analyzeImage(image.value!);
      description.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Error analyzing image: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
