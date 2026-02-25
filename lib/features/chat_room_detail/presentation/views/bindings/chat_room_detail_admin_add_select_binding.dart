import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_promotable_members_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_add_select_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_add_select_controller.dart';

class ChatRoomDetailAdminAddSelectBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as ChatRoomDetailAdminAddSelectArgument;
    Get.put<ChatRoomDetailAdminAddSelectController>(
      ChatRoomDetailAdminAddSelectController(
        args: args,
        getPromotableMemberUseCase: GetIt.I<GetPromotableMemberUseCase>(),
      ),
      tag: args.roomId,
    );
  }
}
