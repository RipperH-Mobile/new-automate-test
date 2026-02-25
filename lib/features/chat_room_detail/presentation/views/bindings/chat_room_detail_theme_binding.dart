import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_theme_controller.dart';

class ChatRoomDetailThemeBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailThemeController>(
      ChatRoomDetailThemeController(tag: tag ,),
      tag: tag,
    );
  }
}
