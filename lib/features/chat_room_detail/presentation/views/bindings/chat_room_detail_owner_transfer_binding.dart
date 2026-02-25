import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/chat_room_detail_barrel.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_owner_transfer_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_owner_transfer_controller.dart';

class ChatRoomDetailOwnerTransferBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as ChatRoomDetailOwnerTransferArgument;
    Get.put<ChatRoomDetailOwnerTransferController>(
      ChatRoomDetailOwnerTransferController(
        args: args,
        getCurrentMemberUseCase: GetIt.I<GetOneMemberUseCase>(),
      ),
      tag: args.roomId,
    );
  }
}
