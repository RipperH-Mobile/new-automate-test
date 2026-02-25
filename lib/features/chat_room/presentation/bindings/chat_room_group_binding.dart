import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_group_controller.dart';

class ChatRoomGroupBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomGroupController>(
      ChatRoomGroupController(
        tag: tag,
        messageLocalRepository: GetIt.I<MessageLocalRepository>(),
      ),
      tag: tag,
    );
  }
}
