import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/chat_room_detail_barrel.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_all_admin_and_owner_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_controller.dart';

class ChatRoomDetailAdminBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as ChatRoomDetailAdminArgument;
    Get.put<ChatRoomDetailAdminController>(
      ChatRoomDetailAdminController(
        args: args,
        getAllAdminAndOwnerUseCase: GetIt.I<GetAllAdminAndOwnerUseCase>(),
        removeGroupAdminUseCase: GetIt.I<RemoveGroupAdminUseCase>(),
        getCurrentMemberUseCase: GetIt.I<GetOneMemberUseCase>(),
      ),
      tag: args.roomId,
    );
  }
}
