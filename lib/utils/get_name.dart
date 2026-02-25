import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_contact_by_id_sync_use_case.dart';

String getNameHelper({
  required String? id,
  String? fallback = '',
  String? roomId,
}) {
  final finalFallback = 'UNKNOWN'.tr;

  if (id == null) {
    if (fallback != null && fallback.isNotEmpty) {
      return fallback;
    } else {
      return finalFallback;
    }
  }
  if (fallback == null || fallback.isEmpty) {
    fallback = finalFallback;
  }

  final nickName = getNicknameFromAccountId(id) ?? '';

  if (nickName.isNotEmpty) {
    return nickName;
  } else {
    final nameFromAccountId = getDisplayNameFromAccountId(id);
    if (nameFromAccountId != null && nameFromAccountId.isNotEmpty) {
      return nameFromAccountId;
    }

    final nameFromRoom = getDisplayNameFromRoom(roomId, id);
    if (nameFromRoom != null && nameFromRoom.isNotEmpty) {
      return nameFromRoom;
    }

    return fallback;
  }
}

String? getNicknameFromAccountId(String? id) {
  if (id == null) return null;
  return GetIt.I<GetFriendContactByIdSyncUseCase>().call(ContactParams(accountId: id))?.nickname;
}

String? getDisplayNameFromAccountId(String? id) {
  if (id == null) return null;
  return UserController.instance.isCurrentUser(id) ? UserDb().getDisplayNameByIdSync(id) : getAccountNickName(id);
}

String? getDisplayNameFromRoom(String? roomId, String? accountId) {
  if (roomId == null || accountId == null) return null;
  return GetIt.I<RoomMemberDb>().getOneMemberInRoomSync(roomId, accountId)?.account?.displayName;
}

String? getAccountNickName(String id) {
  final account = GetIt.I<GetFriendContactByIdSyncUseCase>().call(ContactParams(accountId: id));
  return account?.nickname ?? account?.displayName;
}

String getMentionNameHelper({
  required String? id,
  String? fallback = '',
  String? roomId,
  bool enableMentionSymbol = false,
}) {
  return mentionName(
    id: enableMentionSymbol ? id : '1',
    name: getNameHelper(
      id: id,
      fallback: fallback,
      roomId: roomId,
    ),
  );
}

String mentionName({
  required String? id,
  required String name,
}) {
  return '&[__${id}__](__${name}__)';
}
