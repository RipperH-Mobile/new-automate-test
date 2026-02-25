import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_one_member_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_permissions_controller.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_group_permission_use_case.dart';

class ChatRoomDetailGroupPermissionsBinding implements Bindings {
  @override
  void dependencies() {
    final roomId = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.lazyPut<ChatRoomDetailGroupPermissionsController>(
      tag: roomId,
      () => ChatRoomDetailGroupPermissionsController(
        roomId: roomId,
        currentUser: UserController.instance.currentUser.value,
        getGroupPermissionUseCase: GetIt.I<GetGroupPermissionUseCase>(),
        updateGroupPermissionUseCase: GetIt.I<UpdateGroupPermissionUseCase>(),
        watchGroupPermissionUseCase: GetIt.I<WatchGroupPermissionUseCase>(),
        getCurrentMemberUseCase: GetIt.I<GetOneMemberUseCase>(),
      ),
    );
  }
}
