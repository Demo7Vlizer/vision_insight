import 'package:get/get.dart';
import '../controllers/search_image_controller.dart';
import '../../../controllers/chat_controller.dart';
import '../../../controllers/image_controller.dart';
// import '../../../services/emoji_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // First initialize services
    // Get.put(EmojiService(), permanent: true);

    // Then controllers that depend on services
    Get.put(ImageController());
    Get.put(ChatController());
    Get.put(HomeController());
  }
}
