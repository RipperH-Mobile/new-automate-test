import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/entities/share_target_entity.dart';
import 'package:uchat/core/domain/params/get_chat_room_for_share_param.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/contact/domain/contact_domain.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/get_name.dart';

// TODO (improve) Improve this to support pagination.
/// Get Chat room data needed for share bottom sheet to display ui and use to call share function to share message
/// to server.
class GetChatRoomForShareUseCase extends UseCase<List<ShareTargetEntity>, GetChatRoomForShareParam> {
  ChatRoomLocalRepository get _chatRoomLocalRepository {
    return GetIt.I<ChatRoomLocalRepository>();
  }

  @override
  Future<Either<Exception, List<ShareTargetEntity>>> call(GetChatRoomForShareParam params) async {
    try {
      final directContact = await GetIt.I<GetFriendContactListUseCase>().call(NoParams());
      final groupContact = await GetIt.I<GetRoomsTypeGroupUseCase>().call(NoParams());
      final oaContact = await GetIt.I<GetOfficialAccountContactUseCase>().call(NoParams());
      List<ShareTargetEntity> roomList = [];

      /// Get room subscription list result from repository.
      for (final contact in directContact) {
        if (contact.id == null) {
          continue;
        }
        String? roomId = await _chatRoomLocalRepository.getDirectRoomIdByOtherIdInRoom(contact.id!);
        final room = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId ?? ''));
        final String name = contact.name ?? getNameHelper(id: contact.id!);

        roomList.add(
          ShareTargetEntity(
            roomId: roomId ?? '',
            name: name,
            avatarUrl: contact.avatarUrl,
            status: contact.statusMessage,
            contactId: contact.id,
            roomCryptoKey: await room?.getRoomCryptoKeyObj(),
          ),
        );
      }

      if (groupContact != null) {
        final permissionList =
            await _chatRoomLocalRepository.getGroupPermissionWithIds(groupContact.map((e) => e.id!).toList());
        final permissionMap = {for (var item in permissionList) item.roomId: item};
        for (final contact in groupContact) {
          if ((params.hasMediaType && permissionMap[contact.id]?.canSendMedia == false) ||
              (params.hasMessageType && permissionMap[contact.id]?.canSendMessages == false)) {
            continue;
          }
          if (contact.id != null) {
            roomList.add(
              ShareTargetEntity(
                roomId: contact.id!,
                name: contact.roomName ?? '',
                avatarUrl: contact.photoId != null ? FileService().getFileUrl(contact.photoId!) : null,
                groupMemberCount: contact.memberCount,
                roomCryptoKey: await contact.getRoomCryptoKeyObj(),
              ),
            );
          }
        }
      }

      for (final contact in oaContact) {
        final roomId = await GetIt.I<RoomMemberDb>().getDirectRoomIdByOtherIdInRoom(contact.id!);
        if (roomId != null) {
          roomList.add(
            ShareTargetEntity(
              roomId: roomId,
              name: contact.nickname ?? contact.displayName ?? '',
              avatarUrl: contact.avatarUrl,
              status: contact.statusMessage,
              isOa: true,
            ),
          );
        }
      }

      return Right(roomList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e));
    }
  }
}
