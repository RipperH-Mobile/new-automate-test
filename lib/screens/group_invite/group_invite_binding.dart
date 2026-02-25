import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';

import 'group_invite_controller.dart';

class GroupInviteScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GroupInviteController>(GroupInviteController(
      getRoomInviteListUseCase: GetIt.I<GetRoomInviteListUseCase>(),
    ));
  }
}
