import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/domain/entities/share_target_entity.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRecentChatRoomForShareParam {
  // Whether this sharing has message type content. Used for filtering rooms without send message permission.
  bool hasMessageType;

  // Whether this sharing has media type content. Used for filtering rooms without send media permission.
  bool hasMediaType;
  int limit;

  GetRecentChatRoomForShareParam({
    required this.hasMessageType,
    required this.hasMediaType,
    this.limit = 5,
  });
}

class GetRecentChatRoomForShareUseCase extends SimpleUseCase<List<ShareTargetEntity>, GetRecentChatRoomForShareParam> {
  final ChatRoomLocalRepository chatRoomLocalRepository;
  final FileService fileService;

  GetRecentChatRoomForShareUseCase(this.chatRoomLocalRepository, this.fileService);

  @override
  Future<List<ShareTargetEntity>> call(GetRecentChatRoomForShareParam param) async {
    List<ShareTargetEntity> result = [];
    int page = 1;
    int totalPage = 0;
    // Get initial room sub list. This will filter out room subs that user has no permission to share to.
    final roomSubList = await _getAndFilterRoomSubList(page, param);
    totalPage = roomSubList.totalPages;
    final data = roomSubList.data?.toList() ?? [];

    // Loop query until result has enough data or no more data.
    bool haveMoreData = page < totalPage;
    while (data.length < param.limit && haveMoreData) {
      page += 1;
      final roomSubResult = await _getAndFilterRoomSubList(page, param);
      totalPage = roomSubResult.totalPages;
      final newData = roomSubResult.data;
      if (newData == null || newData.isEmpty) break;
      data.addAll(newData);
      if (data.length >= param.limit) {
        break;
      }
      haveMoreData = page < totalPage;
    }

    if (data.isEmpty) {
      return [];
    }

    // Limit data to requested limit.
    final finalRoomSubList = data.take(param.limit).toList();

    // Get room data for avatar url.
    final roomList = await chatRoomLocalRepository.getRooms(
      finalRoomSubList.map((e) => e.roomId!).toList(),
    );

    // Get member data for direct rooms.
    final directRoomSubs = finalRoomSubList.where((rs) => rs.isDirect).toList();
    final otherMembersMap = await _getOtherMembersMap(directRoomSubs);

    // Convert data to ShareTargetEntity.
    for (final roomSub in finalRoomSubList) {
      final room = roomList?.firstWhereOrNull((e) => e.id == roomSub.roomId);
      result.add(
        _toShareTargetEntity(roomSub, room, otherMembersMap[room?.id]),
      );
    }

    return result;
  }

  // Get room sub list and filter out room subs that user has no permission to share to.
  Future<PaginationPayload<RoomSubscriptionEntity>> _getAndFilterRoomSubList(
    int page,
    GetRecentChatRoomForShareParam param,
  ) async {
    final roomSubResult = await chatRoomLocalRepository.getRoomSubCanShowInShare(
      page: page,
      pageSize: param.limit * 2, // Get more data to filter out later.
    );
    final newData = roomSubResult.data?.toList();

    // Find group room subs.
    final newGroupList = newData?.where((element) => element.isGroup).toList();
    if (newGroupList?.isNotEmpty == true) {
      // Query permission data.
      final newPermissionList =
          await chatRoomLocalRepository.getGroupPermissionWithIds(newGroupList!.map((e) => e.roomId!).toList());
      // Filter out groups without permissions to share to.
      for (final perm in newPermissionList) {
        final roomSub = newGroupList.firstWhereOrNull((e) => e.roomId == perm.roomId);
        if (roomSub != null) {
          if ((param.hasMediaType && perm.canSendMedia == false) ||
              (param.hasMessageType && perm.canSendMessages == false)) {
            newData?.removeWhere((e) => e.roomId == roomSub.roomId);
          }
        }
      }
    }

    if (newData != null) {
      return PaginationPayload(
        data: newData,
        total: roomSubResult.total,
        page: roomSubResult.page,
        pageSize: roomSubResult.pageSize,
        totalPages: roomSubResult.totalPages,
      );
    }
    return roomSubResult;
  }

  Future<Map<String, RoomMemberEntity>> _getOtherMembersMap(List<RoomSubscriptionEntity> directRoomSubs) async {
    if (directRoomSubs.isEmpty) return {};
    final directRoomIds = directRoomSubs.map((rs) => rs.roomId!).toList();
    final otherMembers = await chatRoomLocalRepository.getAllFirstOtherInRoom(roomIds: directRoomIds);
    return {for (var member in otherMembers ?? []) member.roomId: member};
  }

  ShareTargetEntity _toShareTargetEntity(RoomSubscriptionEntity roomSub, RoomEntity? room, RoomMemberEntity? member) {
    String? avatarUrl;
    bool? isOa;
    int? memberCount;
    if (room?.isDirectRoom == true) {
      avatarUrl = member?.account.avatarUrl;
      isOa = member?.account.isOfficial;
    } else if (room?.photoId != null) {
      avatarUrl = GetIt.I<FileService>().getFileUrl(room!.photoId!);
      memberCount = room.memberCount;
    }
    return ShareTargetEntity(
      roomId: roomSub.roomId!,
      name: room?.roomName ?? roomSub.roomName ?? 'UNKNOWN'.tr,
      avatarUrl: avatarUrl,
      isOa: isOa,
      groupMemberCount: memberCount,
    );
  }
}
