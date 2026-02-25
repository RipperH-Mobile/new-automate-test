import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/edit_group_admin_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/remove_group_admin_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_edit_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_edit_controller.dart';

class ChatRoomDetailAdminEditBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as ChatRoomDetailAdminEditArgument;
    Get.put<ChatRoomDetailAdminEditController>(
      ChatRoomDetailAdminEditController(
        args: args,
        editGroupAdminUseCase: GetIt.I<EditGroupAdminUseCase>(),
        removeGroupAdminUseCase: GetIt.I<RemoveGroupAdminUseCase>(),
      ),
      tag: args.roomId,
    );
  }
}
