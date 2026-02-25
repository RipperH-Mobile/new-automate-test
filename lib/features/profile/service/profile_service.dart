import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_by_id_use_case.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_invite_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_request.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/find_group_use_case.dart';
import 'package:uchat/features/profile/presentation/arguments/group_profile_arguments.dart';
import 'package:uchat/features/profile/presentation/arguments/profile_arguments.dart';
import 'package:uchat/routes/app_pages.dart';

class ProfileService {
  Future<void> openProfileScreen({
    required String contactId,
    ProfileArgumentsV2? arguments,
  }) async {
    if (contactId == UserController.instance.currentUser.value?.id) {
      Get.toNamed(Routes.myProfile);
    } else {
      Get.toNamed(
        Routes.profile.replaceAll(':id', contactId),
        arguments: arguments,
      );
    }
  }

  Future<void> openGroupProfile({
    required String roomId,
  }) async {
    Get.toNamed(
      Routes.groupProfile.replaceAll(':id', roomId),
    );
  }

  Future<void> openGroupProfileFromNotification({
    required String roomId,
    required List<RoomInviteModel> groupInviteList,
  }) async {
    RoomEntity? room;

    // get groupInviteList from contacts controller
    final roomInviteModel = groupInviteList.firstWhereOrNull((element) => element.id == roomId);

    // if roomInviteModel is not null, use it as room, open profile from group invite notification
    if (roomInviteModel != null) {
      room = roomInviteModel.toRoomCollection().toEntity();
    } else {
      // Fetch room data from local DB
      room = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId));

      if (room == null) {
        final findGroupResponse = await GetIt.I<FindGroupUseCase>().call(
          FindGroupRequest(roomId: roomId),
        );
        room = findGroupResponse?.room.toEntity();
      }
    }

    if (room == null) {
      return;
    }
    Get.toNamed(
      Routes.groupProfile.replaceAll(':id', roomId),
      arguments: GroupProfileArgumentsV2(
        room: room,
      ),
    );
  }
}
