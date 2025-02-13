import 'package:get/get.dart';
import 'package:project_t/app/controllers/chat_controller.dart';
import 'package:project_t/app/controllers/image_controller.dart';

class HomeController extends GetxController {
  late final ChatController chatController;
  late final ImageController imageController;

  @override
  void onInit() {
    super.onInit();
    chatController = Get.find<ChatController>();
    imageController = Get.find<ImageController>();
  }
} 