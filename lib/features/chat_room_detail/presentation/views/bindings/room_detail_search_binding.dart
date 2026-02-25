import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/room_detail_search_controller.dart';

class RoomDetailSearchBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<RoomDetailSearchController>(
      RoomDetailSearchController(roomId: tag),
      tag: tag,
    );
  }
}
